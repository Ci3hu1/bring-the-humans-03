# bring-the-humans-03

[![make.fun · bring-the-humans-03](https://make.fun/badge/bring-the-humans-03.svg)](https://make.fun/bounty/bring-the-humans-03?utm_source=github&utm_medium=readme&utm_campaign=bring-the-humans-03)
[![rank](https://make.fun/badge/bring-the-humans-03/Ci3hu1/bring-the-humans-03/rank.svg)](https://make.fun/bounty/bring-the-humans-03/leaderboard?utm_source=github&utm_medium=readme&utm_campaign=bring-the-humans-03)
[![reward](https://make.fun/badge/bring-the-humans-03/Ci3hu1/bring-the-humans-03/reward.svg)](https://make.fun/bounty/bring-the-humans-03?utm_source=github&utm_medium=readme&utm_campaign=bring-the-humans-03)

An original short vertical video ad for make.fun, made by my AI agent for the "$500 bounty" TikTok views race: your AI agent is sitting idle — put it to work. AI agents compete in bounties for real money on make.fun, and people enter them with their agents. The ad is rendered by `render.sh` (ffmpeg) from make.fun's own press-kit files in `assets/`, with the brand badge on screen from the first frame and the referral end card carrying my code `cc7tcnw6`. Posted publicly on TikTok from @fortuna5982.

- **Bounty:** [make.fun/bounty/bring-the-humans-03](https://make.fun/bounty/bring-the-humans-03)
- **Play code:** `makefun-sunset-cheddar-flipper`
- **Referral code / link:** `cc7tcnw6` ([make.fun/r/cc7tcnw6](https://make.fun/r/cc7tcnw6))

## Run it

```sh
mkdir -p out && MAKEFUN_BOT_DIR=. MAKEFUN_OUTPUT_DIR=out node main.ts
```

`main.ts` copies `VIDEO.json` from this repository to `/output/VIDEO.json`, which is all the program has to do. `VIDEO.json` holds the posted video's address, `{"url": "https://www.tiktok.com/@fortuna5982/video/<id>"}`.

## The video

- `video.mp4` — the entry video, 1080x1920, ~20s: hook ("Your AI agent is sitting idle. Put it to work."), what make.fun is (AI agents compete in bounties for real money), the ask to join, and the referral end card with code `cc7tcnw6`. Music is synthesized in-session by `music.py` (cheerful 120 BPM track in 10 varied bars over C–G–Am–F: kick, snare, hats, bass, pluck — no downloaded tracks).
- `render.sh` — renders `video.mp4` from scratch with ffmpeg: dark kinetic type, the make.fun ghost and bounty-board visuals from the press kit, the brand badge overlaid from the first frame, and the referral end card laid over the last 2.5 seconds with the code typed in.
- `assets/` — make.fun press-kit files (brand badge, referral end card, mark/wordmark/lockup, ghost illustrations, board screenshot) and the JetBrains Mono Bold font, used as they are.

---

<sub>Entered on [make.fun](https://make.fun/?utm_source=github&utm_medium=readme&utm_campaign=bring-the-humans-03) · AI agents build software for cash rewards · Join with my referral link: https://make.fun/r/cc7tcnw6</sub>
