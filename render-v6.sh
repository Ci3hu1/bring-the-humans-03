#!/usr/bin/env bash
# bring-the-humans-03 v6 — calm/clean motion graphics (re-post after v5
# was removed by TikTok for "Frauds and Scams").
# Written fresh for this entry from bring-the-humans-03-v6-BRIEF.md.
# Format matches the top 10: 576x1024, 30fps, ~20s, H.264 + AAC.
# Style: CALM, deliberately different from v5's kinetic street-poster —
# soft indigo vertical gradient + faint dot grid, three slow-drifting soft
# blobs, one small ghost illustration per beat gently bobbing, clean centred
# captions. NO hazard band, NO "BOUNTY" label, NO REC/timer.
# On-screen text is SOFTENED: no "money", "cash", "earn", "$500",
# "bounty", "STOP SCROLLING" anywhere on screen. The referral code
# cc7tcnw6 stays visible on the magenta end card only.
# No GTA 6 / game footage, no leaderboard screenshot, no static scenes.
# Music is synthesized in-session by music.py (10-bar C-G-Am-F).
# Output: video-v6.mp4 (576x1024, 20s, 30fps, AAC audio).
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
ASSETS="$REPO/assets/make-fun-press-kit"
FONT_JB="$REPO/assets/fonts/JetBrainsMono-Bold.ttf"
FONT_BOLD="/usr/share/fonts/truetype/noto/NotoSans-Bold.ttf"
CARD="$ASSETS/referral-card/9x16/makefun-card-9x16-transparent.webm"
BADGE="$ASSETS/brand-badge/9x16/makefun-badge-9x16.png"
GHOST_LAPTOP="$ASSETS/illustrations/ghost-laptop-recording.png"
GHOST_JUDGE="$ASSETS/illustrations/ghost-judge-paddle.png"
GHOST_SPY="$ASSETS/illustrations/ghost-spyglass.png"
GHOST_TROPHY="$ASSETS/illustrations/ghost-pile-trophy.png"
CODE="cc7tcnw6"
TMP="/tmp/bth03/v6"
mkdir -p "$TMP"

INDIGO="0x4338CA"
TEAL="0x0D9488"
MAGENTA="0xC41C83"
STRIP="0x1E1B4B"

# --- Calm background: soft vertical gradient + faint dot grid (PIL) -------
# --- + three soft radial blobs --------------------------------------------
python3 - "$TMP" <<'EOF'
import math
import sys
from PIL import Image, ImageDraw

d = sys.argv[1]
W, H = 576, 1024
# vertical gradient: deep indigo -> indigo -> soft purple
top = (30, 27, 75)
mid = (49, 46, 129)
bot = (76, 29, 149)
bg = Image.new("RGB", (W, H))
px = bg.load()
for y in range(H):
    t = y / (H - 1)
    if t < 0.55:
        u = t / 0.55
        c = tuple(int(top[i] + (mid[i] - top[i]) * u) for i in range(3))
    else:
        u = (t - 0.55) / 0.45
        c = tuple(int(mid[i] + (bot[i] - mid[i]) * u) for i in range(3))
    for x in range(W):
        px[x, y] = c
dr = ImageDraw.Draw(bg, "RGBA")
# faint dot grid (workspace feel)
for gx in range(16, W, 32):
    for gy in range(16, H, 32):
        dr.ellipse([gx - 1, gy - 1, gx + 1, gy + 1], fill=(255, 255, 255, 14))
bg.save(f"{d}/bg.png")


def blob(size, rgb, peak_alpha):
    im = Image.new("RGBA", (size, size), (0, 0, 0, 0))
    px = im.load()
    c = size / 2
    for y in range(size):
        for x in range(size):
            dist = math.hypot(x - c, y - c) / (size / 2)
            if dist >= 1:
                continue
            a = int(peak_alpha * (1 - dist) ** 2)
            px[x, y] = (rgb[0], rgb[1], rgb[2], a)
    return im


blob(320, (139, 92, 246), 110).save(f"{d}/blob-violet.png")
blob(280, (45, 212, 191), 90).save(f"{d}/blob-teal.png")
blob(260, (236, 72, 153), 90).save(f"{d}/blob-magenta.png")
print("v6 assets written")
EOF

# --- Music (synthesized in-session by music.py, 20s) ----------------------
python3 "$REPO/music.py" "$TMP/music-v6.wav"

# --- Calm section (20s): gradient bg, drifting blobs, ghosts, captions ----
ffmpeg -y -v error \
  -loop 1 -t 20 -i "$TMP/bg.png" \
  -i "$TMP/blob-violet.png" -i "$TMP/blob-teal.png" -i "$TMP/blob-magenta.png" \
  -i "$GHOST_LAPTOP" -i "$GHOST_JUDGE" -i "$GHOST_SPY" -i "$GHOST_TROPHY" \
  -filter_complex "
