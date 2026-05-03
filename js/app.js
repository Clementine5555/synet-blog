// =============================================
// SYNET — APP.JS
// Shared logic: language, nav, scroll,
// card renderers, toast, reveal animations
// =============================================

// =============================================
// LANGUAGE SYSTEM
// =============================================
const TRANSLATIONS = {
  en: {
    // Nav
    'nav.home': 'Home', 'nav.articles': 'Articles', 'nav.about': 'About', 'nav.contact': 'Contact',
    'skip': 'Skip to content',

    // Hero
    'hero.overline': 'Ocean Science · Bilingual',
    'hero.title1': 'The ocean holds', 'hero.title2': "95% of Earth's", 'hero.title3': 'living space.',
    'hero.subtitle': "Synet explores the science, life, and future of the world's oceans — in Indonesian and English. From bioluminescent depths to rising seas.",
    'hero.cta1': 'Explore Articles', 'hero.cta2': 'About Synet',
    'hero.imgcaption': 'Pacific Ocean · 1,200m depth', 'hero.scroll': 'scroll',

    // Stats
    'stats.earth': "of Earth's surface", 'stats.depth': 'deepest point',
    'stats.species': 'known species', 'stats.unexplored': 'still unexplored', 'stats.articles': 'articles published',

    // Section labels
    'featured.label': 'Featured Stories', 'featured.title': 'From the Deep', 'featured.viewall': 'View all articles →',
    'latest.label': 'Latest', 'latest.title': 'Recent Discoveries', 'latest.viewall': 'View all →',
    'cat.label': 'Browse by Topic', 'cat.title': 'Five Worlds, One Ocean',

    // Categories
    'cat.marine': 'Marine Life', 'cat.science': 'Ocean Science', 'cat.conservation': 'Conservation',
    'cat.deepsea': 'Deep Sea', 'cat.climate': 'Ocean & Climate',

    // Newsletter
    'newsletter.label': 'Stay Informed', 'newsletter.title': 'Dive deeper,\nevery week.',
    'newsletter.desc': 'Ocean science, conservation updates, and deep sea discoveries — delivered to your inbox.',
    'newsletter.placeholder': 'your@email.com', 'newsletter.btn': 'Subscribe',
    'newsletter.note': 'By subscribing, you agree to our Privacy Policy.',

    // Articles page
    'articles.overline': 'Synet Archive', 'articles.title': 'All Articles',
    'articles.search': 'Search articles...', 'articles.showing': 'Showing all articles',
    'filter.all': 'All',

    // Article reader
    'article.share': 'Share:', 'article.filed': 'Filed under',
    'article.authordesc': 'Ocean science writers dedicated to making marine research accessible to everyone.',
    'article.back': 'Back to all articles', 'article.related': 'Related Articles',
    'article.askAI': 'Have a question?',
    'article.askAIdesc': 'Ask Synet AI about anything you just read.',
    'article.askAIbtn': 'Ask Synet AI 🌊',
    'article.morelabel': 'Keep Exploring', 'article.more': 'More from Synet',

    // About page
    'about.overline': 'Our Story', 'about.title': 'Where Science\nMeets the Sea',
    'about.subtitle': 'Synet is a bilingual ocean science publication born from a simple belief: the ocean is the most important thing on Earth, and most people know almost nothing about it.',
    'about.missionlabel': 'Our Mission', 'about.missiontitle': 'Why Synet Exists',
    'about.missiondesc': "The ocean covers 71% of our planet, produces half our oxygen, absorbs a third of our carbon, and feeds billions of people. Yet ocean literacy remains dangerously low. Synet bridges the gap between peer-reviewed science and public understanding — in two languages.",
    'about.m1title': 'Science, Translated', 'about.m1desc': 'We take complex peer-reviewed research and translate it into readable, accurate stories — without dumbing it down.',
    'about.m2title': 'Bilingual by Design', 'about.m2desc': "Every article on Synet is fully available in both Indonesian and English.",
    'about.m3title': 'Conservation-Driven', 'about.m3desc': 'We believe that understanding the ocean is the first step to protecting it.',
    'about.numberlabel': 'By the Numbers', 'about.numbertitle': 'Synet at a Glance',
    'about.n1': 'Original articles', 'about.n2': 'Languages (EN + ID)', 'about.n3': 'Ocean topics covered', 'about.n4': 'Ocean left to explore',
    'about.teamlabel': 'The Team', 'about.teamtitle': "Who's Behind Synet",
    'about.role.editor': 'Editor in Chief', 'about.role.science': 'Science Writer',
    'about.role.conservation': 'Conservation Editor', 'about.role.design': 'Design & Technology',
    'about.jointeam': "Passionate about oceans? We're always looking for contributors.", 'about.joincta': 'Get in Touch',
    'about.valueslabel': 'What We Stand For', 'about.valuestitle': 'Our Editorial Principles',
    'about.v1title': 'Accuracy First', 'about.v1desc': 'Every claim is sourced to peer-reviewed research. We correct errors promptly and transparently.',
    'about.v2title': 'No Sensationalism', 'about.v2desc': "The ocean is extraordinary enough without exaggeration. We present facts clearly.",
    'about.v3title': 'Open & Free', 'about.v3desc': 'All Synet content is free to read, forever.',
    'about.ctalabel': 'Ready to dive in?', 'about.ctatitle': 'Start Exploring',
    'about.ctadesc': '15 articles across 5 ocean topics, fully bilingual.',

    // Contact page
    'contact.overline': 'Get in Touch', 'contact.title': "We'd love to hear\nfrom you.",
    'contact.subtitle': 'Whether you have a story tip, want to contribute, spotted an error, or just want to talk about the ocean.',
    'contact.infotitle': 'Contact Information',
    'contact.infodesc': "We're a small editorial team passionate about ocean science. We try to respond within 2–3 business days.",
    'contact.email': 'Email', 'contact.location': 'Location', 'contact.locationval': 'Indonesia & Remote',
    'contact.response': 'Response Time', 'contact.responseval': '2–3 business days',
    'contact.topicslabel': "What we're happy to hear about",
    'contact.t1': 'Story tips & research you want covered', 'contact.t2': 'Corrections or factual feedback',
    'contact.t3': 'Contributor pitches & collaborations', 'contact.t4': 'Partnership & sponsorship inquiries',
    'contact.t5': 'Just want to talk about the ocean',
    'contact.social': 'Follow Synet',
    'contact.formtitle': 'Send us a message',
    'contact.name': 'Full Name *', 'contact.nameph': 'Your name', 'contact.emaill': 'Email *',
    'contact.subject': 'Subject *', 'contact.subjectph': 'Select a topic...',
    'contact.sub1': 'Story Tip', 'contact.sub2': 'Correction / Feedback',
    'contact.sub3': 'Contribute / Write for Us', 'contact.sub4': 'Partnership / Sponsorship', 'contact.sub5': 'Other',
    'contact.message': 'Message *', 'contact.messageph': "Tell us what's on your mind...",
    'contact.consent': "I agree to Synet's Privacy Policy and consent to being contacted.",
    'contact.submit': 'Send Message',
    'contact.formfooter': 'This is a demonstration form. Connect to Netlify Forms or Formspree in production.',
    'contact.faqLabel': 'FAQ', 'contact.faqTitle': 'Common Questions',
    'contact.faq1q': 'Can I write for Synet?',
    'contact.faq1a': "Yes! We're always open to pitches. Send a brief pitch via the contact form — include your topic idea, angle, and a writing sample.",
    'contact.faq2q': 'How is Synet funded?',
    'contact.faq2a': 'Synet is currently self-funded and independent. All content is free to read.',
    'contact.faq3q': 'I found a factual error. What should I do?',
    'contact.faq3a': 'Please tell us immediately. Use the contact form, select "Correction / Feedback," and include the article title and the specific claim.',
    'contact.faq4q': 'Can I republish Synet content?',
    'contact.faq4a': 'All Synet content is protected by copyright. Republication requires written permission.',

    // Footer
    'footer.desc': "Science, Sea, and the Internet. A bilingual ocean science publication exploring the world's most vital and least understood ecosystem.",
    'footer.col.explore': 'Explore', 'footer.col.synet': 'Synet', 'footer.col.legal': 'Legal',
    'footer.allart': 'All Articles', 'footer.newsletter': 'Newsletter',
    'footer.privacy': 'Privacy Policy', 'footer.terms': 'Terms of Use',
    'footer.cookie': 'Cookie Policy', 'footer.sources': 'Data Sources',
    'footer.rights': 'All rights reserved.', 'footer.builtby': 'Built with curiosity & caffeine 🌊',

    // Chat
    'chat.hint': 'Ask me about the ocean 🌊',
    'chat.status': 'Ocean expert, always online',
    'chat.welcome': "Hi! I'm Synet AI 🌊 Ask me anything about oceans, marine life, or climate science.",
    'chat.s1': 'How deep is the ocean?', 'chat.s2': 'What is bioluminescence?', 'chat.s3': 'Why is the sea salty?',
    'chat.placeholder': 'Ask about the ocean...',
  },

  id: {
    // Nav
    'nav.home': 'Beranda', 'nav.articles': 'Artikel', 'nav.about': 'Tentang', 'nav.contact': 'Kontak',
    'skip': 'Lewati ke konten',

    // Hero
    'hero.overline': 'Sains Kelautan · Bilingual',
    'hero.title1': 'Lautan menampung', 'hero.title2': '95% ruang hidup', 'hero.title3': 'di Bumi.',
    'hero.subtitle': 'Synet menjelajahi sains, kehidupan, dan masa depan samudra dunia — dalam Bahasa Indonesia dan Inggris. Dari kedalaman bioluminesen hingga naiknya permukaan laut.',
    'hero.cta1': 'Jelajahi Artikel', 'hero.cta2': 'Tentang Synet',
    'hero.imgcaption': 'Samudra Pasifik · Kedalaman 1.200m', 'hero.scroll': 'gulir',

    // Stats
    'stats.earth': 'permukaan Bumi', 'stats.depth': 'titik terdalam',
    'stats.species': 'spesies diketahui', 'stats.unexplored': 'belum dieksplorasi', 'stats.articles': 'artikel diterbitkan',

    // Sections
    'featured.label': 'Pilihan Utama', 'featured.title': 'Dari Kedalaman', 'featured.viewall': 'Lihat semua artikel →',
    'latest.label': 'Terbaru', 'latest.title': 'Penemuan Terkini', 'latest.viewall': 'Lihat semua →',
    'cat.label': 'Jelajahi Berdasarkan Topik', 'cat.title': 'Lima Dunia, Satu Samudra',

    // Categories
    'cat.marine': 'Kehidupan Laut', 'cat.science': 'Sains Samudra', 'cat.conservation': 'Konservasi',
    'cat.deepsea': 'Laut Dalam', 'cat.climate': 'Laut & Iklim',

    // Newsletter
    'newsletter.label': 'Tetap Terinformasi', 'newsletter.title': 'Menyelam lebih dalam,\nsetiap minggu.',
    'newsletter.desc': 'Sains kelautan, pembaruan konservasi, dan penemuan laut dalam — langsung ke kotak masukmu.',
    'newsletter.placeholder': 'email@kamu.com', 'newsletter.btn': 'Berlangganan',
    'newsletter.note': 'Dengan berlangganan, kamu setuju dengan Kebijakan Privasi kami.',

    // Articles page
    'articles.overline': 'Arsip Synet', 'articles.title': 'Semua Artikel',
    'articles.search': 'Cari artikel...', 'articles.showing': 'Menampilkan semua artikel',
    'filter.all': 'Semua',

    // Article reader
    'article.share': 'Bagikan:', 'article.filed': 'Kategori',
    'article.authordesc': 'Penulis sains kelautan yang berdedikasi untuk membuat riset laut dapat diakses semua orang.',
    'article.back': 'Kembali ke semua artikel', 'article.related': 'Artikel Terkait',
    'article.askAI': 'Punya pertanyaan?',
    'article.askAIdesc': 'Tanya Synet AI tentang apa saja yang baru kamu baca.',
    'article.askAIbtn': 'Tanya Synet AI 🌊',
    'article.morelabel': 'Terus Jelajahi', 'article.more': 'Lebih Banyak dari Synet',

    // About
    'about.overline': 'Kisah Kami', 'about.title': 'Di Mana Sains\nBertemu Laut',
    'about.subtitle': 'Synet adalah publikasi sains kelautan bilingual yang lahir dari keyakinan sederhana: laut adalah hal terpenting di Bumi, dan kebanyakan orang hampir tidak tahu apa-apa tentangnya.',
    'about.missionlabel': 'Misi Kami', 'about.missiontitle': 'Mengapa Synet Ada',
    'about.missiondesc': 'Lautan menutupi 71% planet kita, menghasilkan setengah oksigen kita, menyerap sepertiga karbon kita, dan memberi makan miliaran orang. Namun kesadaran tentang laut masih sangat rendah. Synet menjembatani kesenjangan antara riset ilmiah dan pemahaman publik — dalam dua bahasa.',
    'about.m1title': 'Sains, Diterjemahkan', 'about.m1desc': 'Kami mengambil riset ilmiah yang kompleks dan menerjemahkannya menjadi cerita yang mudah dibaca dan akurat.',
    'about.m2title': 'Bilingual Sejak Awal', 'about.m2desc': 'Setiap artikel di Synet tersedia sepenuhnya dalam Bahasa Indonesia dan Inggris.',
    'about.m3title': 'Berpusat pada Konservasi', 'about.m3desc': 'Kami percaya bahwa memahami laut adalah langkah pertama untuk melindunginya.',
    'about.numberlabel': 'Dalam Angka', 'about.numbertitle': 'Synet Sekilas',
    'about.n1': 'Artikel original', 'about.n2': 'Bahasa (EN + ID)', 'about.n3': 'Topik laut yang dibahas', 'about.n4': 'Laut yang belum dijelajahi',
    'about.teamlabel': 'Tim Kami', 'about.teamtitle': 'Di Balik Synet',
    'about.role.editor': 'Pemimpin Redaksi', 'about.role.science': 'Penulis Sains',
    'about.role.conservation': 'Editor Konservasi', 'about.role.design': 'Desain & Teknologi',
    'about.jointeam': 'Bersemangat soal laut? Kami selalu mencari kontributor.', 'about.joincta': 'Hubungi Kami',
    'about.valueslabel': 'Yang Kami Perjuangkan', 'about.valuestitle': 'Prinsip Editorial Kami',
    'about.v1title': 'Akurasi Utama', 'about.v1desc': 'Setiap klaim bersumber dari riset peer-reviewed. Kami mengoreksi kesalahan dengan cepat dan transparan.',
    'about.v2title': 'Tanpa Sensasionalisme', 'about.v2desc': 'Laut sudah luar biasa tanpa berlebihan. Kami menyajikan fakta dengan jelas.',
    'about.v3title': 'Terbuka & Gratis', 'about.v3desc': 'Semua konten Synet gratis untuk dibaca, selamanya.',
    'about.ctalabel': 'Siap menyelam?', 'about.ctatitle': 'Mulai Menjelajahi',
    'about.ctadesc': '15 artikel dalam 5 topik laut, sepenuhnya bilingual.',

    // Contact
    'contact.overline': 'Hubungi Kami', 'contact.title': 'Kami senang\nmendengar dari kamu.',
    'contact.subtitle': 'Apakah kamu punya tips cerita, ingin berkontribusi, menemukan kesalahan, atau hanya ingin bicara tentang laut.',
    'contact.infotitle': 'Informasi Kontak',
    'contact.infodesc': 'Kami adalah tim editorial kecil yang bersemangat tentang sains kelautan. Kami berusaha merespons dalam 2–3 hari kerja.',
    'contact.email': 'Email', 'contact.location': 'Lokasi', 'contact.locationval': 'Indonesia & Remote',
    'contact.response': 'Waktu Respons', 'contact.responseval': '2–3 hari kerja',
    'contact.topicslabel': 'Apa yang senang kami dengar',
    'contact.t1': 'Tips cerita & riset yang ingin kamu liput', 'contact.t2': 'Koreksi atau masukan fakta',
    'contact.t3': 'Pitch kontributor & kolaborasi', 'contact.t4': 'Pertanyaan kemitraan & sponsor',
    'contact.t5': 'Hanya ingin bicara tentang laut',
    'contact.social': 'Ikuti Synet',
    'contact.formtitle': 'Kirim pesan kepada kami',
    'contact.name': 'Nama Lengkap *', 'contact.nameph': 'Namamu', 'contact.emaill': 'Email *',
    'contact.subject': 'Subjek *', 'contact.subjectph': 'Pilih topik...',
    'contact.sub1': 'Tips Cerita', 'contact.sub2': 'Koreksi / Masukan',
    'contact.sub3': 'Kontribusi / Tulis untuk Kami', 'contact.sub4': 'Kemitraan / Sponsor', 'contact.sub5': 'Lainnya',
    'contact.message': 'Pesan *', 'contact.messageph': 'Ceritakan apa yang ada di pikiranmu...',
    'contact.consent': 'Saya setuju dengan Kebijakan Privasi Synet dan bersedia untuk dihubungi.',
    'contact.submit': 'Kirim Pesan',
    'contact.formfooter': 'Ini adalah formulir demonstrasi. Hubungkan ke Netlify Forms atau Formspree untuk produksi.',
    'contact.faqLabel': 'FAQ', 'contact.faqTitle': 'Pertanyaan Umum',
    'contact.faq1q': 'Bisakah saya menulis untuk Synet?',
    'contact.faq1a': 'Ya! Kami selalu terbuka untuk pitch. Kirim pitch singkat melalui formulir kontak di atas.',
    'contact.faq2q': 'Bagaimana Synet didanai?',
    'contact.faq2a': 'Synet saat ini didanai sendiri dan independen. Semua konten gratis untuk dibaca.',
    'contact.faq3q': 'Saya menemukan kesalahan fakta. Apa yang harus dilakukan?',
    'contact.faq3a': 'Tolong beritahu kami segera. Gunakan formulir kontak dan pilih "Koreksi / Masukan."',
    'contact.faq4q': 'Bisakah saya menerbitkan ulang konten Synet?',
    'contact.faq4a': 'Semua konten Synet dilindungi hak cipta. Penerbitan ulang memerlukan izin tertulis.',

    // Footer
    'footer.desc': 'Sains, Samudra, dan Internet. Publikasi sains kelautan bilingual yang menjelajahi ekosistem paling penting di dunia.',
    'footer.col.explore': 'Jelajahi', 'footer.col.synet': 'Synet', 'footer.col.legal': 'Legal',
    'footer.allart': 'Semua Artikel', 'footer.newsletter': 'Newsletter',
    'footer.privacy': 'Kebijakan Privasi', 'footer.terms': 'Ketentuan Penggunaan',
    'footer.cookie': 'Kebijakan Cookie', 'footer.sources': 'Sumber Data',
    'footer.rights': 'Semua hak dilindungi.', 'footer.builtby': 'Dibangun dengan rasa ingin tahu & kopi 🌊',

    // Chat
    'chat.hint': 'Tanya aku soal laut 🌊',
    'chat.status': 'Ahli laut, selalu online',
    'chat.welcome': 'Hai! Aku Synet AI 🌊 Tanya aku apa saja tentang laut, kehidupan laut, atau sains iklim.',
    'chat.s1': 'Seberapa dalam laut?', 'chat.s2': 'Apa itu bioluminesensi?', 'chat.s3': 'Mengapa laut asin?',
    'chat.placeholder': 'Tanya tentang laut...',
  }
};

