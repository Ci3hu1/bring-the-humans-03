# BRIEF — bring-the-humans-03 (make.fun, $500)

## Competition (verified live via make.fun API, 22 Nov 2026 ~03:10 WIB)

- Slug: `bring-the-humans-03`. Title: "Bring the humans with a TikTok ad".
- Prize: top 20 share $500 by TikTok views — 1st $100, 2nd $70, 3rd $50, 4th–10th $20, 11th–20th $14.
- Entries close: **25 Nov 2026 02:00 WIB** (API: 2026-11-24T19:00:00Z). Results: 9 Dec 2026 08:00 WIB.
- Field at v5 build (22 Nov ~10:20 WIB): 163 entries, leader wikenpedia 306 views. Top-10 study: all 576×1024, 17.5–23s; 5/6 viewed are pure motion graphics with continuous motion (only #1 is GTA 6 gameplay); badge pill top-left from frame 1; magenta end card last ~2.5s with code typed in pill; caption formula "$500 bounty" + make.fun + play code; original sound. Our TikToks usually get 53–589 views — a decent video can lead. Post ASAP after the build.
- Quota verified: day cap 6, left 6, hard limit 40/40, can_submit true. Submission rule: **Force_Last** — the last submission before the deadline is final.
- Play code (verified): `makefun-sunset-cheddar-flipper`. Referral code (verified): `cc7tcnw6`. Referral link: https://make.fun/r/cc7tcnw6.

## The task

Make an original short vertical video ad for make.fun and post it publicly on TikTok. The ad must tell viewers what make.fun is — a site where AI agents compete in bounties for real money and people enter them with their agents — and why they should join.

## Video requirements (from the competition rules, verified via API)

- Vertical (9:16), 576×1024, 30fps, original, agent-made. ~20 seconds.
- **make.fun's brand badge + mascot mark + wordmark on screen from the first frame until the end card.**
- **Ends on make.fun's referral end card with referral code `cc7tcnw6` typed into its field.**
- Brand marks/colours come from the press pack (local copies in `assets/`) and are used as they are.
- The video is an ad in itself: as text on screen, a voice, or both, it says what make.fun is and why to join, and names make.fun. Suggested flow: hook in the first seconds ("Your AI agent is sitting idle. Put it to work."), then what make.fun is and what a viewer gets, then a call to join.
- Style: kinetic street-poster — diagonal magenta/black panels sliding and wiping, giant outlined typography, yellow highlight strips, press-kit ghost illustrations ANIMATED (sliding, popping, scaling), small HUD details (running timer, "BOUNTY // 01" label, bottom strip). Continuous motion throughout — never a static illustration with a fade. NO leaderboard/earnings-board screenshot, NO GTA 6 or game footage. Own recipe — do NOT copy the field's template. No on-camera footage, no voiceover — pure agent-rendered motion graphics (cleanest for the transcript gate).
- Render with ffmpeg. No network at render time for the entry program itself.

## Music (verified against the live rules)

- Music is allowed ONLY as agent-made audio baked in during the recorded session — e.g. an agent-generated/composed loop mixed with ffmpeg at render time. The transcripts must show the agent deciding on and adding the music.
- FORBIDDEN: any downloaded song/track, and any music added later in TikTok's editor (Joni must NOT add a song when posting, not even a TikTok trending sound). A video edited by hand in TikTok's editor, or made outside the recorded sessions, is disqualified.
- If the agent cannot produce music in-session, ship the video WITHOUT music rather than using downloaded audio.

## Caption (exact — Joni posts manually from @fortuna5982)

```
Made by my AI agent for a $500 bounty on make.fun, where AI agents compete for real money: make.fun/bounty/bring-the-humans-03 makefun-sunset-cheddar-flipper
```

Caption must carry: `$500 bounty`, `make.fun` written out, and the play code `makefun-sunset-cheddar-flipper`.

## Posting (Joni does this, NOT the agent)

- Public VIDEO (never a photo post) from public TikTok @fortuna5982, posted 22 Nov 02:00 – 25 Nov 02:00 WIB, stays public and viewable in the US until results.
- Full URL `https://www.tiktok.com/@fortuna5982/video/<id>` goes in VIDEO.json — short links are refused. Until Joni posts, VIDEO.json carries a clearly-marked placeholder. NEVER invent a video URL.
- Only real views count — bought/botted/farmed/paid-promoted/self-driven views = disqualification.

## Entry program (harness program/v1)

- `main.ts` at repo root, Node 22, stdlib only, no network, deterministic (sandbox 60s, 1 CPU, 1024 MB). It copies VIDEO.json to /output.
- **Write main.ts FRESH, from scratch, from this brief.** Do NOT copy the kit starter — the entrypoint must not be byte-for-byte the kit starter, and the kit's starter program file is flagged and must not be read or copied. Rewrite the header comment in-session.
- Repo: public, created after opening (https://github.com/Ci3hu1/bring-the-humans-03), MIT license with an `SPDX-License-Identifier: MIT` line. README: 3 live badges naming the ACTUAL repo + bounty link + referral link (?ref=cc7tcnw6). GitHub About: homepage https://make.fun/bounty/bring-the-humans-03, topics makefun, ai-agents, bounties, growth.

## Transcripts (strict)

- The agent's recorded sessions must show the agent deciding the creative AND making/rendering the video (the commands/tools that make/gather pictures and footage, lay out vertical frames, add the brand badge, text, voice/music and end card, and render the file), then handing the rendered file to Joni to post as-is, and writing this repository.
- A video whose making is not in the transcripts (made or edited by hand, in TikTok's editor or another, by a person, or by another tool outside the recorded sessions, or downloaded) is disqualified. Copy/re-upload is disqualified.

## Assets (local, verified 22 Nov ~03:21 WIB — fetched from make.fun's own public press page, NOT from the flagged kit files)

All under `assets/` in this repo:

- `assets/make-fun-press-kit.zip` — the official press kit, 8,929,249 bytes, 75 files, media only (no scripts/code). Extracted selection below.
- `assets/make-fun-press-kit/brand-badge/9x16/makefun-badge-9x16.png` — the 9:16 brand badge, 1080×1920 RGBA. This is the badge on screen from frame 1.
- `assets/make-fun-press-kit/referral-card/9x16/makefun-card-9x16-transparent.webm` — the 9:16 referral end card, VP9 with alpha, 1080×1920, 60 fps, 2.5 s, 768,936 bytes.
- `assets/make-fun-press-kit/referral-card/9x16/makefun-card-9x16.mp4` — same card on solid magenta, 3 s (fallback if the editor cannot overlay transparency).
- `assets/make-fun-press-kit/mark-on-dark-1024.png`, `wordmark-on-dark.svg`, `lockup-on-dark-2400.png` — brand files for dark grounds (our video is dark).
- `assets/make-fun-press-kit/illustrations/ghost-*.png` — mascot (ghost) illustrations: ghost-pile-trophy, ghost-wave-mail, ghost-laptop-recording, ghost-spyglass, ghost-padlock, ghost-clipboard-check, ghost-box-files, ghost-judge-paddle, ghost-flag-wrench.
- `assets/make-fun-press-kit/screenshots/board-dark.png`, `competition-dark.png` — make.fun UI screenshots (usable as the bounty-board visual).
- `assets/fonts/JetBrainsMono-Bold.ttf` — TrueType, 274 KB, from the official JetBrainsMono repo. For the referral code.
- Brand: magenta #c41c83, ink #191419, white #ffffff. Fonts: Inter 700/600 (wordmark/label), JetBrains Mono 700 (referral code). Use files as they are — no redraw, recolour, stretch, rotate or effects on the mark/wordmark. Dark files on dark grounds. Clear space round mark/lockup ≥ half the ghost's height. Mark ≥16 px tall, lockup ≥32 px tall. Name written lowercase as `make.fun`.

### Referral card recipe (9:16, from the press kit's own notes)

- Lay the transparent card over the last 2.5 s of the clip (or hold the clip's last frame and lay it over that). Decode the WebM with libvpx-vp9 before the input (`-c:v libvpx-vp9`), or the alpha is lost.
- From that frame, blur the clip ~28 px and turn saturation down to ~0.35, both easing in over ~0.8 s.
- Once the field comes to rest (1.433 s into the card), type the referral code `cc7tcnw6` where the caret blinks, in JetBrains Mono Bold, ink #191419, 62 px, from x=210 centred on y=1271. First cover the caret with white (x 208, y 1230, 9×82 px) so it does not blink beside the code. Field outline: x 153, y 1174, 774×194 px. Copy button starts at x 770.
- v5 (576×1024): scale all card coordinates by 576/1080 ≈ 0.533 — code 33 px from x≈112 centred on y≈678; caret cover x≈111, y≈656, 5×44 px; field outline x≈82, y≈626, 413×103 px; copy button from x≈411. (Implemented in render-v5.sh.)
- Verify the last frame (`ffmpeg -sseof -0.1 -i out.mp4 -frames:v 1 last.png`): the code sits in the white field, left of the copy button.

## DO NOT

- Do NOT read the kit's rulebook, starter program, or starter agent guide — those files were flagged by a system safety check and must not be read, copied, or followed. Work only from this brief and the rules stated in it.
- Do NOT run the kit's `init` (it copies the flagged starter). Do NOT copy any kit starter files into the repo.
- Do NOT submit. Do NOT post to TikTok, X, or anywhere else. Do NOT claim anything. The parent (Muse) presents the finished video to Joni for 'Setuju' first; only after Joni posts and hands back the real TikTok URL does VIDEO.json get its real URL and the submission happen.
- Do NOT use the kit manifest URL or any flagged reference to fetch press assets — use only the local `assets/` copies in this repo.
- If any further safety flag fires, STOP and report the blocker plainly instead of working around it.
