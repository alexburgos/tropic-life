<script lang="ts">
	import SocialIcon from './SocialIcon.svelte';
	import { site } from '$lib/site';
</script>

<section id="top" class="relative flex min-h-[100svh] items-center justify-center overflow-hidden">
	<img
		src="/media/images/cover-1400.webp"
		srcset="/media/images/cover-1400.webp 1400w, /media/images/cover-2000.webp 2000w"
		sizes="100vw"
		alt="Aerial view of turquoise water and mangrove cays in Puerto Rico"
		class="absolute inset-0 h-full w-full object-cover"
		width="2000"
		height="1125"
		fetchpriority="high"
		decoding="async"
	/>

	<div
		class="absolute inset-0 bg-gradient-to-b from-ink-950/70 via-ink-950/20 to-ink-950/80"
		aria-hidden="true"
	></div>
	<div class="hero-vignette absolute inset-0" aria-hidden="true"></div>

	<div class="relative mx-auto max-w-4xl px-5 pt-nav text-center">
		<h1
			class="hero-text-shadow font-script text-6xl leading-tight text-white sm:text-8xl lg:text-9xl"
		>
			{site.name}
		</h1>
		<p
			class="hero-text-shadow mt-6 text-xs font-semibold tracking-normal text-lagoon-300 uppercase sm:text-lg sm:tracking-wide"
		>
			{site.tagline}
		</p>

		<ul class="mt-10 flex items-center justify-center gap-4">
			{#each site.socials as social (social.label)}
				<li>
					<a
						href={social.href}
						target="_blank"
						rel="noopener noreferrer"
						aria-label={social.label}
						class="inline-flex h-12 w-12 items-center justify-center rounded-full border border-white/30 bg-white/10 text-white backdrop-blur-sm transition-colors hover:border-lagbg-lagoon-400 hover:bg-lagoon-400"
					>
						<SocialIcon name={social.label} class="h-5 w-5" />
					</a>
				</li>
			{/each}
		</ul>
	</div>

	<a
		href="#about"
		class="absolute bottom-8 left-1/2 -translate-x-1/2 text-white/70 transition-colors hover:text-white"
		aria-label="Scroll to about"
	>
		<svg
			class="h-8 w-8 animate-bounce motion-reduce:animate-none"
			viewBox="0 0 24 24"
			fill="none"
			stroke="currentColor"
			stroke-width="1.5"
			stroke-linecap="round"
			aria-hidden="true"
		>
			<path d="M12 5v14M6 13l6 6 6-6" />
		</svg>
	</a>
</section>

<style>
	.hero-text-shadow {
		text-shadow: 0 2px 24px color-mix(in srgb, var(--color-ink-950) 45%, transparent);
	}

	.hero-vignette {
		background: radial-gradient(
			ellipse at center,
			color-mix(in srgb, var(--color-ink-950) 55%, transparent) 0%,
			transparent 65%
		);
	}
</style>
