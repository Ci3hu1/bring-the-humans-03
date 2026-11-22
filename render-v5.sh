#!/usr/bin/env bash
# bring-the-humans-03 v5 — kinetic street-poster motion graphics.
# Written fresh for this entry from BRIEF.md + bth03-top10-study.md.
# Format matches the top 10: 576x1024, 30fps, ~20s, H.264 + AAC.
# Style: pure motion graphics with CONTINUOUS motion (top-10 #7 recipe) —
# diagonal magenta/dark panels sliding and wiping, giant ghosted words
# scrolling, yellow highlight strips, press-kit ghost illustrations
# ANIMATED (sliding in, bobbing), HUD details (REC, running timer,
# "BOUNTY // 01" vertical label, bottom strip, hazard band).
# No GTA 6 / game footage, no leaderboard screenshot, no static scenes.
# Music is synthesized in-session by music.py (10-bar C-G-Am-F).
# Output: video-v5.mp4 (576x1024, 20s, 30fps, AAC audio).
set -euo pipefail

REPO="$(cd "$(dirname "$0")" && pwd)"
ASSETS="$REPO/assets/make-fun-press-kit"
FONT_JB="$REPO/assets/fonts/JetBrainsMono-Bold.ttf"
FONT_BOLD="/usr/share/fonts/truetype/noto/NotoSans-Bold.ttf"
CARD="$ASSETS/referral-card/9x16/makefun-card-9x16-transparent.webm"
BADGE="$ASSETS/brand-badge/9x16/makefun-badge-9x16.png"
GHOST_SPY="$ASSETS/illustrations/ghost-spyglass.png"
GHOST_LAPTOP="$ASSETS/illustrations/ghost-laptop-recording.png"
GHOST_TROPHY="$ASSETS/illustrations/ghost-pile-trophy.png"
GHOST_JUDGE="$ASSETS/illustrations/ghost-judge-paddle.png"
CODE="cc7tcnw6"
TMP="/tmp/bth03"
mkdir -p "$TMP/panels"

INK="0x191419"
MAGENTA="0xC41C83"
YELLOW="0xFFD400"

# --- Diagonal panels + hazard band + vertical label (PIL) ----------------
python3 - "$TMP/panels" <<'EOF'
import sys
from PIL import Image, ImageDraw, ImageFont
d = sys.argv[1]
W, H = 576, 1024
# magenta diagonal band
im = Image.new("RGBA", (W, H), (0, 0, 0, 0))
dr = ImageDraw.Draw(im)
dr.polygon([(0, 260), (W, 60), (W, 340), (0, 540)], fill=(196, 28, 131, 255))
im.save(f"{d}/panel-magenta.png")
# darker magenta diagonal band
im = Image.new("RGBA", (W, H), (0, 0, 0, 0))
dr = ImageDraw.Draw(im)
dr.polygon([(0, 640), (W, 470), (W, 660), (0, 830)], fill=(120, 18, 80, 255))
im.save(f"{d}/panel-dark.png")
# thin yellow diagonal band (wipe)
im = Image.new("RGBA", (W, H), (0, 0, 0, 0))
dr = ImageDraw.Draw(im)
dr.polygon([(0, 160), (W, 90), (W, 120), (0, 190)], fill=(255, 212, 0, 255))
im.save(f"{d}/panel-yellow.png")
# hazard band: black with yellow diagonal stripes
tile = Image.new("RGB", (44, 22), (0, 0, 0))
td = ImageDraw.Draw(tile)
td.polygon([(0, 22), (22, 0), (44, 0), (22, 22)], fill=(255, 212, 0))
hz = Image.new("RGB", (W, 22), (0, 0, 0))
for x in range(0, W, 44):
    hz.paste(tile, (x, 0))
hz.save(f"{d}/hazard.png")
# vertical "BOUNTY // 01" label (rotated 90 deg)
bold = "/usr/share/fonts/truetype/noto/NotoSans-Bold.ttf"
f = ImageFont.truetype(bold, 26)
lab = Image.new("RGBA", (320, 44), (0, 0, 0, 0))
ld = ImageDraw.Draw(lab)
ld.text((4, 6), "BOUNTY // 01", font=f, fill=(255, 255, 255, 255))
lab = lab.rotate(90, expand=True)
lab.save(f"{d}/label-v.png")
print("panels written")
EOF

# --- Music (synthesized in-session by music.py, 20s) ----------------------
python3 "$REPO/music.py" "$TMP/music-v5.wav"

# --- Kinetic section (20s): panels, ghost words, ghosts, captions, HUD ----
ffmpeg -y -v error \
  -f lavfi -i "color=c=$INK:s=576x1024:r=30:d=20" \
  -i "$TMP/panels/panel-magenta.png" \
  -i "$TMP/panels/panel-dark.png" \
  -i "$TMP/panels/panel-yellow.png" \
  -i "$GHOST_SPY" -i "$GHOST_LAPTOP" -i "$GHOST_TROPHY" -i "$GHOST_JUDGE" \
  -i "$TMP/panels/label-v.png" -i "$TMP/panels/hazard.png" \
  -filter_complex "
