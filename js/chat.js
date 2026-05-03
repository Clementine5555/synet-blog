// =============================================
// SYNET — CHAT.JS
// AI Ocean Q&A Widget
// Calls Netlify Function /api/ocean-ai
// which proxies to Anthropic API
// =============================================

let chatHistory = [];
let isChatLoading = false;

// =============================================
// SEND MESSAGE (from input field)
// =============================================
async function sendMessage() {
  const input = document.getElementById('chatInput');
  const text  = input?.value.trim();
  if (!text || isChatLoading) return;

  input.value = '';
  input.style.height = 'auto';
  hideSuggestions();
  appendUserMsg(text);
  await askAI(text);
}

// =============================================
// SEND SUGGESTION (quick prompt buttons)
// =============================================
function sendSuggestion(btn) {
  const text = btn.textContent.trim();
  hideSuggestions();
  appendUserMsg(text);
  askAI(text);
}

function hideSuggestions() {
  const s = document.getElementById('chatSuggestions');
  if (s) s.style.display = 'none';
}

// =============================================
// APPEND MESSAGES
// =============================================
function appendUserMsg(text) {
  const el = document.createElement('div');
  el.className = 'chat-msg chat-msg-user';
  el.textContent = text;
  getChatMessages().appendChild(el);
  scrollChat();
  chatHistory.push({ role: 'user', content: text });
}

function appendBotMsg(text) {
  const el = document.createElement('div');
  el.className = 'chat-msg chat-msg-bot';
  el.textContent = text;
  getChatMessages().appendChild(el);
  scrollChat();
  chatHistory.push({ role: 'assistant', content: text });
}

function appendTyping() {
  const el = document.createElement('div');
  el.className = 'chat-msg chat-msg-bot chat-msg-typing';
  el.id = 'typingIndicator';
  el.innerHTML = `
    <span class="typing-dot"></span>
    <span class="typing-dot"></span>
    <span class="typing-dot"></span>`;
  getChatMessages().appendChild(el);
  scrollChat();
  return el;
}

function removeTyping() {
  document.getElementById('typingIndicator')?.remove();
}

function getChatMessages() {
  return document.getElementById('chatMessages');
}

function scrollChat() {
  const msgs = getChatMessages();
  if (msgs) msgs.scrollTop = msgs.scrollHeight;
}

// =============================================
// SET LOADING STATE
// =============================================
function setChatLoading(state) {
  isChatLoading = state;
  const btn = document.getElementById('chatSendBtn');
  const input = document.getElementById('chatInput');
  if (btn)   btn.disabled = state;
  if (input) input.disabled = state;
}

// =============================================
// CALL NETLIFY FUNCTION → ANTHROPIC API
// =============================================
async function askAI(userMessage) {
  setChatLoading(true);
  const typing = appendTyping();

  try {
    const response = await fetch('/.netlify/functions/ocean-ai', {
      method:  'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({
        message: userMessage,
        history: chatHistory.slice(-8), // last 4 turns for context
        lang:    getLang(),
      }),
    });

    removeTyping();

    if (!response.ok) {
      throw new Error(`HTTP ${response.status}`);
    }

    const data = await response.json();
    const reply = data.reply || getFallbackReply(getLang());
    appendBotMsg(reply);

  } catch (err) {
    removeTyping();
    // If Netlify function isn't set up yet, show a helpful message
    const lang = getLang();
    const msg = lang === 'id'
      ? 'Maaf, AI sedang tidak tersedia. Pastikan ANTHROPIC_API_KEY sudah diisi di Netlify Environment Variables.'
      : 'AI is not available right now. Make sure ANTHROPIC_API_KEY is set in Netlify Environment Variables.';
    appendBotMsg(msg);
    console.error('Synet AI error:', err);
  } finally {
    setChatLoading(false);
  }
}

// Fallback if API isn't configured
function getFallbackReply(lang) {
  const replies = {
    en: "I'm having trouble connecting right now. Check that the Anthropic API key is configured in Netlify.",
    id: "Koneksi sedang bermasalah. Pastikan API key Anthropic sudah dikonfigurasi di Netlify.",
  };
  return replies[lang] || replies.en;
}