// =============================================
// LANG HELPERS
// =============================================
function getLang() {
  return localStorage.getItem('synet-lang') || 'en';
}

function setLang(lang) {
  localStorage.setItem('synet-lang', lang);
  document.documentElement.setAttribute('lang', lang);
  document.documentElement.setAttribute('data-lang', lang);

  // Update lang buttons
  document.querySelectorAll('.lang-btn').forEach(btn => {
    const isActive = btn.dataset.lang === lang;
    btn.classList.toggle('active', isActive);
    btn.setAttribute('aria-pressed', isActive);
  });

  applyTranslations(lang);
  document.dispatchEvent(new CustomEvent('langChange', { detail: { lang } }));
}

function applyTranslations(lang) {
  const t = TRANSLATIONS[lang] || TRANSLATIONS.en;

  // Text content
  document.querySelectorAll('[data-i18n]').forEach(el => {
    const key = el.dataset.i18n;
    if (t[key] !== undefined) el.textContent = t[key];
  });

  // Placeholders
  document.querySelectorAll('[data-i18n-placeholder]').forEach(el => {
    const key = el.dataset.i18nPlaceholder;
    if (t[key] !== undefined) el.placeholder = t[key];
  });
}

// =============================================
// NAV SCROLL SHADOW + HAMBURGER
// =============================================
function initNav() {
  const nav = document.getElementById('mainNav');
  const hamburger = document.getElementById('hamburger');
  const mobileNav = document.getElementById('mobileNav');

  if (nav) {
    window.addEventListener('scroll', () => {
      nav.classList.toggle('scrolled', window.scrollY > 10);
    }, { passive: true });
  }

  if (hamburger && mobileNav) {
    hamburger.addEventListener('click', () => {
      const open = hamburger.classList.toggle('open');
      mobileNav.classList.toggle('open', open);
      hamburger.setAttribute('aria-expanded', open);
      mobileNav.setAttribute('aria-hidden', !open);
    });

    // Close on outside click
    document.addEventListener('click', e => {
      if (!nav.contains(e.target) && !mobileNav.contains(e.target)) {
        hamburger.classList.remove('open');
        mobileNav.classList.remove('open');
        hamburger.setAttribute('aria-expanded', false);
        mobileNav.setAttribute('aria-hidden', true);
      }
    });
  }
}

