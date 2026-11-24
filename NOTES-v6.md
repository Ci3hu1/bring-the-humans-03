# NOTES — bring-the-humans-03 v6 (re-post setelah v5 dihapus TikTok)

## Konteks
- v5 (round 4, submission 01a20166) videonya DIHAPUS TikTok 22 Nov ~17:14 —
  alasan "Frauds and Scams". Video 7710837003885038868 hilang; entry round 4 mati.
- v6 = video BARU untuk disubmit sebagai round 5. Entries tutup 25 Nov 2026
  02:00 WIB. Hasil 9 Des 2026 08:00 WIB. Ranking murni dari views TikTok.
- Joni review video ini dulu sebelum posting (dia yang posting ke TikTok).

## Apa yang berubah dari v5
- **Background BERBEDA:** v5 = kinetic street-poster (panel diagonal magenta,
  hazard band, kata raksasa bergeser). v6 = tenang/bersih: gradien vertikal
  indigo lembut + dot grid samar + 3 blob warna lembut yang melayang pelan
  (violet, teal, magenta). TIDAK ada background GTA 6 (aturan Joni 22 Nov).
- **Teks di layar DILUNAKKAN (4 beat, fokus ke agent yang membangun):**
  1. "YOUR AGENT BUILDS / WHILE YOU SLEEP." (kotak indigo)
  2. "AI AGENTS COMPETE / ON MAKE.FUN" (kotak magenta)
  3. "SEE WHAT YOURS / CAN MAKE." (kotak teal)
  4. "YOUR AGENT BUILDS IT. / YOU KEEP THE WIN." (kotak indigo)
  Dihapus: "STOP SCROLLING.", "FOR REAL MONEY.", label vertikal
  "BOUNTY // 01", hazard band, indikator REC + timer. Strip bawah jadi
  "make.fun // AI AGENT ARENA" (tanpa kata BOUNTY).
- **Tidak ada kata terlarang di layar:** "money", "cash", "earn", "$500",
  "bounty", "STOP SCROLLING" — dicek visual di keempat beat, strip bawah,
  badge, dan end card. Kata "$500 bounty" tetap WAJIB ada di CAPTION
  (bukan di video) — lihat caption-v6.txt.
- **Kode referral tetap ada:** `cc7tcnw6` di end card magenta (pill putih,
  seperti v5) — hanya kode, tanpa "$500" di sampingnya di layar.
- **Pola top-10 yang dipertahankan:** badge pill kiri atas dari frame 1,
  end card magenta ~2,5 detik terakhir, motion terus-menerus (blob melayang
  + ghost bobbing pelan), satu ghost per beat (laptop / judge / spyglass /
  trophy).
- **Musik:** sama seperti v5 — disintesis di sesi ini oleh music.py
  (10-bar C–G–Am–F, 20 detik), baked in saat render. Bukan track unduhan;
  Joni TIDAK boleh tambah lagu di editor TikTok.

## Hasil
- `video-v6.mp4`: 576×1024, 30fps, H.264 + AAC, durasi 20,01 detik,
  1.140.035 bytes (~1,09 MB, di bawah ~2 MB).
- `render-v6.sh`: `./render-v6.sh` (dari repo). Musik: `python3 music.py`.
- `caption-v6.txt`: `Made by my AI agent for a $500 bounty on make.fun:
  make.fun/bounty/bring-the-humans-03 makefun-sunset-cheddar-flipper`
  (mengandung "$500 bounty" + "make.fun" + play code, tanpa frasa
  "where AI agents compete for real money" dari caption v5).
- `v6-shot1.jpg` .. `v6-shot4.jpg`: 576×1024 JPEG, masing-masing
  36–55 KB (di bawah 256 KiB) — beat 1–4 di t=2, 6, 10, 14 detik.

## Verifikasi (sebelum lapor selesai)
- ffprobe: 576×1024, 20,01 detik, H.264 + AAC (48 kHz stereo). OK.
- Audio bukan sunyi: mean_volume -21,0 dB, max_volume -3,5 dB. OK.
- Keempat beat dibaca visual: teks terbaca penuh, tidak terpotong/overlap,
  ghost tidak menutupi teks. OK.
- End card (t=19): kode `cc7tcnw6` terlihat jelas di pill putih. OK.
- Tidak ada kata terlarang di layar (dicek di semua frame). OK.
- File v5 TIDAK tersentuh: `git diff HEAD -- video-v5.mp4 render-v5.sh
  main.ts` kosong. OK.

## Status
Dibangun 22 Nov 2026 ~17:44 WIB. Menunggu review Joni, lalu Joni posting
ke TikTok sendiri dan parent submit sebagai round 5 (VIDEO.json perlu
di-update ke URL TikTok baru setelah posting — BUKAN tugas builder).
