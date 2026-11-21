#!/usr/bin/env python3
"""Synthesize the bring-the-humans-03 backing track, in-session.

Cheerful 120 BPM track that does NOT loop one bar: 10 distinct bars
over the chord cycle C - G - Am - F, with an intro, 16th-note hat bars,
a pluck octave lift, a snare fill into the last bar, and a sparse outro.
Four-on-the-floor kick, snare on beats 2 and 4, walking bass, plucky
arpeggio, soft pad. No samples, no downloads — every sample is computed
here with math.sin / random noise. Stdlib only.

Usage: python3 music.py <output.wav>  (20 s, stereo, 48 kHz, 16-bit)
"""
import math
import random
import struct
import sys
import wave

SR = 48000
BAR = 2.0        # seconds: 4 beats at 120 BPM
BEAT = 0.5
EIGHTH = 0.25
SIXTEENTH = 0.125

random.seed(20261122)

# Chords: root + fifth (bass), triad (pad), pluck arpeggio (8 eighths).
CHORDS = {
    "C": {
        "root": 65.41, "fifth": 98.00,
        "pad": [130.81, 164.81, 196.00],
        "pluck": [659.25, 783.99, 1046.50, 1318.51,
                  1174.66, 1046.50, 783.99, 659.25],
    },
    "G": {
        "root": 98.00, "fifth": 146.83,
        "pad": [98.00, 123.47, 146.83],
        "pluck": [587.33, 783.99, 987.77, 1174.66,
                  987.77, 783.99, 880.00, 783.99],
    },
    "Am": {
        "root": 110.00, "fifth": 164.81,
        "pad": [110.00, 130.81, 164.81],
        "pluck": [659.25, 880.00, 1046.50, 1318.51,
                  1174.66, 1046.50, 880.00, 659.25],
    },
    "F": {
        "root": 87.31, "fifth": 130.81,
        "pad": [87.31, 110.00, 130.81],
        "pluck": [698.46, 880.00, 1046.50, 1396.91,
                  1318.51, 1046.50, 880.00, 698.46],
    },
}

# (chord, pluck mode, 16th hats, kick pattern, snare fill on last beat)
# pluck mode: False = off, True = on, "oct" = one octave up.
# kick pattern: "four" = every beat, "half" = beats 1 and 3.
ARRANGEMENT = [
    ("C",  False, False, "half", False),  # 1: intro, sparse
    ("C",  True,  False, "four", False),  # 2: groove in
    ("G",  True,  False, "four", False),  # 3
    ("Am", True,  False, "four", False),  # 4
    ("F",  True,  True,  "four", False),  # 5: busier hats
    ("C",  "oct", False, "four", False),  # 6: pluck lifts an octave
    ("G",  True,  False, "four", False),  # 7
    ("Am", True,  True,  "four", False),  # 8: busier hats again
    ("F",  True,  False, "four", True),   # 9: snare fill on last beat
    ("C",  False, False, "half", False),  # 10: outro, sparse
]


def kick(u):
    """u: seconds since the beat started. Pitch 130 -> 45 Hz, fast decay."""
    if u < 0 or u >= 0.35:
        return 0.0
    phase = 2 * math.pi * (45 * u + 85 * (1 - math.exp(-12 * u)) / 12)
    return math.sin(phase) * math.exp(-14 * u)


def snare(u):
    """u: seconds since the hit started. Noise burst + 190 Hz body."""
    if u < 0 or u >= 0.18:
        return 0.0
    noise = random.uniform(-1, 1)
    body = math.sin(2 * math.pi * 190 * u) * math.exp(-22 * u)
    return (noise * 0.55 + body * 0.45) * math.exp(-20 * u)


def hat(u):
    """u: seconds since the hit started. Short bright tick."""
    if u < 0 or u >= 0.07:
        return 0.0
    return random.uniform(-1, 1) * math.exp(-90 * u)


def fade_in(e, ms=0.005):
    return min(1.0, e / ms)


def render_bar(spec):
    """Render one 2 s bar per its arrangement spec."""
    chord, pluck_mode, hats_16th, kick_pat, snare_fill = spec
    ch = CHORDS[chord]
    n = int(SR * BAR)
    out = [0.0] * n
    prev_hat = 0.0
    hat_grid = SIXTEENTH if hats_16th else EIGHTH
    for i in range(n):
        t = i / SR
        s = 0.0
        beat_idx = int(t / BEAT)
        # Kick: every beat, or beats 1 and 3 in sparse bars.
        if kick_pat == "four" or beat_idx in (0, 2):
            s += 0.9 * kick(t % BEAT)
        # Snare on beats 2 and 4, plus a 16th fill on the last beat.
        if beat_idx in (1, 3):
            s += 0.5 * snare(t % BEAT)
        if snare_fill and t >= 1.5:
            s += 0.45 * snare((t - 1.5) % SIXTEENTH)
        # Hats on the bar's grid (crude highpass by differencing).
        raw_hat = hat(t % hat_grid)
        hp = raw_hat - prev_hat
        prev_hat = raw_hat
        s += 0.35 * hp
        # Bass: root/fifth walk, one note per eighth.
        e = t % EIGHTH
        eighth_idx = int(t / EIGHTH)
        bass_seq = [ch["root"], ch["root"], ch["fifth"], ch["root"],
                    ch["root"], ch["fifth"], ch["root"], ch["fifth"]]
        bf = bass_seq[eighth_idx]
        s += 0.5 * math.sin(2 * math.pi * bf * e) * math.exp(-12 * e) * fade_in(e)
        # Pluck arpeggio for this chord, one note per eighth.
        if pluck_mode:
            pf = ch["pluck"][eighth_idx]
            if pluck_mode == "oct":
                pf *= 2
            env = math.exp(-14 * e) * fade_in(e)
            s += 0.22 * (
                math.sin(2 * math.pi * pf * e)
                + 0.3 * math.sin(2 * math.pi * 2 * pf * e)
            ) * env
        # Soft pad for this chord (local phase, no clicks at bar edges).
        for pfreq in ch["pad"]:
            s += 0.05 * math.sin(2 * math.pi * pfreq * t)
        out[i] = s
    return out


def main():
    out_path = sys.argv[1] if len(sys.argv) > 1 else "music.wav"
    full = []
    for spec in ARRANGEMENT:
        full.extend(render_bar(spec))
    total = len(full)
    # Global fades: 0.3 s in, 1 s out.
    fade_in_n = int(0.3 * SR)
    fade_out_n = int(1.0 * SR)
    for i in range(total):
        g = 1.0
        if i < fade_in_n:
            g = i / fade_in_n
        elif i >= total - fade_out_n:
            g = (total - i) / fade_out_n
        full[i] *= g
    # Soft-clip + normalize to 0.85 peak.
    peak = max(abs(v) for v in full) or 1.0
    scale = 0.85 / peak
    frames = b"".join(
        struct.pack(
            "<hh",
            int(max(-1.0, min(1.0, math.tanh(v * scale))) * 32767),
            int(max(-1.0, min(1.0, math.tanh(v * scale))) * 32767),
        )
        for v in full
    )
    with wave.open(out_path, "wb") as w:
        w.setnchannels(2)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(frames)
    print(f"wrote {out_path}: {len(full) / SR:.1f}s stereo {SR} Hz")


if __name__ == "__main__":
    main()