// =============================================
// SCROLL REVEAL
// =============================================
function initReveal() {
  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.classList.add('visible');
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.1, rootMargin: '0px 0px -40px 0px' });

  document.querySelectorAll('.reveal, .reveal-stagger').forEach(el => observer.observe(el));
}

// =============================================
// TOAST NOTIFICATIONS
// =============================================
function showToast(msg, type = '') {
  const container = document.getElementById('toastContainer');
  if (!container) return;

  const toast = document.createElement('div');
  toast.className = `toast${type ? ' toast-' + type : ''}`;
  toast.textContent = msg;
  container.appendChild(toast);

  setTimeout(() => {
    toast.style.opacity = '0';
    toast.style.transition = 'opacity 0.3s';
    setTimeout(() => toast.remove(), 300);
  }, 3000);
}

// =============================================
// CARD RENDERERS
// Shared across index, articles, article pages
// =============================================

// Category badge class helper
function getCatBadge(slug) {
  const map = {
    'marine-life':   'badge-marine',
    'ocean-science': 'badge-science',
    'conservation':  'badge-conservation',
    'deep-sea':      'badge-deepsea',
    'ocean-climate': 'badge-climate',
  };
  return map[slug] || 'badge-marine';
}

// Category display name helper
function getCatName(slug, lang) {
  const map = {
    'marine-life':   { en: 'Marine Life',    id: 'Kehidupan Laut' },
    'ocean-science': { en: 'Ocean Science',  id: 'Sains Samudra' },
    'conservation':  { en: 'Conservation',   id: 'Konservasi' },
    'deep-sea':      { en: 'Deep Sea',       id: 'Laut Dalam' },
    'ocean-climate': { en: 'Ocean & Climate',id: 'Laut & Iklim' },
  };
  return map[slug]?.[lang] || slug;
}

