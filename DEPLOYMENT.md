# 🚀 DEPLOYMENT UPUTE - Rotary Budget Tracker

## BRZI START (5 minuta)

### Korak 1: Supabase Setup

1. Otvori https://app.supabase.com
2. Odaberi svoj projekt ili kreiraj novi
3. Klikni **SQL Editor** → **New Query**
4. Kopiraj cijeli sadržaj iz `supabase-schema.sql`
5. Klikni **RUN** (ili Ctrl+Enter)
6. Pričekaj da se izvrši (trebalo bi biti ~20 zelenih checkmarkova)

✅ Baza podataka kreirana!

---

### Korak 2: GitHub Setup

#### 2a) Kreiraj repozitorij na GitHubu:

1. Idi na https://github.com/new
2. Repository name: `rotary-budget-tracker`
3. Description: "Rotary District 1913 Budget Tracker"
4. Public
5. **NE** dodavaj README (već imaš)
6. Klikni **Create repository**

#### 2b) Upload datoteka:

**Opcija A: Kroz GitHub web interface (LAKŠE)**

1. Na stranici novog repozitorija klikni **uploading an existing file**
2. Drag & drop ili odaberi datoteke:
   - `rotary-budget-tracker.html` (preimenuj u `index.html`)
   - `README.md`
   - `supabase-schema.sql`
3. Kreiraj folder `.github/workflows/`
4. Upload `deploy.yml` u taj folder
5. Commit changes

**Opcija B: Kroz Git command line**

```bash
# 1. Kloniraj prazan repo
git clone https://github.com/vedranblagus/rotary-budget-tracker.git
cd rotary-budget-tracker

# 2. Kopiraj datoteke
cp /path/to/rotary-budget-tracker.html index.html
cp /path/to/README.md .
cp /path/to/supabase-schema.sql .

# 3. Kreiraj GitHub Actions folder
mkdir -p .github/workflows
cp /path/to/deploy.yml .github/workflows/

# 4. Commit i push
git add .
git commit -m "Initial commit - Rotary Budget Tracker v2.0"
git push origin main
```

---

### Korak 3: Omogući GitHub Pages

1. Idi na repozitorij: https://github.com/vedranblagus/rotary-budget-tracker
2. Klikni **Settings** (gornji tab)
3. Sidebar lijevo → **Pages**
4. Source: **Deploy from a branch**
5. Branch: **main** / **root**
6. Klikni **Save**
7. Pričekaj 2-3 minute

✅ **Live URL:** https://vedranblagus.github.io/rotary-budget-tracker

---

### Korak 4: Testiranje

1. Otvori: https://vedranblagus.github.io/rotary-budget-tracker
2. Prijavi se:
   - Email: `admin@rotary1913.org`
   - Password: `admin123`
3. Testiranje:
   - ✅ Dodaj klub u "Prihod po klubu"
   - ✅ Klikni "Spremi"
   - ✅ Provjeri Dashboard
   - ✅ Dodaj ručni unos u "Realizirano"

---

## ⚙️ TRENUTNA KONFIGURACIJA

**Storage:** localStorage (podaci lokalno u browseru)

Svaki korisnik ima svoje podatke. Ako želiš **dijeljenje podataka između korisnika**, trebam:

### Za Supabase integraciju:

1. Moram dodati Supabase JavaScript SDK u HTML
2. Zamijeniti sve `localStorage` pozive s Supabase API
3. Implementirati pravi auth sustav

**Vrijeme:** ~2-3 sata rada

**Prednost:** 
- ✅ Svi korisnici vide iste podatke
- ✅ Podatci sačuvani u cloudu
- ✅ Automatski backup
- ✅ Pravi multi-user sustav

**Želiš li nastaviti s Supabase integracijom?**

---

## 🔧 TROUBLESHOOTING

### Problem: GitHub Pages ne radi
**Rješenje:**
1. Settings → Pages → Source: "main" branch
2. Pričekaj 5 minuta
3. Hard refresh (Ctrl+Shift+R)

### Problem: 404 Not Found
**Rješenje:**
1. Provjeri da se file zove `index.html` (ne `rotary-budget-tracker.html`)
2. Provjeri da je u root folderu (ne u subfolderu)

### Problem: Podaci se ne spremaju
**Rješenje:**
1. Otvori Chrome DevTools (F12)
2. Application → Local Storage
3. Provjeri `https://vedranblagus.github.io`

### Problem: Supabase SQL greška
**Rješenje:**
1. Obriši sve tablice
2. Pokreni skriptu ponovno
3. Provjeri da projekt podržava PostgreSQL 15+

---

## 📞 NEXT STEPS

Nakon što je app live, javi mi:

1. ✅ Radi li deployment?
2. ✅ Možeš li se prijaviti?
3. ✅ Sprema li podatke?
4. ✅ Želiš li Supabase integraciju?

---

Verzija: 2.0
Datum: 16.02.2026
