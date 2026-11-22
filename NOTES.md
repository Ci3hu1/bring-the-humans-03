# bring-the-humans-03 — Submission notes

- Title: "Put Your Agent to Work"
- Submission: `01a1fff0-9119-74b8-9715-845bc702ea33` (accepted 2026-11-21T21:08:38Z / 22 Nov 04:08 WIB)
- Repo: https://github.com/Ci3hu1/bring-the-humans-03, commit `182f97438ba4468d8089004fec544e93745677a3`
- TikTok (posted by Joni ~03:56 WIB, caption verified exact from his screenshot): https://www.tiktok.com/@fortuna5982/video/7710731256841162004
- Video: v3, 1080x1920, 20.0s, 60fps. Music by `music.py` — 10-bar C–G–Am–F arrangement (intro, groove, 16th-hat bars, octave lift, snare fill, outro), synthesized in-session. Brand badge from frame 1; referral end card with `cc7tcnw6` typed in. Last frame verified: code sits in the white field left of the copy button.
- Kit check before submit: `ok: true`, `failed: []`. Play code verified: `makefun-sunset-cheddar-flipper` (n=0 of 4).
- Deadline: entries close 25 Nov 2026 02:00 WIB; results 9 Dec 2026 08:00 WIB.
- Prize: top 20 by TikTok views share $500 (1st $100, 2nd $70, 3rd $50, 4th–10th $20, 11th–20th $14). Force_Last — this is the final submission unless a newer version is submitted before the deadline.
- Claim code: stored only in `~/.config/makefun/bring-the-humans-03-submission.json` (0600), never in the repo.

## Round 2 (resubmit)

- RESUBMITTED 22 Nov ~09:38 WIB on Joni's "Setuju semua": submission `01a2011e-6833-739d-833f-94eafa53d81b`, commit `ead07802e131f79dce99b2f8becb390ea68372b9` (VIDEO.json → new re-posted video https://www.tiktok.com/@fortuna5982/video/7710816795149503745).
- Kit check before resubmit: `ok: true`, `failed: []` (8 sessions; thinking_reproduces 64.6% authored).
- Status after resubmit: **REJECTED — entry_link FAIL, same as round 1** (TikTok shows no video 7710816795149503745 to a US visitor, statusCode 10231 cross_border_violation). All other checks pass. The re-post is still not US-viewable, so the block looks account/settings-level, not video-level.
- Retry allowed until 25 Nov 2026 02:00 WIB (round 3) once fixed. Claim code for round 2 stored in the same 0600 file (round 1 submission kept as previous_submission_id).

## Round 3 (not submitted)

- Joni re-posted the v3 video with a trimmed caption (no links) → video 7710822255491616020. Direct check: first status_reviewing (10204), then 10231 cross_border_violation — trimmed caption did NOT fix it. A re-check after enabling the AI-generated label was still 10231. Never submitted to make.fun (viewability failed first).
- Top-10 study (22 Nov ~10:20–10:50, bth03-top10-study.md): all 576×1024, 17.5–23s, 5/6 pure motion graphics with continuous motion; badge pill top-left from frame 1; magenta end card last ~2.5s with code typed in pill; caption formula "$500 bounty" + make.fun + play code; original sound. GitHub: all 10 source_withheld. Disproven as 10231 causes: on-screen referral code, full referral link in caption, "$500 bounty"/"real money" language, fully synthetic content, agent-made audio, badge, 20s duration.
- v4 (GTA 6 background) CANCELLED by Joni 22 Nov ~10:14 — no GTA 6 background for the TikTok video.

## Round 4 (resubmit, v5 motion graphics) — SUBMITTED, all checks PASS

- v5 built 22 Nov ~10:27 by a Muse subagent (render-v5.sh): 576×1024, 30fps, 20.01s, kinetic street-poster (diagonal magenta/black panels, giant outlined type, yellow highlight strips, animated ghost illustrations, HUD timer/labels); badge pill top-left from frame 1; end card with `cc7tcnw6` typed in pill; audio = music.py (same as v3). Verified by Muse personally (frames t=1, 9, 19.5 + ffprobe).
- First post (video 7710835315501452564, ~10:39) hit a signed-out login wall ("This creator turned on audience controls") — NOT submitted. Joni re-posted → video **7710837003885038868**: direct check 10:48 status_reviewing (10204); re-check ~10:52 statusCode 0, playAddr present, caption EXACT, duration 20, author fortuna5982 — **VIEWABLE from outside (US)**.
- SUBMITTED 22 Nov ~10:57 WIB on Joni's "Setuju" (option 3 = submit + Boltbook votes): submission `01a20166-adab-70c5-9d59-ceb8e4619fdb`, commit `92ccbf2d3c5d334064553af90467869378978b0d` (v5 files + VIDEO.json + BRIEF.md v5 spec). Bundle bth03-bundle-v5.tar.gz (3,545,196 bytes, sha 4219334f…), 10 sessions incl. v5 builder; kit check `ok: true`, `failed: []` (thinking_reproduces 72.0% authored).
- Status after submit: **SCORED — all checks PASS, including entry_link** (TikTok video 7710837003885038868 public, "$500 bounty" + make.fun + play code in caption). First BTH-03 submission to pass entry_link. Outcome not decided yet; results 9 Dec 2026 08:00 WIB. Claim code stored in the same 0600 file (round 2 kept as previous_submission_id).
