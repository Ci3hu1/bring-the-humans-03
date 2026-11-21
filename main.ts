// bring-the-humans-03 — entrypoint.
// Written fresh for this entry from the competition brief (BRIEF.md).
// The video itself was rendered in-session with ffmpeg from the press-kit
// assets in assets/ (see BRIEF.md and render.sh); this program only hands
// the submitted TikTok link to the harness by copying VIDEO.json into the
// output directory. It makes no network calls and reads nothing outside
// this repository.

import { copyFileSync, existsSync, mkdirSync, readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";
import { join } from "node:path";

const repoRoot =
  process.env.MAKEFUN_BOT_DIR ?? fileURLToPath(new URL(".", import.meta.url));
const outDir =
  process.env.MAKEFUN_OUTPUT_DIR ?? process.env.OUTPUT_DIR ?? "/output";

const videoJsonPath = join(repoRoot, "VIDEO.json");
if (!existsSync(videoJsonPath)) {
  throw new Error("VIDEO.json is missing from the repo root");
}
const video = JSON.parse(readFileSync(videoJsonPath, "utf8"));
if (typeof video.url !== "string" || video.url.length === 0) {
  throw new Error("VIDEO.json must carry a url string");
}
mkdirSync(outDir, { recursive: true });
copyFileSync(videoJsonPath, join(outDir, "VIDEO.json"));
console.log(`VIDEO.json copied to ${outDir}: ${video.url}`);