// Format date
function formatDate(iso, lang) {
  return new Date(iso).toLocaleDateString(lang === 'id' ? 'id-ID' : 'en-US', {
    year: 'numeric', month: 'short', day: 'numeric'
  });
}

// Regular article card (3-column grid)
function articleCardRegular(a, lang) {
  const title   = lang === 'id' ? a.title_id   : a.title_en;
  const excerpt = lang === 'id' ? a.excerpt_id : a.excerpt_en;
  const badge   = getCatBadge(a.category_slug);
  const catName = getCatName(a.category_slug, lang);
  const date    = formatDate(a.published_at, lang);
  const readLabel = lang === 'id' ? 'menit baca' : 'min read';

  return `
    <article class="card" onclick="window.location.href='article.html?slug=${a.slug}'" role="link" tabindex="0" aria-label="${title}">
      <div class="card-img-wrap">
        <img src="${a.cover_image || 'https://picsum.photos/seed/' + a.slug + '/800/500'}" alt="${title}" loading="lazy" />
      </div>
      <div class="card-body">
        <div class="card-meta">
          <span class="badge ${badge}">${catName}</span>
          <span class="caption" style="color:var(--text-muted);">${date}</span>
        </div>
        <h3 class="card-title">${title}</h3>
        <p class="card-excerpt">${excerpt}</p>
      </div>
      <div class="card-footer">
        <span class="card-author">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
          ${a.author_name || 'Synet Editorial'}
        </span>
        <span class="card-read-time">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          ${a.read_time} ${readLabel}
        </span>
      </div>
    </article>`;
}