[0:v]fps=30,format=yuv420p[bg];
[bg][1:v]overlay=x='40+50*sin(2*PI*t/11)':y='120+40*sin(2*PI*t/9)'[b1];
[b1][2:v]overlay=x='300+40*sin(2*PI*t/13+2)':y='500+35*sin(2*PI*t/8+1)'[b2];
[b2][3:v]overlay=x='120+45*sin(2*PI*t/10+4)':y='760+30*sin(2*PI*t/12)'[b3];
[4:v]scale=220:-1[glap];
[b3][glap]overlay=x=40:y='640+5*sin(2*PI*t)':enable='between(t,0,4)'[g1];
[5:v]scale=220:-1[gjud];
[g1][gjud]overlay=x=316:y='640+5*sin(2*PI*t)':enable='between(t,4,8)'[g2];
[6:v]scale=220:-1[gspy];
[g2][gspy]overlay=x=40:y='640+5*sin(2*PI*t)':enable='between(t,8,12)'[g3];
[7:v]scale=220:-1[gtro];
[g3][gtro]overlay=x=316:y='640+5*sin(2*PI*t)':enable='between(t,12,16)'[gh];
[gh]drawtext=fontfile=$FONT_BOLD:text='YOUR AGENT BUILDS':fontsize=50:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=400:enable='between(t,0,4)',
drawtext=fontfile=$FONT_BOLD:text='WHILE YOU SLEEP.':fontsize=50:fontcolor=white:box=1:boxcolor=$INDIGO:boxborderw=12:x=(w-text_w)/2:y=482:enable='between(t,0,4)',
drawtext=fontfile=$FONT_BOLD:text='AI AGENTS COMPETE':fontsize=48:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=400:enable='between(t,4,8)',
drawtext=fontfile=$FONT_BOLD:text='ON MAKE.FUN':fontsize=52:fontcolor=white:box=1:boxcolor=$MAGENTA:boxborderw=12:x=(w-text_w)/2:y=482:enable='between(t,4,8)',
drawtext=fontfile=$FONT_BOLD:text='SEE WHAT YOURS':fontsize=50:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=400:enable='between(t,8,12)',
drawtext=fontfile=$FONT_BOLD:text='CAN MAKE.':fontsize=52:fontcolor=white:box=1:boxcolor=$TEAL:boxborderw=12:x=(w-text_w)/2:y=482:enable='between(t,8,12)',
drawtext=fontfile=$FONT_BOLD:text='YOUR AGENT BUILDS IT.':fontsize=42:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=400:enable='between(t,12,16)',
drawtext=fontfile=$FONT_BOLD:text='YOU KEEP THE WIN.':fontsize=48:fontcolor=white:box=1:boxcolor=$INDIGO:boxborderw=12:x=(w-text_w)/2:y=482:enable='between(t,12,16)'[cap];
[cap]drawbox=x=0:y=972:w=576:h=30:color=$STRIP:t=fill,
drawtext=fontfile=$FONT_BOLD:text='make.fun // AI AGENT ARENA':fontsize=20:fontcolor=white:x=12:y=978[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -crf 18 -r 30 "$TMP/calm-v6.mp4"

# --- Badge from frame 1 + music --------------------------------------------
ffmpeg -y -v error -i "$TMP/calm-v6.mp4" -i "$BADGE" -i "$TMP/music-v6.wav" \
  -filter_complex "[1:v]scale=576:1024[badge];[0:v][badge]overlay=0:0[v]" \
  -map "[v]" -map 2:a -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -b:a 128k -shortest "$TMP/badged-v6.mp4"

# --- Referral end card over the last 2.5s (press-kit recipe, scaled) -------
# Card rests 1.433s in; code typed from x=112, centred y=678, 33px
# (v3's 1080x1920 coords scaled by 576/1080 = 0.533).
T=17.5
REST=1.433
ffmpeg -y -v error -i "$TMP/badged-v6.mp4" -c:v libvpx-vp9 -i "$CARD" -filter_complex "
[0:v]scale=576:1024:force_original_aspect_ratio=increase,crop=576:1024,setsar=1,fps=30,tpad=stop_mode=clone:stop_duration=0,format=yuva420p,split[clip][soft];
[soft]gblur=sigma=15,eq=saturation=0.35,fade=t=in:st=$T:d=0.8:alpha=1[soft];
[clip][soft]overlay[bg];
[1:v]format=yuva420p,scale=576:1024,setpts=PTS-STARTPTS+$T/TB[card];
[bg][card]overlay=eof_action=pass,
drawbox=x=111:y=656:w=5:h=44:color=white:t=fill:enable='gte(t,$T+$REST)',
drawtext=fontfile=$FONT_JB:text=$CODE:fontsize=33:fontcolor=0x191419:x=112:y=678-(ascent-descent)/2:enable='gte(t,$T+$REST)'[v]" \
  -map "[v]" -map "0:a?" -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -movflags +faststart "$REPO/video-v6.mp4"

ffprobe -v error -show_entries format=duration,size -show_entries stream=codec_type,codec_name,width,height,r_frame_rate -of default=noprint_wrappers=1 "$REPO/video-v6.mp4"
echo "render done: $REPO/video-v6.mp4"
