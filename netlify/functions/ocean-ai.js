// =============================================
// SYNET — netlify/functions/ocean-ai.js
// Serverless proxy for Anthropic API
// Keeps API key server-side (never exposed)
//
// Deploy: set ANTHROPIC_API_KEY in
// Netlify → Site Settings → Environment Variables
// =============================================

exports.handler = async function(event) {
  // Only allow POST
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method not allowed' }),
    };
  }

  // Parse body
  let body;
  try {
    body = JSON.parse(event.body);
  } catch {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Invalid JSON body' }),
    };
  }

  const { message, history = [], lang = 'en' } = body;

  if (!message || typeof message !== 'string') {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Missing message field' }),
    };
  }

  const apiKey = process.env.ANTHROPIC_API_KEY;
  if (!apiKey) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'ANTHROPIC_API_KEY not configured' }),
    };
  }

  // System prompt — ocean-focused, bilingual
  const systemPrompt = `You are Synet AI, an ocean science expert assistant embedded in Synet — a bilingual (Indonesian/English) ocean science blog.

Your role:
- Answer questions about marine biology, oceanography, ocean chemistry, deep sea exploration, marine conservation, and ocean climate science.
- Be accurate, curious, and educational. Cite well-known findings when relevant.
- Keep answers concise: 2–4 short paragraphs maximum. This is a chat widget, not a lecture.
- If asked about something unrelated to oceans or marine science, politely redirect: explain you're specialized in ocean topics and suggest what ocean-related question they might ask instead.
- Match the user's language: if they write in Indonesian (Bahasa Indonesia), reply in Indonesian. If they write in English, reply in English. Current UI language hint: "${lang}".
- Never make up facts. If uncertain, say so and suggest where they could learn more (e.g., NOAA, MBARI, WWF Ocean, or Synet's own articles).
- Be warm, engaging, and convey genuine wonder about the ocean.

You represent Synet's values: accuracy, accessibility, and conservation-mindedness.`;

  // Build messages array (include history for context)
  const messages = [
    ...history
      .filter(m => m.role && m.content)
      .slice(-8)
      .map(m => ({ role: m.role, content: m.content })),
    { role: 'user', content: message },
  ];

  try {
    const response = await fetch('https://api.anthropic.com/v1/messages', {
      method:  'POST',
      headers: {
        'Content-Type':      'application/json',
        'x-api-key':         apiKey,
        'anthropic-version': '2023-06-01',
      },
      body: JSON.stringify({
        model:      'claude-sonnet-4-20250514',
        max_tokens: 600,
        system:     systemPrompt,
        messages,
      }),
    });

    if (!response.ok) {
      const err = await response.text();
      console.error('Anthropic API error:', response.status, err);
      return {
        statusCode: 502,
        body: JSON.stringify({ error: 'Upstream API error', detail: response.status }),
      };
    }

    const data  = await response.json();
    const reply = data.content?.[0]?.text || '';

    return {
      statusCode: 200,
      headers:    { 'Content-Type': 'application/json' },
      body:       JSON.stringify({ reply }),
    };

  } catch (err) {
    console.error('Function error:', err);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Internal function error' }),
    };
  }
};
