// =============================================
// SYNET — CONFIG
// Isi ketiga nilai ini setelah dapat credentials
// =============================================

const SYNET_CONFIG = {
  // Supabase — dari: https://supabase.com → project → Settings → API
  SUPABASE_URL:      "YOUR_SUPABASE_URL",
  SUPABASE_ANON_KEY: "YOUR_SUPABASE_ANON_KEY",

  // Anthropic — dari: https://console.anthropic.com → API Keys
  // PENTING: ini untuk Netlify Function, bukan langsung di frontend
  // Isi di Netlify → Site Settings → Environment Variables → ANTHROPIC_API_KEY
  // Variabel di bawah hanya untuk referensi, tidak diekspos ke browser
  ANTHROPIC_MODEL: "claude-sonnet-4-20250514",

  // Site info
  SITE_NAME:    "Synet",
  SITE_TAGLINE_EN: "Science · Sea · Internet",
  SITE_TAGLINE_ID: "Sains · Samudra · Internet",
  SITE_URL:     "https://your-site.netlify.app", // ganti setelah deploy

  // Pagination
  ARTICLES_PER_PAGE: 9,
  FEATURED_COUNT:    3,
};