// Featured main card (tall, left side)
function articleCardFeatured(a, lang) {
  const title   = lang === 'id' ? a.title_id   : a.title_en;
  const excerpt = lang === 'id' ? a.excerpt_id : a.excerpt_en;
  const badge   = getCatBadge(a.category_slug);
  const catName = getCatName(a.category_slug, lang);
  const date    = formatDate(a.published_at, lang);
  const readLabel = lang === 'id' ? 'menit baca' : 'min read';
  const readCta = lang === 'id' ? 'Baca selengkapnya →' : 'Read article →';

  return `
    <article class="card featured-main" onclick="window.location.href='article.html?slug=${a.slug}'" role="link" tabindex="0" aria-label="${title}" style="grid-row:span 2;">
      <div class="card-img-wrap" style="aspect-ratio:unset; min-height:280px;">
        <img src="${a.cover_image || 'https://picsum.photos/seed/' + a.slug + '/800/500'}" alt="${title}" loading="lazy" />
      </div>
      <div class="card-body" style="padding:var(--space-xl); gap:var(--space-md);">
        <div class="card-meta">
          <span class="badge ${badge}">${catName}</span>
          <span class="caption" style="color:var(--text-muted);">${date}</span>
        </div>
        <h2 class="card-title" style="font-size:1.5rem;">${title}</h2>
        <p class="card-excerpt" style="-webkit-line-clamp:4;">${excerpt}</p>
        <div style="margin-top:auto;">
          <span style="font-size:0.85rem; font-weight:600; color:var(--teal);">${readCta}</span>
        </div>
      </div>
      <div class="card-footer">
        <span class="card-author">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
          ${a.author_name || 'Synet Editorial'}
        </span>
        <span class="card-read-time">
          <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          ${a.read_time} ${readLabel}
        </span>
      </div>
    </article>`;
}

