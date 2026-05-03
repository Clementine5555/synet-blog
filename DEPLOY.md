# Synet — Deploy Guide

Panduan lengkap setup Supabase + Netlify + AI Chat dari nol sampai live.

---

## Daftar Isi
1. [Setup Supabase (Database)](#1-setup-supabase)
2. [Deploy ke Netlify (Hosting)](#2-deploy-ke-netlify)
3. [Aktifkan AI Chat (Anthropic)](#3-aktifkan-ai-chat)
4. [Isi config.js](#4-isi-configjs)
5. [Tambah Artikel Baru](#5-tambah-artikel-baru)
6. [Troubleshooting](#6-troubleshooting)

---

## 1. Setup Supabase

### Buat project
1. Buka [supabase.com](https://supabase.com) → **Start your project**
2. Login / buat akun gratis
3. Klik **New project**
4. Isi nama project: `synet-blog`
5. Set database password (simpan passwordnya)
6. Pilih region terdekat (Singapore untuk Indonesia)
7. Klik **Create new project** — tunggu ~1 menit

### Jalankan schema SQL
1. Di dashboard Supabase, klik **SQL Editor** di sidebar kiri
2. Klik **New query**
3. Buka file `sql/schema.sql` dari repo ini
4. Copy semua isinya, paste ke SQL Editor
5. Klik **Run** (atau Ctrl+Enter)
6. Harusnya muncul: `Success. No rows returned`

> Schema ini otomatis bikin 2 tabel (categories + articles) dan mengisi 15 artikel bilingual sebagai seed data.

### Ambil API credentials
1. Di sidebar Supabase → **Settings** → **API**
2. Copy dua nilai ini:
   - **Project URL** → ini adalah `SUPABASE_URL`
   - **anon / public** key → ini adalah `SUPABASE_ANON_KEY`

---

## 2. Deploy ke Netlify

### Opsi A — Deploy dari GitHub (Recommended)
1. Buka [netlify.com](https://netlify.com) → **Sign up** / login
2. Klik **Add new site** → **Import an existing project**
3. Pilih **GitHub**
4. Authorize Netlify, lalu pilih repo `synet-blog`
5. Build settings:
   - **Base directory**: (kosongkan)
   - **Build command**: (kosongkan)
   - **Publish directory**: `.`
6. Klik **Deploy site**
7. Tunggu ~30 detik — site akan live!

Netlify otomatis deploy ulang setiap kali ada push ke GitHub.

### Opsi B — Deploy manual (drag & drop)
1. Download semua file dari repo sebagai ZIP
2. Extract ZIP
3. Buka [netlify.com](https://netlify.com) → dashboard
4. Drag-drop folder ke area "Want to deploy a new site without connecting to Git?"
5. Done — dapat URL langsung

---

## 3. Aktifkan AI Chat

### Buat Anthropic API Key
1. Buka [console.anthropic.com](https://console.anthropic.com)
2. Login / daftar akun
3. Sidebar → **API Keys** → **Create Key**
4. Beri nama: `synet-production`
5. Copy key-nya (hanya ditampilkan sekali!)

### Set di Netlify (JANGAN di config.js)
API key TIDAK boleh di-hardcode di frontend. Set sebagai environment variable:

1. Di Netlify dashboard → pilih site Synet
2. **Site configuration** → **Environment variables**
3. Klik **Add a variable**
4. Key: `ANTHROPIC_API_KEY`
5. Value: paste API key dari Anthropic
6. Klik **Save**
7. **Redeploy site** (Deploys → Trigger deploy → Deploy site)

---

## 4. Isi config.js

Buka file `js/config.js` dan isi dengan credentials Supabase:

```js
const SYNET_CONFIG = {
  SUPABASE_URL:      "https://xxxxxxxxxxxx.supabase.co",   // dari Supabase Settings > API
  SUPABASE_ANON_KEY: "eyJhbGciOiJIUzI1...",               // anon/public key
  // ... sisanya biarkan default
};
```

Setelah edit, commit dan push ke GitHub:
```bash
git add js/config.js
git commit -m "config: add supabase credentials"
git push
```
Netlify otomatis deploy ulang dalam ~30 detik.

---

## 5. Tambah Artikel Baru

Tidak perlu coding — semua lewat Supabase dashboard:

1. Buka Supabase → **Table Editor** → tabel **articles**
2. Klik **Insert** → **Insert row**
3. Isi kolom-kolom berikut:

| Kolom | Isi |
|-------|-----|
| `slug` | URL-friendly, contoh: `nama-artikel-ini` (huruf kecil, pakai `-`) |
| `category_slug` | Salah satu dari: `marine-life`, `ocean-science`, `conservation`, `deep-sea`, `ocean-climate` |
| `title_en` | Judul dalam English |
| `title_id` | Judul dalam Bahasa Indonesia |
| `excerpt_en` | Ringkasan singkat English (1-2 kalimat) |
| `excerpt_id` | Ringkasan singkat Indonesia |
| `content_en` | Isi artikel English (pisah paragraf dengan baris kosong) |
| `content_id` | Isi artikel Indonesia |
| `author_name` | Nama penulis |
| `cover_image` | URL gambar (bisa dari Unsplash: `https://images.unsplash.com/photo-ID?w=800&q=80`) |
| `read_time` | Estimasi menit baca (angka) |
| `featured` | `true` kalau mau muncul di homepage hero |

4. Klik **Save**
5. Refresh halaman Synet — artikel langsung muncul!

---

## 6. Troubleshooting

### Artikel tidak muncul
- Cek `SUPABASE_URL` dan `SUPABASE_ANON_KEY` di `js/config.js`
- Buka browser DevTools → Console — ada error?
- Pastikan schema SQL sudah dijalankan (tabel `articles` dan `categories` ada)

### AI Chat tidak merespons
- Pastikan `ANTHROPIC_API_KEY` sudah diset di Netlify environment variables
- Pastikan site sudah di-redeploy setelah set env var
- Buka DevTools → Network → cek response dari `/.netlify/functions/ocean-ai`

### Gambar tidak muncul
- Gambar pakai Unsplash CDN — butuh koneksi internet
- Untuk gambar sendiri, upload ke Supabase Storage atau gunakan layanan seperti Cloudinary

### Bahasa tidak berganti
- Cek apakah `js/app.js` ter-load (DevTools → Network)
- Clear localStorage: DevTools → Application → Local Storage → hapus `synet-lang`

### Deploy gagal di Netlify
- Pastikan `netlify.toml` ada di root folder
- Publish directory harus `.` (titik), bukan `public` atau `dist`
- Cek Netlify deploy log untuk error spesifik

---

## Struktur File

```
synet-blog/
├── index.html          # Homepage
├── articles.html       # Listing artikel
├── article.html        # Reader artikel
├── about.html          # Tentang Synet
├── contact.html        # Kontak
├── netlify.toml        # Konfigurasi Netlify
├── css/
│   └── style.css       # Semua styling
├── js/
│   ├── config.js       # ← ISI INI dengan Supabase keys
│   ├── app.js          # Logic utama (lang, nav, cards)
│   └── chat.js         # AI chat widget
├── netlify/
│   └── functions/
│       └── ocean-ai.js # Serverless function (Anthropic proxy)
└── sql/
    └── schema.sql      # Jalankan ini di Supabase SQL Editor
```

---

## Stack Summary

| Layer | Service | Gratis? |
|-------|---------|---------|
| Database | Supabase (PostgreSQL) | ✅ Free tier |
| Hosting | Netlify | ✅ Free tier |
| AI Chat | Anthropic Claude | 💳 Pay per use (~$0.003/pesan) |
| Fonts | Google Fonts | ✅ Gratis |
| Images | Unsplash CDN | ✅ Gratis |

---

*Synet — Science · Sea · Internet*
