# Rotary District 1913 - Budget Tracker

Sustav za praćenje budžeta Rotary Distrikta 1913 Croatia (1.7.2026 - 30.6.2027)

## 🚀 Quick Start

### Lokalno pokretanje:
1. Preuzmite `rotary-budget-tracker.html`
2. Otvorite u web browseru
3. Prijavite se:
   - **Admin**:  
   - **Editor**: 
   - **Viewer**: 

### GitHub Pages Deployment:

1. **Kreiraj repozitorij:**
   ```bash
   # Na GitHubu kreiraj novi repozitorij: rotary-budget-tracker
   ```

2. **Kloniraj i upload:**
   ```bash
   git clone https://github.com/vedranblagus/rotary-budget-tracker.git
   cd rotary-budget-tracker
   
   # Kopiraj rotary-budget-tracker.html kao index.html
   cp rotary-budget-tracker.html index.html
   
   git add .
   git commit -m "Initial commit - Rotary Budget Tracker"
   git push origin main
   ```

3. **Omogući GitHub Pages:**
   - Idi na repo Settings → Pages
   - Source: Deploy from branch
   - Branch: `main` / `root`
   - Save

4. **Live URL:**
   ```
   https://vedranblagus.github.io/rotary-budget-tracker
   ```

## 🗄️ Supabase Setup (Opcionalno - za dijeljenje podataka)

### 1. Pokreni SQL skriptu:
- Otvori [Supabase Dashboard](https://app.supabase.com)
- SQL Editor → New Query
- Kopiraj sadržaj `supabase-schema.sql`
- Execute

### 2. Ažuriraj konfiguraciju:
U `index.html`, pronađi:
```javascript
const SUPABASE_URL = 'YOUR_SUPABASE_URL';
const SUPABASE_KEY = 'YOUR_SUPABASE_KEY';
```

Zamijeni sa:
```javascript
const SUPABASE_URL = 'https://rotary1913.supabase.co';
const SUPABASE_KEY = 'sb_publishable_BHrhNESd3vZ_XzLH69dHWg_z1y1fskp';
```

### 3. Promijeni storage mode:
```javascript
const USE_SUPABASE = true; // Promijeni na true
```

## 📊 Funkcionalnosti

- ✅ Dashboard s grafovima i mjesečnim pregledom
- ✅ Upravljanje budžetom (7 kategorija prihoda, 28 rashoda)
- ✅ Upload CSV transakcija s AI kategorizacijom
- ✅ Ručni unos prihoda/rashoda
- ✅ Praćenje članarina po klubovima
- ✅ Korisnički sustav (Admin/Editor/Viewer)
- ✅ Export podataka u CSV
- ✅ Activity logovi

## 🔐 Uloge korisnika

### Admin
- Puni pristup
- User management
- Svi tabovi

### Editor  
- Uređivanje budžeta
- Upload CSV
- Kategorizacija transakcija
- Bez user managementa

### Viewer
- Dashboard (read-only)
- Budget pregled (read-only)
- Bez editiranja

## 📁 Struktura projekta

```
rotary-budget-tracker/
├── index.html              # Glavna aplikacija
├── supabase-schema.sql     # Baza podataka
├── README.md               # Ova datoteka
└── .github/
    └── workflows/
        └── deploy.yml      # Auto-deploy na GitHub Pages
```

## 🛠️ Tehnologije

- HTML5
- TailwindCSS
- Chart.js
- Supabase (opcionalno)
- Claude AI API (za CSV kategorizaciju)

## 📝 Licenca

© 2026 Rotary District 1913 Croatia

## 🤝 Kontakt

Za podršku: admin@rotary1913.org