// Small card (right column in featured grid)
function articleCardSmall(a, lang) {
  const title   = lang === 'id' ? a.title_id   : a.title_en;
  const excerpt = lang === 'id' ? a.excerpt_id : a.excerpt_en;
  const badge   = getCatBadge(a.category_slug);
  const catName = getCatName(a.category_slug, lang);
  const readLabel = lang === 'id' ? 'menit baca' : 'min read';

  return `
    <article class="card" onclick="window.location.href='article.html?slug=${a.slug}'" role="link" tabindex="0" aria-label="${title}" style="display:grid; grid-template-columns:120px 1fr; min-height:auto;">
      <div class="card-img-wrap" style="aspect-ratio:unset;">
        <img src="${a.cover_image || 'https://picsum.photos/seed/' + a.slug + '/800/500'}" alt="${title}" loading="lazy" />
      </div>
      <div class="card-body" style="padding:var(--space-md);">
        <span class="badge ${badge}" style="font-size:0.65rem;">${catName}</span>
        <h3 class="card-title" style="font-size:1rem; margin-top:var(--space-xs);">${title}</h3>
        <span class="card-read-time" style="margin-top:auto; font-size:0.72rem;">
          <svg width="11" height="11" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"/><polyline points="12 6 12 12 16 14"/></svg>
          ${a.read_time} ${readLabel}
        </span>
      </div>
    </article>`;
}

