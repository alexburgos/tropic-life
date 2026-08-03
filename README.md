# tropiclifepr.com

One-page marketing site for Tropic Life — travel, tourism and lifestyle content in Puerto Rico.
SvelteKit (Svelte 5 runes) + Tailwind 4, prerendered to static files with `adapter-static`.

## Developing

```sh
pnpm install
pnpm dev
```

```sh
pnpm check     # svelte-check, TS strict
pnpm build     # static output in build/
pnpm preview
```

## Content

Copy, contact details, services and the reel list all live in `src/lib/site.ts` — that's the only
file to touch for routine content edits.

> The email address and the Facebook / Instagram URLs in `site.ts` are placeholders.

`src/routes/terms/+page.svelte` is a **draft** set of terms, not reviewed by a lawyer.

## Media

`static/media/` is generated output. The originals live in `media-src/` (gitignored — keep a backup
elsewhere) and are re-encoded by:

```sh
./scripts/encode-media.sh    # needs ffmpeg + cwebp
```

The script emits responsive WebP images and 9:16 H.264 MP4 reels with WebP posters. The 9:16 crop
is baked in at encode time; per-clip crop offsets and trims are variables at the top of the script.

## Deploying

Static host, e.g. Cloudflare Pages:

- build command: `pnpm build`
- output directory: `build`

Then point the `tropiclifepr.com` DNS (currently at GoDaddy) at the host.
