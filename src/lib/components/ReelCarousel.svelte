<script lang="ts">
	import { reveal } from '$lib/actions/reveal';
	import { site } from '$lib/site';

	const reels = site.reels;

	let track = $state<HTMLDivElement | null>(null);
	let section = $state<HTMLElement | null>(null);
	let slides = $state<HTMLElement[]>([]);
	let videos = $state<HTMLVideoElement[]>([]);

	let activeIndex = $state(0);
	let isSectionVisible = $state(false);
	let isMuted = $state(true);

	/**
	 * The active slide is whichever one sits closest to the centre of the track. Measuring
	 * distance beats an IntersectionObserver here: on wide screens several slides are fully
	 * visible at once, so "is it intersecting" can't pick a winner.
	 */
	function updateActiveIndex(): void {
		if (!track) return;

		const trackRect = track.getBoundingClientRect();
		const trackCentre = trackRect.left + trackRect.width / 2;

		let nearestIndex = 0;
		let nearestDistance = Number.POSITIVE_INFINITY;

		slides.forEach((slide, index) => {
			if (!slide) return;
			const rect = slide.getBoundingClientRect();
			const distance = Math.abs(rect.left + rect.width / 2 - trackCentre);
			if (distance < nearestDistance) {
				nearestDistance = distance;
				nearestIndex = index;
			}
		});

		activeIndex = nearestIndex;
	}

	// Recalculate on scroll and resize, throttled to one measurement per frame.
	$effect(() => {
		if (!track) return;

		let frame = 0;
		const schedule = (): void => {
			if (frame) return;
			frame = requestAnimationFrame(() => {
				frame = 0;
				updateActiveIndex();
			});
		};

		updateActiveIndex();
		track.addEventListener('scroll', schedule, { passive: true });
		window.addEventListener('resize', schedule);

		return () => {
			if (frame) cancelAnimationFrame(frame);
			track?.removeEventListener('scroll', schedule);
			window.removeEventListener('resize', schedule);
		};
	});

	// Nothing plays while the section is off screen — no wasted bandwidth or battery.
	$effect(() => {
		if (!section) return;

		const observer = new IntersectionObserver(
			(entries) => {
				isSectionVisible = entries[0].isIntersecting;
			},
			{ threshold: 0.25 }
		);
		observer.observe(section);
		return () => observer.disconnect();
	});

	$effect(() => {
		const shouldPlayIndex = isSectionVisible ? activeIndex : -1;

		videos.forEach((video, index) => {
			if (!video) return;
			if (index === shouldPlayIndex) {
				// Autoplay can still be refused (low power mode, unmuted playback) — that's fine,
				// the poster stays up and the visitor can hit play.
				void video.play().catch(() => undefined);
			} else {
				video.pause();
			}
		});
	});

	function scrollToSlide(index: number): void {
		const clamped = Math.max(0, Math.min(index, reels.length - 1));
		const slide = slides[clamped];
		if (!track || !slide) return;

		const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
		const slideRect = slide.getBoundingClientRect();
		const trackRect = track.getBoundingClientRect();
		const offsetToCentre =
			slideRect.left - trackRect.left - (trackRect.width - slideRect.width) / 2;

		track.scrollTo({
			left: track.scrollLeft + offsetToCentre,
			behavior: prefersReducedMotion ? 'auto' : 'smooth'
		});
	}

	function handleKeydown(event: KeyboardEvent): void {
		if (event.key === 'ArrowRight') {
			event.preventDefault();
			scrollToSlide(activeIndex + 1);
		} else if (event.key === 'ArrowLeft') {
			event.preventDefault();
			scrollToSlide(activeIndex - 1);
		}
	}
</script>