// =============================================
// KEYBOARD NAV FOR CARDS
// =============================================
function initCardKeyboard() {
  document.addEventListener('keydown', e => {
    if (e.key === 'Enter' && e.target.classList.contains('card')) {
      e.target.click();
    }
    if (e.key === 'Enter' && e.target.classList.contains('category-card')) {
      e.target.click();
    }
  });
}

// =============================================
// CHAT TRIGGER (shared across pages)
// =============================================
function initChatTrigger() {
  const trigger  = document.getElementById('chatTrigger');
  const panel    = document.getElementById('chatPanel');
  const hint     = document.getElementById('chatHint');

  if (!trigger || !panel) return;

  trigger.addEventListener('click', () => {
    const open = panel.classList.toggle('open');
    trigger.classList.toggle('chat-open', open);
    trigger.setAttribute('aria-expanded', open);
    panel.setAttribute('aria-hidden', !open);

    if (hint) hint.style.display = 'none';

    if (open) {
      setTimeout(() => {
        const input = document.getElementById('chatInput');
        if (input) input.focus();
      }, 300);
    }
  });

  // Auto-dismiss hint after 6s
  if (hint) {
    setTimeout(() => {
      hint.style.opacity = '0';
      hint.style.transition = 'opacity 0.5s';
      setTimeout(() => hint.style.display = 'none', 500);
    }, 6000);
  }

  // ESC closes chat
  document.addEventListener('keydown', e => {
    if (e.key === 'Escape' && panel.classList.contains('open')) {
      trigger.click();
      trigger.focus();
    }
  });
}

// =============================================
// CHAT INPUT — auto-resize + enter to send
// =============================================
function initChatInput() {
  const input = document.getElementById('chatInput');
  if (!input) return;

  input.addEventListener('input', () => {
    input.style.height = 'auto';
    input.style.height = Math.min(input.scrollHeight, 100) + 'px';
  });

  input.addEventListener('keydown', e => {
    if (e.key === 'Enter' && !e.shiftKey) {
      e.preventDefault();
      sendMessage();
    }
  });
}

// =============================================
// BOOT
// =============================================
document.addEventListener('DOMContentLoaded', () => {
  // Apply saved lang
  const savedLang = getLang();
  document.documentElement.setAttribute('lang', savedLang);
  document.documentElement.setAttribute('data-lang', savedLang);
  applyTranslations(savedLang);

  // Update lang button states
  document.querySelectorAll('.lang-btn').forEach(btn => {
    const isActive = btn.dataset.lang === savedLang;
    btn.classList.toggle('active', isActive);
    btn.setAttribute('aria-pressed', isActive);
  });

  initNav();
  initReveal();
  initCardKeyboard();
  initChatTrigger();
  initChatInput();
});
