// =============================================
// SYNET — netlify/functions/ocean-ai.js
// Serverless proxy for Groq API (FREE)
// Keeps API key server-side (never exposed)
//
// Deploy: set GROQ_API_KEY in
// Netlify → Site Settings → Environment Variables
// Get free key at: https://console.groq.com
// =============================================

exports.handler = async function(event) {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: JSON.stringify({ error: 'Method not allowed' }) };
  }

  let body;
  try {
    body = JSON.parse(event.body);
  } catch {
    return { statusCode: 400, body: JSON.stringify({ error: 'Invalid JSON body' }) };
  }

  const { message, history = [], lang = 'en' } = body;

  if (!message || typeof message !== 'string') {
    return { statusCode: 400, body: JSON.stringify({ error: 'Missing message field' }) };
  }

  const apiKey = process.env.GROQ_API_KEY;
  if (!apiKey) {
    return { statusCode: 500, body: JSON.stringify({ error: 'GROQ_API_KEY not configured' }) };
  }

  const systemPrompt = `You are Synet AI, an ocean science expert assistant embedded in Synet — a bilingual (Indonesian/English) ocean science blog.

Your role:
- Answer questions about marine biology, oceanography, ocean chemistry, deep sea exploration, marine conservation, and ocean climate science.
- Be accurate, curious, and educational. Cite well-known findings when relevant.
- Keep answers concise: 2–4 short paragraphs maximum. This is a chat widget, not a lecture.
- If asked about something unrelated to oceans or marine science, politely redirect and suggest an ocean-related question instead.
- Match the user's language: if they write in Indonesian, reply in Indonesian. If English, reply in English. Current UI language hint: "${lang}".
- Never make up facts. If uncertain, say so and suggest NOAA, MBARI, WWF Ocean, or Synet's own articles.
- Be warm, engaging, and convey genuine wonder about the ocean.

You represent Synet's values: accuracy, accessibility, and conservation-mindedness.`;

  const messages = [
    { role: 'system', content: systemPrompt },
    ...history
      .filter(m => m.role && m.content && m.role !== 'system')
      .slice(-8)
      .map(m => ({ role: m.role, content: m.content })),
    { role: 'user', content: message },
  ];

  try {
    const response = await fetch('https://api.groq.com/openai/v1/chat/completions', {
      method:  'POST',
      headers: {
        'Content-Type':  'application/json',
        'Authorization': `Bearer ${apiKey}`,
      },
      body: JSON.stringify({
        model:       'llama-3.3-70b-versatile',
        max_tokens:  600,
        temperature: 0.7,
        messages,
      }),
    });

    if (!response.ok) {
      const err = await response.text();
      console.error('Groq API error:', response.status, err);
      return { statusCode: 502, body: JSON.stringify({ error: 'Upstream API error', detail: response.status }) };
    }

    const data  = await response.json();
    const reply = data.choices?.[0]?.message?.content || '';

    return {
      statusCode: 200,
      headers:    { 'Content-Type': 'application/json' },
      body:       JSON.stringify({ reply }),
    };

  } catch (err) {
    console.error('Function error:', err);
    return { statusCode: 500, body: JSON.stringify({ error: 'Internal function error' }) };
  }
};
