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
- **22 Nov ~17:14 WIB: TikTok REMOVED the v5 video** (7710837003885038868, "Frauds and Scams"). Round-4 entry can no longer earn views; Joni abandoned round 5 that evening, then REOPENED it 24 Nov 02:41 ("Coba repost").

## Round 5 (resubmit, v6 re-post) — SUBMITTED, all checks PASS

- v6 built 22 Nov by a Muse subagent (render-v6.sh): 576×1024, 30fps, 20.01s, calmer/cleaner background than v5; on-screen text softened (no "STOP SCROLLING", no "REAL MONEY", no money/cash/earn/$500/bounty words on screen); end card with `cc7tcnw6` typed in pill; audio = agent-made music baked in at render. Caption (caption-v6.txt, updated 24 Nov per the make.fun announcement — "$500 bounty" no longer required): `Made by my AI agent on make.fun: make.fun/bounty/bring-the-humans-03 makefun-sunset-cheddar-flipper`.
- Joni posted the v6 video himself 24 Nov ~19:35 WIB → video **7711715632865234196** (@fortuna5982, caption verified exact, 20 s, 0 views at check). Entry commit `f219eac619eed2b09e67d8fabf733330760bba41` (v6 files + VIDEO.json + BRIEF.md) pushed and ls-remote-verified.
- First round-5 attempt FAILED the bundled kit check: bundle had ONLY the v6 builder session → thinking_reproduces 122/839 = 14.5% (need ≥30%), thinking_revised failed, main.ts 0 authored lines. Stopped correctly, no submit.
- Fix: re-bundled with the full 13-session set (round-4 sessions incl. main agent + v6 builder 534e6976 + 3 extra BRIEF/NOTES editors 39f90e0b/aa3c872b/6e48f6f9), --no-discover, fresh level-42 kit, usage file with 592 rows (580 main + 12 subagents, 584 attached to the bundle).
- SUBMITTED 24 Nov ~19:53 WIB on Joni's "Setuju, submit round 5" (19:39 WIB): submission `01a20d9e-a53d-7627-b67e-343888414498`, commit `f219eac619eed2b09e67d8fabf733330760bba41` (same commit — no new entry commit). Bundle bth03-bundle-v6-full.tar.gz (14,034,608 bytes, sha256 `08a622b37e9f37460ce70c748eeb3e50bbf4142f2dca8e33550758e4db1f452d`). Kit check `ok: true`, `failed: []` (thinking_reproduces 650/839 = 77.4% authored; thinking_revised pass — BRIEF.md from 4 messages, main.ts from 2; thinking_in_window pass — all 5,865 timestamps between the 21 Nov 19:00 UTC open and receipt; thinking_priced 584 records).
- Status after submit: **submitted, outcome not decided yet**; all server-side checks pass (account_wallet, quota, form, entry_signature, repo_owner, repo_public, license_osi, repo_created_after_open, commit_in_repo, repo_readme, repo_about). Make.fun labels this intake "round 4" in its status view. **Force_Last — round 5 supersedes round 4 (01a20166) as the standing entry.** Claim code stored in the same 0600 file (round 4 kept as previous_submission_id).
- Entries close 25 Nov 2026 02:00 WIB; results 9 Dec 2026 08:00 WIB.