[0:v][1:v]overlay=x='-576+576*min(t/1.5,1)':y=0[pm];
[pm][2:v]overlay=x='576-576*min(max((t-1)/1.5,0),1)':y=0[pd];
[pd][3:v]overlay=x='-576+1152*mod(t/4,1)':y=0[pw];
[pw]drawtext=fontfile=$FONT_BOLD:text='AGENT':fontsize=150:fontcolor=white@0.10:x='-435+1011*mod(t/6,1)':y=140,
drawtext=fontfile=$FONT_BOLD:text='COMPETE':fontsize=150:fontcolor=white@0.10:x='576-1098*mod(t/7,1)':y=830[gw];
[4:v]scale=260:-1[gspy];
[gw][gspy]overlay=x='-260+260*min(t/0.8,1)':y='660+6*sin(2*PI*t)':enable='between(t,0,4)'[s1];
[5:v]scale=300:-1[glap];
[s1][glap]overlay=x='576-300*min(max((t-4)/0.8,0),1)':y='650+6*sin(2*PI*t)':enable='between(t,4,8)'[s2];
[6:v]scale=-1:300[gtro];
[s2][gtro]overlay=x=182:y='1024-364*min(max((t-8)/0.8,0),1)+6*sin(2*PI*t)':enable='between(t,8,12)'[s3];
[7:v]scale=260:-1[gjud];
[s3][gjud]overlay=x='-260+260*min(max((t-12)/0.8,0),1)':y='660+6*sin(2*PI*t)':enable='between(t,12,16)'[gh];
[gh]drawtext=fontfile=$FONT_BOLD:text='STOP':fontsize=120:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=400:enable='between(t,0,4)',
drawtext=fontfile=$FONT_BOLD:text='SCROLLING.':fontsize=76:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=530:enable='between(t,0,4)',
drawtext=fontfile=$FONT_BOLD:text='YOUR AGENT WORKS':fontsize=50:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=430:enable='between(t,4,8)',
drawtext=fontfile=$FONT_BOLD:text='WHILE YOU SLEEP.':fontsize=50:fontcolor=black:box=1:boxcolor=$YELLOW:boxborderw=12:x=(w-text_w)/2:y=510:enable='between(t,4,8)',
drawtext=fontfile=$FONT_BOLD:text='AI AGENTS COMPETE':fontsize=48:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=430:enable='between(t,8,12)',
drawtext=fontfile=$FONT_BOLD:text='FOR REAL MONEY.':fontsize=56:fontcolor=white:box=1:boxcolor=$MAGENTA:boxborderw=12:x=(w-text_w)/2:y=510:enable='between(t,8,12)',
drawtext=fontfile=$FONT_BOLD:text='YOUR AGENT BUILDS IT.':fontsize=42:fontcolor=white:borderw=6:bordercolor=black:x=(w-text_w)/2:y=430:enable='between(t,12,16)',
drawtext=fontfile=$FONT_BOLD:text='YOU KEEP THE WIN.':fontsize=48:fontcolor=black:box=1:boxcolor=$YELLOW:boxborderw=12:x=(w-text_w)/2:y=510:enable='between(t,12,16)'[cap];
[cap][8:v]overlay=x=6:y=380[lab];
[lab]drawbox=x=0:y=972:w=576:h=30:color=$MAGENTA:t=fill,
drawtext=fontfile=$FONT_BOLD:text='make.fun // AI BOUNTY ARENA':fontsize=20:fontcolor=white:x=12:y=978,
drawbox=x=545:y=14:w=14:h=14:color=red:t=fill,
drawtext=fontfile=$FONT_BOLD:text='REC':fontsize=22:fontcolor=white:x=498:y=12,
drawtext=fontfile=$FONT_BOLD:text='%{pts\:hms}':fontsize=20:fontcolor=white:x=(w-text_w-10):y=42[hud];
[hud][9:v]overlay=x=0:y=1002[v]" \
  -map "[v]" -c:v libx264 -pix_fmt yuv420p -crf 18 -r 30 "$TMP/kinetic-v5.mp4"

# --- Badge from frame 1 + music --------------------------------------------
ffmpeg -y -v error -i "$TMP/kinetic-v5.mp4" -i "$BADGE" -i "$TMP/music-v5.wav" \
  -filter_complex "[1:v]scale=576:1024[badge];[0:v][badge]overlay=0:0[v]" \
  -map "[v]" -map 2:a -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -b:a 128k -shortest "$TMP/badged-v5.mp4"

# --- Referral end card over the last 2.5s (press-kit recipe, scaled) -------
# Card rests 1.433s in; code typed from x=112, centred y=678, 33px
# (v3's 1080x1920 coords scaled by 576/1080 = 0.533).
T=17.5
REST=1.433
ffmpeg -y -v error -i "$TMP/badged-v5.mp4" -c:v libvpx-vp9 -i "$CARD" -filter_complex "
[0:v]scale=576:1024:force_original_aspect_ratio=increase,crop=576:1024,setsar=1,fps=30,tpad=stop_mode=clone:stop_duration=0,format=yuva420p,split[clip][soft];
[soft]gblur=sigma=15,eq=saturation=0.35,fade=t=in:st=$T:d=0.8:alpha=1[soft];
[clip][soft]overlay[bg];
[1:v]format=yuva420p,scale=576:1024,setpts=PTS-STARTPTS+$T/TB[card];
[bg][card]overlay=eof_action=pass,
drawbox=x=111:y=656:w=5:h=44:color=white:t=fill:enable='gte(t,$T+$REST)',
drawtext=fontfile=$FONT_JB:text=$CODE:fontsize=33:fontcolor=0x191419:x=112:y=678-(ascent-descent)/2:enable='gte(t,$T+$REST)'[v]" \
  -map "[v]" -map "0:a?" -c:v libx264 -pix_fmt yuv420p -crf 18 -c:a aac -movflags +faststart "$REPO/video-v5.mp4"

ffprobe -v error -show_entries format=duration,size -show_entries stream=codec_type,codec_name,width,height,r_frame_rate -of default=noprint_wrappers=1 "$REPO/video-v5.mp4"
echo "render done: $REPO/video-v5.mp4"