<section id="work" class="bg-ink-950 py-20 sm:py-24" bind:this={section}>
	<div class="mx-auto max-w-6xl px-5 sm:px-8">
		<div class="reveal flex flex-wrap items-end justify-between gap-6" use:reveal>
			<div>
				<p class="text-xs font-semibold tracking-[0.3em] text-lagoon-400 uppercase">My work</p>
				<h2 class="mt-4 text-4xl font-black tracking-tight text-sand-50 sm:text-5xl">
					Recent reels.
				</h2>
			</div>

			<div class="flex items-center gap-3">
				<button
					type="button"
					class="inline-flex h-11 w-11 items-center justify-center rounded-full border border-white/20 text-sand-50 transition-colors hover:border-lagoon-400 hover:text-lagoon-300"
					aria-label={isMuted ? 'Unmute reels' : 'Mute reels'}
					aria-pressed={!isMuted}
					onclick={() => (isMuted = !isMuted)}
				>
					<svg
						class="h-5 w-5"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="1.8"
						stroke-linecap="round"
						stroke-linejoin="round"
						aria-hidden="true"
					>
						<path d="M11 5 6 9H3v6h3l5 4V5z" />
						{#if isMuted}
							<path d="m17 9 4 6M21 9l-4 6" />
						{:else}
							<path d="M15.5 8.5a5 5 0 0 1 0 7M18.5 5.5a9 9 0 0 1 0 13" />
						{/if}
					</svg>
				</button>

				<button
					type="button"
					class="inline-flex h-11 w-11 items-center justify-center rounded-full border border-white/20 text-sand-50 transition-colors hover:border-lagoon-400 hover:text-lagoon-300 disabled:opacity-30"
					aria-label="Previous reel"
					disabled={activeIndex === 0}
					onclick={() => scrollToSlide(activeIndex - 1)}
				>
					<svg
						class="h-5 w-5"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2"
						stroke-linecap="round"
						aria-hidden="true"
					>
						<path d="M15 19l-7-7 7-7" />
					</svg>
				</button>

				<button
					type="button"
					class="inline-flex h-11 w-11 items-center justify-center rounded-full border border-white/20 text-sand-50 transition-colors hover:border-lagoon-400 hover:text-lagoon-300 disabled:opacity-30"
					aria-label="Next reel"
					disabled={activeIndex === reels.length - 1}
					onclick={() => scrollToSlide(activeIndex + 1)}
				>
					<svg
						class="h-5 w-5"
						viewBox="0 0 24 24"
						fill="none"
						stroke="currentColor"
						stroke-width="2"
						stroke-linecap="round"
						aria-hidden="true"
					>
						<path d="M9 5l7 7-7 7" />
					</svg>
				</button>
			</div>
		</div>
	</div>

	<!--
		The track is deliberately focusable: a scrollable region must be reachable by keyboard,
		and arrow keys then move between reels.
	-->
	<!-- svelte-ignore a11y_no_noninteractive_element_interactions, a11y_no_noninteractive_tabindex -->
	<div
		class="carousel-track mt-12 flex snap-x snap-mandatory gap-4 overflow-x-auto px-[max(1.25rem,calc(50%-10rem))] pb-4 sm:gap-6"
		role="group"
		aria-roledescription="carousel"
		aria-label="Recent reels"
		tabindex="0"
		bind:this={track}
		onkeydown={handleKeydown}
	>
		{#each reels as reel, index (reel.src)}
			<figure
				class="w-[min(20rem,78vw)] shrink-0 snap-center"
				bind:this={slides[index]}
				aria-roledescription="slide"
				aria-label="{index + 1} of {reels.length}: {reel.title}"
			>
				<div
					class="relative overflow-hidden rounded-3xl border border-white/10 bg-ink-900 shadow-2xl transition-opacity duration-500"
					class:opacity-45={index !== activeIndex}
				>
					<!-- svelte-ignore a11y_media_has_caption -->
					<video
						class="aspect-[9/16] h-full w-full object-cover"
						src="/media/videos/{reel.src}.mp4"
						poster="/media/videos/{reel.src}.webp"
						preload={Math.abs(index - activeIndex) <= 1 ? 'metadata' : 'none'}
						muted={isMuted}
						loop
						playsinline
						controls={index === activeIndex}
						controlslist="nodownload noplaybackrate"
						disablepictureinpicture
						bind:this={videos[index]}
					></video>
				</div>
				<figcaption class="mt-4 text-center text-sm font-medium tracking-wide text-sand-300/70">
					{reel.title}
				</figcaption>
			</figure>
		{/each}
	</div>

	<div class="mt-6 flex items-center justify-center gap-2">
		{#each reels as reel, index (reel.src)}
			<button
				type="button"
				class="h-2.5 rounded-full transition-all duration-300"
				class:w-8={index === activeIndex}
				class:bg-brand-500={index === activeIndex}
				class:w-2.5={index !== activeIndex}
				class:bg-sand-300={index !== activeIndex}
				class:opacity-40={index !== activeIndex}
				aria-label="Go to reel {index + 1}: {reel.title}"
				aria-current={index === activeIndex}
				onclick={() => scrollToSlide(index)}
			></button>
		{/each}
	</div>

	<p class="sr-only" aria-live="polite">
		Reel {activeIndex + 1} of {reels.length}: {reels[activeIndex].title}
	</p>
</section>

<style>
	.carousel-track {
		scrollbar-width: none;
	}

	.carousel-track::-webkit-scrollbar {
		display: none;
	}
</style>
