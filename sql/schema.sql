-- =============================================
-- SYNET DATABASE SCHEMA + SEED DATA
-- Run this in Supabase SQL Editor
-- =============================================

-- Drop tables if re-running
DROP TABLE IF EXISTS articles CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

-- =============================================
-- CATEGORIES
-- =============================================
CREATE TABLE categories (
  id SERIAL PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  name_en TEXT NOT NULL,
  name_id TEXT NOT NULL,
  description_en TEXT,
  description_id TEXT,
  icon TEXT,
  color TEXT
);

-- =============================================
-- ARTICLES
-- =============================================
CREATE TABLE articles (
  id SERIAL PRIMARY KEY,
  slug TEXT UNIQUE NOT NULL,
  category_slug TEXT REFERENCES categories(slug) ON DELETE SET NULL,
  title_en TEXT NOT NULL,
  title_id TEXT NOT NULL,
  excerpt_en TEXT NOT NULL,
  excerpt_id TEXT NOT NULL,
  content_en TEXT NOT NULL,
  content_id TEXT NOT NULL,
  author_name TEXT DEFAULT 'Synet Editorial',
  cover_image TEXT,
  read_time INT DEFAULT 5,
  featured BOOLEAN DEFAULT FALSE,
  published_at TIMESTAMPTZ DEFAULT NOW(),
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- =============================================
-- ROW LEVEL SECURITY (Public Read)
-- =============================================
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE articles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read categories" ON categories FOR SELECT USING (true);
CREATE POLICY "Public read articles" ON articles FOR SELECT USING (true);

-- =============================================
-- SEED: CATEGORIES
-- =============================================
INSERT INTO categories (slug, name_en, name_id, description_en, description_id, icon, color) VALUES
('marine-life',    'Marine Life',           'Kehidupan Laut',       'Discover the incredible diversity of ocean creatures',              'Temukan keanekaragaman makhluk laut yang luar biasa',          'fish',     '#1e8a8f'),
('ocean-science',  'Ocean Science',         'Sains Samudra',        'The physics, chemistry and biology of the world''s oceans',        'Fisika, kimia, dan biologi samudra dunia',                     'flask',    '#0b3d54'),
('conservation',   'Conservation',          'Konservasi',           'Protecting marine ecosystems for future generations',              'Melindungi ekosistem laut untuk generasi mendatang',          'leaf',     '#2e8b57'),
('deep-sea',       'Deep Sea Exploration',  'Eksplorasi Laut Dalam','Venturing into the darkest and most mysterious depths',            'Menjelajahi kedalaman paling gelap dan misterius',            'anchor',   '#374151'),
('ocean-climate',  'Ocean & Climate',       'Laut & Iklim',         'How oceans drive and are shaped by our changing climate',          'Bagaimana laut menggerakkan dan dibentuk oleh perubahan iklim','cloud',    '#dc6b42');

-- =============================================
-- SEED: ARTICLES (15 bilingual articles)
-- =============================================

-- ---- MARINE LIFE ----

INSERT INTO articles (slug, category_slug, title_en, title_id, excerpt_en, excerpt_id, content_en, content_id, author_name, cover_image, read_time, featured, published_at) VALUES
(
  'the-secret-language-of-dolphins',
  'marine-life',
  'The Secret Language of Dolphins',
  'Bahasa Rahasia Lumba-Lumba',
  'Each dolphin carries a unique signature whistle — the ocean equivalent of a personal name. Researchers are only beginning to decode the complexity of cetacean communication.',
  'Setiap lumba-lumba memiliki siulan tanda tangan yang unik — setara dengan nama pribadi di lautan. Para peneliti baru mulai memahami kompleksitas komunikasi paus dan lumba-lumba.',
  E'Dolphins have long captured human imagination, but what truly sets them apart is their sophisticated system of communication. Researchers have discovered that each dolphin develops a unique "signature whistle" within the first few months of life — a personal identifier used to announce its presence to the pod.\n\nThese whistles are not simply sounds. Studies from the Wild Dolphin Project show that dolphins use signature whistles to address each other directly, much like calling a name in a crowded room. The signal can travel several kilometers through open water, allowing separated pod members to relocate one another.\n\nBeyond whistles, dolphins use echolocation — emitting rapid, high-frequency clicks that bounce off objects and return as echoes. This biological sonar is so refined that a dolphin can detect a golf-ball-sized object from 70 meters away, and distinguish between objects of different densities, even through sand.\n\nRecent hydrophone studies off the coast of Scotland found that dolphins appear to engage in what can only be described as conversation: taking turns "speaking," with click patterns that shift in response to the other dolphin''s output. While we cannot yet translate dolphin, the structural similarities to turn-based communication are unmistakable.\n\nAs our tools for bioacoustic analysis improve — particularly through AI-assisted pattern recognition — the prospect of meaningfully decoding dolphin language shifts from science fiction toward genuine possibility.',
  E'Lumba-lumba telah lama memikat imajinasi manusia, namun yang benar-benar membedakan mereka adalah sistem komunikasi yang canggih. Para peneliti menemukan bahwa setiap lumba-lumba mengembangkan "siulan tanda tangan" yang unik dalam beberapa bulan pertama kehidupannya — penanda pribadi yang digunakan untuk mengumumkan kehadirannya kepada kawanan.\n\nSiulan ini bukan sekadar suara biasa. Studi dari Wild Dolphin Project menunjukkan bahwa lumba-lumba menggunakan siulan tanda tangan untuk menyapa satu sama lain secara langsung, seperti memanggil nama di ruangan yang ramai. Sinyal tersebut dapat merambat beberapa kilometer melalui air terbuka, memungkinkan anggota kawanan yang terpisah untuk saling menemukan.\n\nSelain siulan, lumba-lumba menggunakan ekolokasi — memancarkan klik frekuensi tinggi yang memantul dari objek dan kembali sebagai gema. Sonar biologis ini sangat canggih sehingga lumba-lumba dapat mendeteksi objek seukuran bola golf dari jarak 70 meter, dan membedakan objek dengan kepadatan berbeda, bahkan di balik pasir.\n\nStudi hidrofon terbaru di lepas pantai Skotlandia menemukan bahwa lumba-lumba tampaknya terlibat dalam apa yang hanya bisa digambarkan sebagai percakapan: bergantian "berbicara," dengan pola klik yang berubah sesuai respons lumba-lumba lainnya. Meski kita belum dapat menerjemahkan bahasa lumba-lumba, kemiripan struktural dengan komunikasi berbasis giliran sangat jelas terlihat.',
  'Dr. Synet Editorial',
  'https://images.unsplash.com/photo-1568430462989-44163eb1752f?w=800&q=80',
  6, TRUE, NOW() - INTERVAL '5 days'
),

(
  'coral-reefs-cities-under-the-sea',
  'marine-life',
  'Coral Reefs: Cities Under the Sea',
  'Terumbu Karang: Kota di Bawah Laut',
  'Covering less than 1% of the ocean floor, coral reefs support nearly 25% of all marine species — making them the most biodiverse ecosystems on Earth.',
  'Meski hanya mencakup kurang dari 1% dasar laut, terumbu karang menopang hampir 25% dari semua spesies laut — menjadikannya ekosistem paling beragam hayati di Bumi.',
  E'If you were to compress all of Earth''s ecosystems by biodiversity, coral reefs would sit at the top. These geological structures — built over millennia by tiny colonial animals called polyps — cover less than one percent of the ocean floor, yet they shelter an estimated 25% of all known marine species.\n\nA coral polyp is a small, soft-bodied organism related to jellyfish. It secretes a calcium carbonate skeleton that accumulates over generations, forming the branching, boulder, and plate structures we recognize as reef. What makes the coral-reef system extraordinary is not the polyps alone, but their symbiotic relationship with microscopic algae called zooxanthellae. These algae live within coral tissue, providing up to 90% of the coral''s energy through photosynthesis in exchange for shelter and nutrients.\n\nThis relationship is also the coral''s greatest vulnerability. When water temperatures rise even 1–2°C above seasonal maximums, corals expel their zooxanthellae in a stress response called bleaching. Without the algae, corals lose both their color and their primary food source. Prolonged bleaching leads to death.\n\nThe Great Barrier Reef experienced its most widespread bleaching event in 2022, affecting over 90% of surveyed reefs. Yet coral reefs are not passive victims. Some coral populations show early signs of thermal adaptation, with heat-resistant phenotypes becoming more common in warmer zones. Scientists are also experimenting with assisted evolution — selectively breeding heat-tolerant corals to repopulate degraded reefs.',
  E'Jika kita membandingkan semua ekosistem di Bumi berdasarkan keanekaragaman hayati, terumbu karang berada di posisi teratas. Struktur geologis ini — dibangun selama ribuan tahun oleh hewan kolonial kecil yang disebut polip — mencakup kurang dari satu persen dasar laut, namun menampung sekitar 25% dari semua spesies laut yang dikenal.\n\nPolip karang adalah organisme bertubuh lunak kecil yang berkerabat dengan ubur-ubur. Ia menyekresikan kerangka kalsium karbonat yang menumpuk dari generasi ke generasi, membentuk struktur bercabang, berbentuk batu, dan berlempeng yang kita kenal sebagai terumbu. Yang membuat sistem terumbu karang luar biasa bukan hanya polipnya, tetapi hubungan simbiotik mereka dengan alga mikroskopis bernama zooxanthellae. Alga ini hidup di dalam jaringan karang, menyediakan hingga 90% energi karang melalui fotosintesis sebagai imbalan tempat berlindung dan nutrisi.\n\nHubungan ini juga merupakan kerentanan terbesar karang. Ketika suhu air naik bahkan 1–2°C di atas maksimum musiman, karang mengusir zooxanthellae mereka dalam respons stres yang disebut pemutihan. Tanpa alga, karang kehilangan warna dan sumber makanan utama mereka. Pemutihan berkepanjangan menyebabkan kematian.\n\nGreat Barrier Reef mengalami peristiwa pemutihan paling meluas pada tahun 2022, mempengaruhi lebih dari 90% terumbu yang disurvei. Namun terumbu karang bukanlah korban pasif. Beberapa populasi karang menunjukkan tanda-tanda awal adaptasi termal, dengan fenotipe tahan panas yang semakin umum di zona lebih hangat.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1518020382113-a7e8fc38eac9?w=800&q=80',
  7, TRUE, NOW() - INTERVAL '12 days'
),

(
  'whale-migration-patterns',
  'marine-life',
  'The Longest Journeys: Whale Migration Decoded',
  'Perjalanan Terpanjang: Migrasi Paus Terungkap',
  'Humpback whales travel up to 16,000 km each year — one of the longest migrations of any mammal. Scientists are only now piecing together why, and how, they navigate with such precision.',
  'Paus bungkuk menempuh perjalanan hingga 16.000 km setiap tahun — salah satu migrasi terpanjang dari mamalia manapun. Para ilmuwan baru kini mulai memahami mengapa dan bagaimana mereka navigasi dengan presisi seperti itu.',
  E'Every year, humpback whales undertake one of nature''s most epic journeys — traveling from nutrient-rich polar feeding grounds to warm tropical breeding waters, covering distances of up to 16,000 kilometers in a single round trip. This is the longest documented migration of any mammal on Earth.\n\nFor decades, scientists puzzled over how whales navigate these vast, featureless expanses of open ocean with remarkable precision, often returning to the same specific locations year after year. Research now suggests that whales use a combination of tools: the Earth''s magnetic field, underwater topography, ocean temperature gradients, celestial cues, and infrasound produced by ocean waves interacting with coastlines.\n\nThe humpback''s song — a haunting, complex sequence of sounds that can last up to 20 minutes and be heard thousands of kilometers away — plays a key role in their social and breeding behavior during migration. Intriguingly, all male humpbacks within an ocean basin sing the same song at any given time, and the song evolves collectively as new phrases spread through the population.\n\nSatellite tagging programs have revealed additional surprises. Some individual whales deviate dramatically from the expected north-south migration routes, taking long detours that appear purposeless by standard models but may serve social functions — visiting specific feeding patches or rendezvous points.\n\nClimate change is already reshaping these ancient routes. As prey distributions shift with warming waters, some whale populations are adjusting their migration timing and destination, with cascading consequences for the ecosystems that have co-evolved with their presence.',
  E'Setiap tahun, paus bungkuk menjalani salah satu perjalanan paling epik di alam — melakukan perjalanan dari daerah makan kutub yang kaya nutrisi ke perairan tropis yang hangat untuk berkembang biak, menempuh jarak hingga 16.000 kilometer dalam satu perjalanan pulang-pergi. Ini adalah migrasi terpanjang yang terdokumentasi dari mamalia manapun di Bumi.\n\nSelama beberapa dekade, para ilmuwan bertanya-tanya bagaimana paus menavigasi hamparan laut terbuka yang luas dan tak berfitur ini dengan presisi luar biasa, sering kembali ke lokasi spesifik yang sama dari tahun ke tahun. Penelitian kini menunjukkan bahwa paus menggunakan kombinasi berbagai alat: medan magnet Bumi, topografi bawah air, gradien suhu laut, isyarat langit, dan infrasonik yang dihasilkan oleh gelombang laut yang berinteraksi dengan garis pantai.\n\nNyanyian paus bungkuk — urutan suara yang kompleks dan memilukan yang bisa berlangsung hingga 20 menit dan terdengar ribuan kilometer jauhnya — memainkan peran kunci dalam perilaku sosial dan perkembangbiakan mereka selama migrasi. Menariknya, semua paus bungkuk jantan dalam satu cekungan laut menyanyikan lagu yang sama pada waktu tertentu, dan lagunya berkembang secara kolektif saat frasa baru menyebar melalui populasi.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1499260651695-99f5c3f4bbfe?w=800&q=80',
  8, FALSE, NOW() - INTERVAL '20 days'
),

-- ---- OCEAN SCIENCE ----

(
  'bioluminescence-when-the-sea-glows',
  'ocean-science',
  'Bioluminescence: When the Sea Glows in the Dark',
  'Bioluminesensi: Ketika Laut Bercahaya di Kegelapan',
  'An estimated 76% of ocean creatures produce their own light. Bioluminescence is not a curiosity — it is one of evolution''s most successful inventions.',
  'Diperkirakan 76% makhluk laut menghasilkan cahaya sendiri. Bioluminesensi bukan sekadar keunikan — ini adalah salah satu penemuan evolusi yang paling sukses.',
  E'Stand on a beach in darkness and you may witness one of nature''s most extraordinary spectacles: waves breaking in blue-green fire, each whitecap igniting a ghostly light before fading back into black water. This is bioluminescence — the biological production of light — and the ocean is its greatest theater.\n\nAn estimated 76% of deep-sea organisms can produce light, making bioluminescence the most common form of communication in the ocean''s dark zones. The chemistry behind it is elegant: a light-emitting molecule called luciferin reacts with oxygen in the presence of an enzyme called luciferase, releasing energy as photons of light rather than heat.\n\nEvolution has repurposed this chemistry for a remarkable variety of functions. The anglerfish uses a bioluminescent lure dangling from its forehead to attract prey in the lightless deep. The firefly squid (Watasenia scintillans) uses photophores — light-producing organs — to camouflage itself by matching the faint light filtering down from the surface, a phenomenon called counterillumination. Dinoflagellates — the microorganisms responsible for that glowing surf — emit flashes when physically disturbed, possibly to startle predators or attract secondary predators that will eat their attackers.\n\nBioluminescence also has profound implications for human technology. The luciferase enzyme and green fluorescent protein (GFP), originally isolated from the jellyfish Aequorea victoria, are now foundational tools in biomedical research — used to tag and track cellular processes, cancer cells, and even individual neurons.\n\nAs deep-sea exploration expands, researchers continue to find new bioluminescent organisms, suggesting that much of the ocean''s light show remains undiscovered.',
  E'Berdirilah di pantai dalam kegelapan dan kamu mungkin menyaksikan salah satu tontonan paling luar biasa di alam: gelombang yang pecah dalam api biru-hijau, setiap puncak ombak menyala dengan cahaya hantu sebelum kembali menghilang ke dalam air hitam. Inilah bioluminesensi — produksi cahaya biologis — dan lautan adalah teater terbesarnya.\n\nDiperkirakan 76% organisme laut dalam dapat menghasilkan cahaya, menjadikan bioluminesensi sebagai bentuk komunikasi paling umum di zona gelap lautan. Kimia di baliknya sangat elegan: molekul pemancar cahaya yang disebut lusiferin bereaksi dengan oksigen di hadapan enzim yang disebut lusiferase, melepaskan energi sebagai foton cahaya bukan panas.\n\nEvolusi telah menggunakan kembali kimia ini untuk berbagai fungsi yang luar biasa. Ikan angler menggunakan umpan bioluminescent yang tergantung dari dahinya untuk menarik mangsa di kedalaman tanpa cahaya. Cumi-cumi kunang-kunang (Watasenia scintillans) menggunakan fotofora — organ penghasil cahaya — untuk berkamuflase dengan mencocokkan cahaya redup yang menyaring dari permukaan, fenomena yang disebut counterillumination. Dinoflagellata — mikroorganisme yang bertanggung jawab atas ombak yang bercahaya — memancarkan kilatan saat terganggu secara fisik, mungkin untuk mengejutkan predator atau menarik predator sekunder yang akan memakan penyerangnya.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1551244072-5d12893278bc?w=800&q=80',
  7, TRUE, NOW() - INTERVAL '8 days'
),

(
  'understanding-ocean-currents',
  'ocean-science',
  'The Ocean''s Invisible Rivers: Understanding Ocean Currents',
  'Sungai Tak Kasat Mata Laut: Memahami Arus Laut',
  'Ocean currents move more water than all of Earth''s rivers combined. They regulate climate, distribute nutrients, and have shaped the course of human history.',
  'Arus laut menggerakkan lebih banyak air daripada semua sungai di Bumi digabungkan. Mereka mengatur iklim, mendistribusikan nutrisi, dan telah membentuk jalannya sejarah manusia.',
  E'Below the wind-ruffled surface of the ocean lies an invisible network of rivers — massive, persistent flows of water that collectively carry more volume than all of Earth''s freshwater rivers combined. Ocean currents are the planet''s primary heat redistribution system, and understanding them is fundamental to understanding Earth''s climate.\n\nCurrents are driven by two main forces. Surface currents are powered primarily by wind, which drags water in the direction of the prevailing winds. The Coriolis effect — a consequence of Earth''s rotation — deflects these flows to the right in the Northern Hemisphere and to the left in the Southern Hemisphere, creating the great ocean gyres.\n\nDeep-water currents are driven by density differences caused by variations in temperature and salinity — a system known as thermohaline circulation, or the global ocean conveyor belt. Dense, cold, salty water sinks near the poles and flows along the ocean floor toward the equator, while warmer, lighter water flows along the surface in the opposite direction. This conveyor moves at a glacial pace — a droplet of water may take 1,000 years to complete a full circuit — but it transports enormous amounts of heat, keeping regions like northwest Europe far warmer than their latitude would otherwise allow.\n\nResearch published in 2021 found that the Atlantic Meridional Overturning Circulation (AMOC) — a key component of this system — is at its weakest point in over a millennium, likely due to freshwater influx from melting Greenland ice. A significant slowdown or shutdown of AMOC could trigger dramatic climate shifts across the North Atlantic, with consequences ranging from cooling in Europe to intensified drought in Africa.',
  E'Di bawah permukaan laut yang bergelombang oleh angin, terdapat jaringan sungai tak kasat mata — aliran air yang masif dan persisten yang secara kolektif membawa volume lebih besar dari semua sungai air tawar di Bumi digabungkan. Arus laut adalah sistem redistribusi panas utama planet ini, dan memahaminya sangat penting untuk memahami iklim Bumi.\n\nArus didorong oleh dua kekuatan utama. Arus permukaan terutama didorong oleh angin, yang menyeret air ke arah angin yang berlaku. Efek Coriolis — konsekuensi dari rotasi Bumi — membelokkan aliran ini ke kanan di Belahan Bumi Utara dan ke kiri di Belahan Bumi Selatan, menciptakan pusaran laut besar.\n\nArus air dalam didorong oleh perbedaan densitas yang disebabkan oleh variasi suhu dan salinitas — sistem yang dikenal sebagai sirkulasi termohalin, atau sabuk konveyor laut global. Air yang padat, dingin, dan asin tenggelam di dekat kutub dan mengalir di sepanjang dasar laut menuju khatulistiwa, sementara air yang lebih hangat dan ringan mengalir di sepanjang permukaan ke arah berlawanan. Konveyor ini bergerak dengan kecepatan glasial — setetes air mungkin membutuhkan 1.000 tahun untuk menyelesaikan satu siklus penuh — tetapi mengangkut jumlah panas yang luar biasa, membuat wilayah seperti Eropa barat laut jauh lebih hangat dari yang seharusnya berdasarkan garis lintangnya.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1505118380757-91f5f5632de0?w=800&q=80',
  8, FALSE, NOW() - INTERVAL '18 days'
),

(
  'ocean-salinity-explained',
  'ocean-science',
  'Why Is the Ocean Salty? The Science of Ocean Salinity',
  'Mengapa Laut Asin? Ilmu Salinitas Laut',
  'The ocean contains 37 million billion tons of dissolved salt. Its salinity is not random — it is a carefully balanced chemical system that took billions of years to establish.',
  'Lautan mengandung 37 kuadriliun ton garam terlarut. Salinitasnya bukan kebetulan — ini adalah sistem kimia yang seimbang dengan cermat yang membutuhkan miliaran tahun untuk terbentuk.',
  E'The average salinity of the ocean is about 3.5% — meaning that every liter of seawater contains roughly 35 grams of dissolved salts. But where did all this salt come from, and why doesn''t it keep getting saltier?\n\nThe primary source of ocean salt is the weathering of rocks on land. Rainwater, slightly acidic due to dissolved carbon dioxide, erodes minerals from rocks and soil, releasing ions — particularly sodium and chloride — that are carried by rivers into the ocean. This process has been operating for billions of years.\n\nThe second source is hydrothermal vents on the ocean floor, where seawater percolates into the crust, is heated by magma, and returns to the ocean laden with dissolved minerals.\n\nSo why doesn''t the ocean keep getting saltier? Because it operates as a system in near-equilibrium. Sodium and chloride ions accumulate because they are highly soluble and not easily removed. Other ions — calcium, magnesium, bicarbonate — are removed at roughly the same rate they are added, through biological processes (organisms building shells and skeletons) and chemical precipitation.\n\nSalinity varies across the ocean — highest in subtropical regions where evaporation is intense and rainfall is low, lowest near rivers and in polar regions where melting ice dilutes the water. These salinity gradients play a critical role in driving thermohaline circulation and influencing where marine organisms can survive. The Black Sea, for instance, is nearly fresh in its upper layer, while the Red Sea is one of the saltiest bodies of water on Earth.',
  E'Salinitas rata-rata laut sekitar 3,5% — artinya setiap liter air laut mengandung sekitar 35 gram garam terlarut. Tapi dari mana semua garam ini berasal, dan mengapa tidak terus semakin asin?\n\nSumber utama garam laut adalah pelapukan batuan di daratan. Air hujan, yang sedikit asam karena karbon dioksida terlarut, mengikis mineral dari batuan dan tanah, melepaskan ion — terutama natrium dan klorida — yang dibawa oleh sungai ke laut. Proses ini telah berlangsung selama miliaran tahun.\n\nSumber kedua adalah lubang hidrotermal di dasar laut, di mana air laut meresap ke dalam kerak bumi, dipanaskan oleh magma, dan kembali ke laut sarat dengan mineral terlarut.\n\nJadi mengapa laut tidak terus semakin asin? Karena ia beroperasi sebagai sistem yang hampir seimbang. Ion natrium dan klorida terakumulasi karena sangat larut dan tidak mudah dihilangkan. Ion lain — kalsium, magnesium, bikarbonat — dihilangkan pada tingkat yang kira-kira sama dengan tingkat penambahannya, melalui proses biologis dan presipitasi kimia.\n\nSalinitas bervariasi di seluruh laut — tertinggi di daerah subtropis di mana penguapan intens dan curah hujan rendah, terendah di dekat sungai dan di daerah kutub di mana es yang mencair mengencerkan air.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1507525428034-b723cf961d3e?w=800&q=80',
  6, FALSE, NOW() - INTERVAL '25 days'
),

-- ---- CONSERVATION ----

(
  'the-plastic-tide',
  'conservation',
  'The Plastic Tide: How Pollution Is Reshaping Our Oceans',
  'Gelombang Plastik: Bagaimana Polusi Mengubah Lautan Kita',
  'An estimated 8 million tons of plastic enter the ocean every year. The impact goes far beyond visible debris — microplastics have been found in the deepest trenches and in human blood.',
  'Diperkirakan 8 juta ton plastik masuk ke laut setiap tahun. Dampaknya jauh melampaui sampah yang terlihat — mikroplastik telah ditemukan di palung terdalam dan dalam darah manusia.',
  E'Every minute, the equivalent of a garbage truck''s worth of plastic enters the ocean. Since commercial plastic production began in the 1950s, we have produced over 8 billion metric tons — and roughly 9% of that has been recycled. The rest has been incinerated, landfilled, or has escaped into the environment. An estimated 150 million metric tons of plastic currently circulates in marine environments.\n\nThe most visible manifestation of this crisis is the Great Pacific Garbage Patch — a vast accumulation of plastic debris in the North Pacific Gyre spanning an area twice the size of Texas. But calling it a "patch" is misleading; it is not a solid island of trash but a diffuse concentration of mostly small plastic fragments suspended throughout the water column.\n\nPlastic in the ocean does not biodegrade in any meaningful timeframe. Instead, it breaks down through UV radiation and wave action into smaller and smaller fragments — microplastics (particles smaller than 5mm) and nanoplastics. These particles have now been detected in virtually every part of the ocean, from Arctic sea ice to deep-sea sediments seven kilometers down. They have been found in the gut tissue of fish, in plankton, in seabirds, in whale stomachs, and — in studies published in 2022 and 2023 — in human blood and lung tissue.\n\nThe consequences for marine ecosystems are complex. Large debris entangles and drowns marine mammals and seabirds. Ingested plastics cause starvation in seabirds and turtles that mistake them for food. Microplastics interfere with the reproductive systems of fish and appear to carry persistent organic pollutants that bioaccumulate up the food chain.',
  E'Setiap menit, plastik setara dengan isi satu truk sampah masuk ke laut. Sejak produksi plastik komersial dimulai pada tahun 1950-an, kita telah memproduksi lebih dari 8 miliar metrik ton — dan sekitar 9% dari itu telah didaur ulang. Sisanya telah dibakar, ditimbun, atau lolos ke lingkungan. Diperkirakan 150 juta metrik ton plastik saat ini beredar di lingkungan laut.\n\nManifestasi paling terlihat dari krisis ini adalah Great Pacific Garbage Patch — akumulasi besar serpihan plastik di North Pacific Gyre yang mencakup area dua kali ukuran Texas. Namun menyebutnya "patch" (tambalan) adalah menyesatkan; itu bukan pulau sampah yang padat tetapi konsentrasi tersebar dari sebagian besar serpihan plastik kecil yang tersuspensi di seluruh kolom air.\n\nPlastik di laut tidak terurai secara biologis dalam jangka waktu yang berarti. Sebaliknya, ia terurai melalui radiasi UV dan aksi gelombang menjadi fragmen yang semakin kecil — mikroplastik (partikel lebih kecil dari 5mm) dan nanoplastik. Partikel-partikel ini kini telah terdeteksi di hampir setiap bagian laut, dari es laut Arktik hingga sedimen laut dalam tujuh kilometer ke bawah.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1604599340287-2042e85a3802?w=800&q=80',
  8, TRUE, NOW() - INTERVAL '3 days'
),

(
  'marine-protected-areas-explained',
  'conservation',
  'Marine Protected Areas: Do Ocean Sanctuaries Actually Work?',
  'Kawasan Lindung Laut: Apakah Suaka Laut Benar-Benar Berhasil?',
  'The world has committed to protecting 30% of the ocean by 2030. But with over 18,000 MPAs already designated, scientists are asking a harder question: are they actually working?',
  'Dunia telah berkomitmen untuk melindungi 30% lautan pada tahun 2030. Namun dengan lebih dari 18.000 KKL yang sudah ditetapkan, para ilmuwan mengajukan pertanyaan yang lebih sulit: apakah mereka benar-benar berhasil?',
  E'At the 2022 Convention on Biological Diversity, nations agreed to the "30x30" target — protecting 30% of land and ocean by 2030. For the ocean, this represents an enormous ambition. Currently, roughly 8% of the ocean is designated as a Marine Protected Area (MPA), but only about 2.7% is strongly protected.\n\nThe evidence for well-designed, enforced MPAs is compelling. Studies consistently show that no-take reserves — where fishing and extraction are completely prohibited — see significant increases in fish biomass, species diversity, and size of individual fish within a few years of establishment. These effects can spill over into adjacent fishing areas, as abundant fish populations expand beyond protected boundaries.\n\nBut "designated" does not mean "protected." Research by marine ecologist Callum Roberts and colleagues found that the majority of the world''s MPAs are "paper parks" — legally designated but inadequately managed and enforced. In many cases, industrial fishing and other destructive activities continue within MPA boundaries, providing little conservation benefit.\n\nEffective MPAs share several characteristics: sufficient size to encompass complete ecosystems, no-take or strictly limited extraction zones at their core, adequate monitoring and enforcement, and meaningful involvement of local communities whose livelihoods depend on healthy marine ecosystems.\n\nThe high seas — international waters beyond national jurisdiction — present the greatest challenge. They cover 60% of the ocean but are subject to minimal governance. The 2023 High Seas Treaty, adopted under the United Nations, represents a landmark step toward establishing MPAs in international waters, though ratification and implementation remain crucial hurdles.',
  E'Pada Konvensi Keanekaragaman Hayati 2022, negara-negara menyetujui target "30x30" — melindungi 30% daratan dan lautan pada tahun 2030. Untuk lautan, ini merupakan ambisi yang sangat besar. Saat ini, sekitar 8% lautan ditetapkan sebagai Kawasan Konservasi Laut (KKL), namun hanya sekitar 2,7% yang dilindungi dengan kuat.\n\nBukti untuk KKL yang dirancang dan ditegakkan dengan baik sangat meyakinkan. Studi secara konsisten menunjukkan bahwa kawasan bebas tangkap — di mana penangkapan ikan dan ekstraksi sepenuhnya dilarang — mengalami peningkatan signifikan dalam biomassa ikan, keragaman spesies, dan ukuran ikan individu dalam beberapa tahun setelah penetapan.\n\nNamun "ditetapkan" tidak berarti "dilindungi." Penelitian oleh ahli ekologi kelautan Callum Roberts dan kolega menemukan bahwa sebagian besar KKL dunia adalah "taman kertas" — ditetapkan secara hukum tetapi tidak dikelola dan ditegakkan dengan memadai. Dalam banyak kasus, penangkapan ikan industri dan kegiatan merusak lainnya terus berlangsung di dalam batas KKL, memberikan sedikit manfaat konservasi.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1582967788606-a171c1080cb0?w=800&q=80',
  7, FALSE, NOW() - INTERVAL '15 days'
),

(
  'restoring-mangrove-forests',
  'conservation',
  'Mangrove Forests: Nature''s Most Underrated Coastal Shield',
  'Hutan Mangrove: Tameng Pesisir Alam yang Paling Diremehkan',
  'Mangroves store up to 4 times more carbon than tropical rainforests per hectare. Yet we have lost half of the world''s mangroves in the past 50 years.',
  'Mangrove menyimpan hingga 4 kali lebih banyak karbon daripada hutan hujan tropis per hektar. Namun kita telah kehilangan setengah dari mangrove dunia dalam 50 tahun terakhir.',
  E'Mangrove forests occupy the difficult intertidal zone between land and sea — an environment of fluctuating salinity, tidal flooding, and oxygen-poor sediments that most plants cannot tolerate. The mangrove''s adaptations to this harsh environment — aerial roots that breathe above the waterline, salt-secreting leaves, seedlings that germinate on the parent plant — make it one of the world''s most specialized and valuable ecosystems.\n\nThe ecological services mangroves provide are extraordinary. Their complex root systems stabilize sediments and buffer coastlines against storm surge and erosion — a service valued at up to $65,000 per kilometer of coastline per year. They serve as nurseries for an estimated 80% of tropical fish species, providing shelter and food for juvenile fish before they migrate to reef and open-water habitats. Their waterlogged, anoxic sediments are exceptional carbon stores: per hectare, mangroves sequester up to four times more carbon than tropical rainforests.\n\nDespite this value, we have lost an estimated 35–50% of the world''s mangroves since the 1980s, primarily to aquaculture (shrimp and fish farming), coastal development, and rice agriculture. The losses continue at a rate of about 0.3–0.6% per year.\n\nRestoration efforts are accelerating, but success is mixed. Many early projects planted mangroves in the wrong locations — exposed coastlines or areas with altered hydrology — leading to high mortality. Scientists now emphasize hydrological restoration first: if water flow is restored, mangroves often regenerate naturally. Community-led restoration, particularly in Southeast Asia and East Africa, has produced some of the most durable outcomes.',
  E'Hutan mangrove menempati zona intertidal yang sulit antara darat dan laut — lingkungan dengan salinitas yang berfluktuasi, banjir pasang surut, dan sedimen miskin oksigen yang tidak dapat ditolerir oleh kebanyakan tanaman. Adaptasi mangrove terhadap lingkungan keras ini — akar udara yang bernapas di atas permukaan air, daun yang menyekresikan garam, bibit yang berkecambah di tanaman induk — menjadikannya salah satu ekosistem paling terspesialisasi dan berharga di dunia.\n\nLayanan ekologis yang diberikan mangrove sangat luar biasa. Sistem akar yang kompleks menstabilkan sedimen dan melindungi garis pantai dari gelombang badai dan erosi — layanan yang bernilai hingga $65.000 per kilometer garis pantai per tahun. Mereka berfungsi sebagai tempat pembibitan untuk diperkirakan 80% spesies ikan tropis.\n\nMeski memiliki nilai sebesar itu, kita telah kehilangan sekitar 35–50% mangrove dunia sejak tahun 1980-an, terutama karena budidaya perairan (pertambakan udang dan ikan), pembangunan pesisir, dan pertanian padi. Kerugian terus berlanjut dengan laju sekitar 0,3–0,6% per tahun.\n\nUpaya restorasi semakin cepat, tetapi hasilnya beragam. Para ilmuwan kini menekankan pemulihan hidrologis terlebih dahulu: jika aliran air dipulihkan, mangrove sering beregenerasi secara alami.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1559825481-12a05cc00344?w=800&q=80',
  7, FALSE, NOW() - INTERVAL '22 days'
),

-- ---- DEEP SEA EXPLORATION ----

(
  'life-in-the-hadal-zone',
  'deep-sea',
  'Life in the Hadal Zone: Creatures of the Ultimate Deep',
  'Kehidupan di Zona Hadal: Makhluk dari Kedalaman Tertinggi',
  'Below 6,000 meters lies the hadal zone — one of the least explored places on Earth. Life there has adapted to crushing pressure, total darkness, and near-freezing temperatures in ways that continue to astonish scientists.',
  'Di bawah 6.000 meter terdapat zona hadal — salah satu tempat yang paling sedikit dieksplorasi di Bumi. Kehidupan di sana telah beradaptasi terhadap tekanan yang menghancurkan, kegelapan total, dan suhu mendekati titik beku dengan cara yang terus mengagumkan para ilmuwan.',
  E'The hadal zone encompasses the deepest parts of the ocean — the trenches and troughs that plunge below 6,000 meters. The Mariana Trench, the deepest known point on Earth, reaches 10,935 meters at Challenger Deep. For most of human history, this realm was assumed to be lifeless: too dark, too cold, too crushingly pressurized for biology to persist.\n\nWe were wrong. Expeditions using remotely operated vehicles (ROVs) and landers have found hadal zones to be surprisingly alive. Amphipods — small crustaceans resembling shrimp — exist in extraordinary abundance. In the Mariana Trench, they have been found in densities of up to 1,000 individuals per square meter, feeding on organic material that drifts down from the sunlit surface above.\n\nSnailfish (Pseudoliparis swirei) have been recorded at depths below 8,000 meters — the deepest fish ever documented. Their bodies are adapted for extreme pressure: gelatinous and flexible, with cell membranes reinforced by molecules called piezolytes that prevent them from collapsing under the crushing weight of kilometers of water above.\n\nMicrobial life is particularly dense in hadal sediments, forming biogeochemical communities that play a key role in breaking down organic carbon that settles to the deep. These communities process a disproportionate amount of the carbon that reaches the seafloor, making the hadal zone a significant — and largely unaccounted-for — component of the ocean''s carbon cycle.\n\nPollution has reached even here. Surveys have found microplastics, persistent organic pollutants, and even manufactured chemicals in hadal sediments and in the tissues of hadal animals — a sobering reminder that no part of the ocean is truly remote.',
  E'Zona hadal mencakup bagian terdalam laut — parit dan lekukan yang mencapai kedalaman di bawah 6.000 meter. Parit Mariana, titik terdalam yang diketahui di Bumi, mencapai 10.935 meter di Challenger Deep. Selama sebagian besar sejarah manusia, wilayah ini diasumsikan tidak berpenghuni: terlalu gelap, terlalu dingin, terlalu tertekan untuk biologi bertahan.\n\nKita salah. Ekspedisi menggunakan kendaraan yang dioperasikan dari jarak jauh (ROV) dan pendarat telah menemukan bahwa zona hadal sangat hidup. Amphipoda — krustasea kecil yang mirip udang — hadir dalam kelimpahan yang luar biasa. Di Parit Mariana, mereka ditemukan dalam kepadatan hingga 1.000 individu per meter persegi, memakan bahan organik yang hanyut turun dari permukaan yang diterangi matahari.\n\nIkan siput (Pseudoliparis swirei) telah terekam pada kedalaman di bawah 8.000 meter — ikan yang paling dalam pernah didokumentasikan. Tubuh mereka beradaptasi untuk tekanan ekstrem: bertekstur agar-agar dan fleksibel, dengan membran sel yang diperkuat oleh molekul yang disebut piezolyte yang mencegahnya runtuh di bawah tekanan dahsyat kilometer air di atasnya.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1550751827-4bd374c3f58b?w=800&q=80',
  9, TRUE, NOW() - INTERVAL '7 days'
),

(
  'deep-sea-mining-debate',
  'deep-sea',
  'Deep Sea Mining: Treasure Hunt or Environmental Catastrophe?',
  'Penambangan Laut Dalam: Perburuan Harta Karun atau Bencana Lingkungan?',
  'The seafloor holds trillions of dollars worth of metals critical for clean energy technology. The race to mine them is accelerating — but so is the scientific opposition.',
  'Dasar laut menyimpan triliunan dolar logam yang kritis untuk teknologi energi bersih. Perlombaan untuk menambangnya semakin cepat — begitu pula dengan oposisi ilmiah.',
  E'At depths of 4,000–6,000 meters across vast stretches of the Pacific, Indian, and Atlantic ocean floors lie fields of potato-sized nodules — polymetallic concretions that have accumulated over millions of years. These nodules are rich in manganese, nickel, cobalt, and copper — metals that are critical components of lithium-ion batteries, electric vehicles, wind turbines, and other clean energy technologies.\n\nProponents of deep-sea mining argue that the irony is real: the green energy transition depends on metals that are in short supply, and the seafloor holds more of them than all known land deposits combined. Mining companies and the governments backing them point to reduced need for destructive land mining, the potential for autonomous and remotely operated extraction, and the economic development potential for countries like Nauru, Kiribati, and Tonga whose exclusive economic zones sit above rich nodule fields.\n\nThe scientific community is largely skeptical. The nodule fields of the Clarion-Clipperton Zone in the Pacific are among the world''s most biodiverse deep-sea habitats, hosting hundreds of species found nowhere else on Earth. Extraction would physically destroy the seafloor and generate sediment plumes that could spread for hundreds of kilometers, smothering filter-feeding organisms over vast areas.\n\nCritically, these ecosystems recover on geological timescales, not human ones. Impact studies from experimental mining in the 1970s have found that disturbed sites showed no meaningful recovery after 25 years. Nodules themselves take millions of years to form. The International Seabed Authority (ISA), which regulates mining in international waters, has approved exploration contracts covering over 1.5 million square kilometers of the seafloor.',
  E'Pada kedalaman 4.000–6.000 meter di hamparan luas dasar laut Pasifik, Hindia, dan Atlantik terdapat ladang nodul seukuran kentang — konkrsi polimetalik yang telah terakumulasi selama jutaan tahun. Nodul-nodul ini kaya akan mangan, nikel, kobalt, dan tembaga — logam yang merupakan komponen kritis baterai lithium-ion, kendaraan listrik, turbin angin, dan teknologi energi bersih lainnya.\n\nPendukung penambangan laut dalam berargumen bahwa ironinya nyata: transisi energi hijau bergantung pada logam yang langka, dan dasar laut menyimpan lebih banyak dari semua deposit daratan yang diketahui digabungkan.\n\nKomunitas ilmiah sebagian besar skeptis. Ladang nodul di Zona Clarion-Clipperton di Pasifik adalah salah satu habitat laut dalam paling beragam hayati di dunia, menampung ratusan spesies yang tidak ditemukan di tempat lain di Bumi. Ekstraksi akan secara fisik menghancurkan dasar laut dan menghasilkan kepulan sedimen yang bisa menyebar ratusan kilometer, membanjiri organisme filter-feeder di area luas.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1519750157634-b6d493a0f77c?w=800&q=80',
  9, FALSE, NOW() - INTERVAL '30 days'
),

(
  'rovs-eyes-in-the-abyss',
  'deep-sea',
  'ROVs: How We Gave Ourselves Eyes in the Abyss',
  'ROV: Bagaimana Kita Memberi Diri Sendiri Mata di Kegelapan',
  'Remotely operated vehicles have transformed our understanding of the deep ocean. From the wreck of the Titanic to hydrothermal vents, ROVs have opened a window into a world we could barely imagine.',
  'Kendaraan yang dioperasikan dari jarak jauh telah mengubah pemahaman kita tentang laut dalam. Dari bangkai Titanic hingga ventilasi hidrotermal, ROV telah membuka jendela ke dunia yang hampir tidak bisa kita bayangkan.',
  E'When geologist Robert Ballard and his team located the wreck of the RMS Titanic in 1985, they used an early remotely operated vehicle called Argo — a camera sled tethered to the surface ship, streaming live video from 3,800 meters below the surface. It was a watershed moment not just for maritime archaeology, but for deep-sea science: for the first time, humans could see the deepest ocean in real time.\n\nToday''s ROVs are vastly more capable. Systems like MBARI''s Doc Ricketts or NOAA''s Deep Discoverer can operate at depths exceeding 4,000 meters for hours at a time, carrying high-definition cameras, lighting systems, manipulator arms, water samplers, sediment corers, and an array of sensors measuring temperature, salinity, oxygen, and chemical concentrations.\n\nThe manipulator arms — often controlled by a pilot watching live video — allow scientists to collect specimens, rock samples, and biological tissue with surgical precision. This capability transformed deep-sea biology: instead of relying on trawl nets that damaged specimens and provided no contextual information, scientists could now observe organisms in situ, document behavior, and collect targeted samples.\n\nROVs have enabled discoveries that redrew our understanding of life on Earth. Hydrothermal vent ecosystems — communities of tube worms, clams, shrimp, and bacteria thriving in superheated, chemical-rich water in total darkness — were discovered by an ROV predecessor in 1977. They demonstrated that life could be sustained by chemosynthesis rather than photosynthesis, fundamentally expanding our concept of where life can exist.\n\nThe next generation of deep-sea vehicles includes autonomous underwater vehicles (AUVs) that can operate untethered for days, and hybrid systems that switch between autonomous survey and remotely piloted modes.',
  E'Ketika ahli geologi Robert Ballard dan timnya menemukan bangkai kapal RMS Titanic pada tahun 1985, mereka menggunakan kendaraan yang dioperasikan dari jarak jauh awal bernama Argo — peluncur kamera yang diikat ke kapal permukaan, mengirimkan video langsung dari kedalaman 3.800 meter. Itu adalah momen bersejarah tidak hanya untuk arkeologi maritim, tetapi juga untuk ilmu laut dalam: untuk pertama kalinya, manusia bisa melihat laut terdalam secara langsung.\n\nROV hari ini jauh lebih canggih. Sistem seperti Doc Ricketts milik MBARI atau Deep Discoverer milik NOAA dapat beroperasi pada kedalaman lebih dari 4.000 meter selama berjam-jam, membawa kamera definisi tinggi, sistem pencahayaan, lengan manipulator, sampler air, corer sedimen, dan serangkaian sensor.\n\nROV telah memungkinkan penemuan yang mengubah pemahaman kita tentang kehidupan di Bumi. Ekosistem ventilasi hidrotermal — komunitas cacing tabung, kerang, udang, dan bakteri yang berkembang di air super panas dan kaya bahan kimia dalam kegelapan total — ditemukan oleh pendahulu ROV pada tahun 1977.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1544551763-46a013bb70d5?w=800&q=80',
  8, FALSE, NOW() - INTERVAL '28 days'
),

-- ---- OCEAN & CLIMATE ----

(
  'ocean-acidification',
  'ocean-climate',
  'Ocean Acidification: The Ocean''s Other Climate Crisis',
  'Pengasaman Laut: Krisis Iklim Lain di Lautan',
  'The ocean absorbs about 30% of all CO₂ we emit. The chemical consequences of this — ocean acidification — are dissolving the foundations of marine ecosystems.',
  'Lautan menyerap sekitar 30% dari semua CO₂ yang kita emisi. Konsekuensi kimianya — pengasaman laut — sedang melarutkan fondasi ekosistem laut.',
  E'The ocean has been described as humanity''s greatest ally in the fight against climate change: it absorbs roughly 30% of the carbon dioxide we emit and has stored over 90% of the excess heat trapped by greenhouse gases since the industrial revolution. But this service comes at a cost that is only now becoming fully apparent.\n\nWhen CO₂ dissolves in seawater, it reacts to form carbonic acid, which then releases hydrogen ions, lowering the pH of the water. Since the industrial revolution, ocean pH has fallen from 8.2 to approximately 8.1 — a decrease of 0.1 pH units that represents a 26% increase in hydrogen ion concentration (due to the logarithmic nature of the pH scale). Scientists project that if emissions continue unchecked, ocean pH could reach 7.9 by 2100 — conditions not seen for 20 million years.\n\nThe immediate victims are organisms that build shells and skeletons from calcium carbonate: corals, oysters, mussels, sea urchins, pteropods (small marine snails critical to polar food chains), and countless others. In more acidic water, calcium carbonate dissolves more readily, and some regions of the Southern Ocean have already crossed the threshold where aragonite (the form of calcium carbonate used by many marine organisms) becomes thermodynamically unstable.\n\nPteropods — sometimes called "sea butterflies" — are already showing dissolution of their shells in the Southern Ocean, with deep pitting and surface erosion visible under electron microscopes. Since pteropods are a critical food source for salmon, mackerel, herring, and baleen whales, their decline would cascade through marine food webs in ways that are difficult to predict.',
  E'Lautan telah digambarkan sebagai sekutu terbesar manusia dalam melawan perubahan iklim: ia menyerap sekitar 30% karbon dioksida yang kita emisi dan telah menyimpan lebih dari 90% panas berlebih yang terperangkap oleh gas rumah kaca sejak revolusi industri. Namun layanan ini datang dengan biaya yang baru kini menjadi jelas sepenuhnya.\n\nKetika CO₂ larut dalam air laut, ia bereaksi membentuk asam karbonat, yang kemudian melepaskan ion hidrogen, menurunkan pH air. Sejak revolusi industri, pH laut telah turun dari 8,2 menjadi sekitar 8,1 — penurunan 0,1 unit pH yang mewakili peningkatan 26% dalam konsentrasi ion hidrogen. Para ilmuwan memproyeksikan bahwa jika emisi terus tidak terkendali, pH laut bisa mencapai 7,9 pada tahun 2100.\n\nKorban langsung adalah organisme yang membangun cangkang dan kerangka dari kalsium karbonat: karang, tiram, kerang, bulu babi, pteropoda (siput laut kecil yang kritis untuk rantai makanan kutub), dan banyak lainnya.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1497290756760-23ac55edf36f?w=800&q=80',
  8, TRUE, NOW() - INTERVAL '6 days'
),

(
  'ocean-as-earths-thermostat',
  'ocean-climate',
  'The Ocean as Earth''s Thermostat: Regulating a Planet''s Climate',
  'Laut sebagai Termostat Bumi: Mengatur Iklim Sebuah Planet',
  'Without the ocean, Earth would be uninhabitable. The ocean absorbs heat, releases moisture, drives weather, and buffers temperature swings that would otherwise make most of Earth uninhabitable.',
  'Tanpa laut, Bumi tidak akan bisa dihuni. Laut menyerap panas, melepaskan kelembapan, mendorong cuaca, dan meredam ayunan suhu yang tanpa itu akan membuat sebagian besar Bumi tidak bisa dihuni.',
  E'Earth is sometimes called the "blue planet," and the name understates the ocean''s role. Covering 71% of the surface to an average depth of 3,700 meters, the ocean represents the largest reservoir of thermal energy on the planet. It absorbs roughly 93% of the excess heat being trapped by increasing greenhouse gas concentrations — without this buffer, global surface temperatures would have risen far more dramatically than they have.\n\nThe mechanism behind this is the high specific heat capacity of water: it takes about 3,300 times more energy to raise the temperature of a given volume of seawater by 1°C than to raise the same volume of air. This makes the ocean an extraordinary thermal flywheel that smooths out temperature extremes and moderates seasonal swings across coastlines worldwide.\n\nThe ocean also drives the hydrological cycle. Evaporation from the ocean''s surface accounts for about 86% of global evaporation, loading the atmosphere with water vapor that eventually falls as rain and snow over land. The latent heat released when this water vapor condenses is a primary energy source for atmospheric circulation, influencing rainfall patterns from the Amazon to the Sahel.\n\nBut the ocean''s buffering capacity has limits. Studies show that the rate at which the ocean is absorbing heat may be slowing as surface waters warm and the temperature gradient between the surface and deep ocean decreases. Warmer surface waters also hold less dissolved oxygen, creating expanding "dead zones" where marine life cannot survive. The ocean that has protected us from the worst consequences of our emissions is increasingly showing the strain.',
  E'Bumi terkadang disebut "planet biru," dan nama itu meremehkan peran laut. Menutupi 71% permukaan hingga kedalaman rata-rata 3.700 meter, lautan mewakili reservoir energi termal terbesar di planet ini. Ia menyerap sekitar 93% panas berlebih yang terperangkap oleh meningkatnya konsentrasi gas rumah kaca.\n\nMekanisme di balik ini adalah kapasitas panas jenis air yang tinggi: dibutuhkan sekitar 3.300 kali lebih banyak energi untuk menaikkan suhu volume air laut tertentu sebesar 1°C daripada menaikkan volume udara yang sama. Ini menjadikan laut sebagai roda penerus termal yang luar biasa yang melicinkan ekstrem suhu.\n\nLautan juga menggerakkan siklus hidrologi. Penguapan dari permukaan laut menyumbang sekitar 86% dari penguapan global, memuat atmosfer dengan uap air yang akhirnya jatuh sebagai hujan dan salju di atas daratan.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1437622368342-7a3d73a34c8f?w=800&q=80',
  7, FALSE, NOW() - INTERVAL '16 days'
),

(
  'rising-seas-what-the-data-shows',
  'ocean-climate',
  'Rising Seas: What the Data Actually Shows',
  'Kenaikan Permukaan Laut: Apa yang Sebenarnya Ditunjukkan Data',
  'Global sea levels have risen 20 cm since 1900. The rate is accelerating. Here is what the satellite record, tide gauges, and ice sheet models are telling us — and what it means for coastal communities.',
  'Permukaan laut global telah naik 20 cm sejak 1900. Lajunya semakin cepat. Inilah yang dikatakan oleh rekaman satelit, pengukur pasang surut, dan model lapisan es — dan apa artinya bagi komunitas pesisir.',
  E'Sea level rise is one of the most consequential and well-documented consequences of a warming climate. Since the late 19th century, global mean sea level has risen by approximately 20 centimeters, and the rate is accelerating: while the average rise over the 20th century was about 1.5 mm per year, it has increased to 3.7 mm per year in the period 2006–2018, and satellite data from 2023 suggests the current rate may now exceed 4 mm per year.\n\nSea level rises from two primary mechanisms. Thermal expansion — water physically expanding as it warms — accounted for roughly half of 20th century rise. The other half came from melting land ice: glaciers and ice sheets. In the 21st century, ice loss has become the dominant contributor, with the Greenland and Antarctic ice sheets accelerating their mass loss. The West Antarctic Ice Sheet is of particular concern: it contains enough ice to raise global sea levels by 3.3 meters, and evidence suggests its collapse may already be underway.\n\nProjections from the IPCC''s Sixth Assessment Report (2021) range from 0.3–1.0 meters of rise by 2100 under different emissions scenarios, with low-probability but high-impact outcomes of 2 meters or more if ice sheet dynamics behave unexpectedly. Low-lying nations like Bangladesh, the Maldives, Kiribati, and Tuvalu face existential threat. Miami, Jakarta, Amsterdam, and Shanghai face multi-trillion dollar infrastructure decisions.\n\nLocal sea level rise varies significantly from the global mean due to land subsidence (many coastal cities are sinking under the weight of development or due to groundwater extraction), ocean circulation changes, and gravitational effects of melting ice sheets. Jakarta, Indonesia''s capital, is sinking at up to 25 cm per year in some areas due to groundwater extraction — a problem that led to the government''s decision to relocate the capital to Nusantara in Kalimantan.',
  E'Kenaikan permukaan laut adalah salah satu konsekuensi iklim yang memanas yang paling signifikan dan terdokumentasi dengan baik. Sejak akhir abad ke-19, rata-rata permukaan laut global telah naik sekitar 20 sentimeter, dan lajunya semakin cepat: sementara kenaikan rata-rata selama abad ke-20 sekitar 1,5 mm per tahun, ia meningkat menjadi 3,7 mm per tahun dalam periode 2006–2018.\n\nPermukaan laut naik dari dua mekanisme utama. Ekspansi termal — air yang secara fisik mengembang saat menghangat — menyumbang sekitar setengah dari kenaikan abad ke-20. Setengah lainnya berasal dari pencairan es daratan: gletser dan lapisan es. Di abad ke-21, kehilangan es telah menjadi kontributor dominan.\n\nProyeksi dari Laporan Penilaian Keenam IPCC berkisar dari 0,3–1,0 meter kenaikan pada tahun 2100 di bawah skenario emisi yang berbeda. Negara-negara dataran rendah seperti Bangladesh, Maladewa, Kiribati, dan Tuvalu menghadapi ancaman eksistensial. Jakarta, ibukota Indonesia, tenggelam dengan kecepatan hingga 25 cm per tahun di beberapa area akibat ekstraksi air tanah.',
  'Synet Editorial',
  'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=800&q=80',
  9, FALSE, NOW() - INTERVAL '10 days'
);
