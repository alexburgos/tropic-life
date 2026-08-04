<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/state';
	import { site } from '$lib/site';

	const SENTINEL_STYLE = 'position:absolute;height:1px;width:1px;pointer-events:none';

	let isOpen = $state(false);
	let isScrolled = $state(false);
	let isPastCover = $state(false);

	// Nav links are fragments on the home page, so they need a leading "/" everywhere else.
	const isHome = $derived(page.url.pathname === '/');
	const linkPrefix = $derived(isHome ? '' : '/');

	// The hero already shows the site name at full size, so the wordmark waits for the cover.
	const showWordmark = $derived(!isHome || isPastCover || isOpen);

	onMount(() => {
		// Sentinels in the document are cheaper than a scroll listener.
		const topSentinel = document.createElement('div');
		topSentinel.style.cssText = `${SENTINEL_STYLE};top:0`;

		// Measuring the hero element directly isn't an option: Nav is a sibling of <main>,
		// so the page's content may not be in the DOM yet when this runs.
		const coverSentinel = document.createElement('div');
		coverSentinel.style.cssText = `${SENTINEL_STYLE};top:calc(100svh - var(--spacing-nav))`;

		const sentinels = isHome ? [topSentinel, coverSentinel] : [topSentinel];
		for (const sentinel of sentinels) document.body.prepend(sentinel);

		const observer = new IntersectionObserver((entries) => {
			for (const entry of entries) {
				if (entry.target === topSentinel) {
					isScrolled = !entry.isIntersecting;
				} else {
					// "Not intersecting" is ambiguous here: on first paint this sentinel is
					// below the fold, not above it. Use its position instead.
					isPastCover = entry.boundingClientRect.top < 0;
				}
			}
		});
		for (const sentinel of sentinels) observer.observe(sentinel);

		return () => {
			observer.disconnect();
			for (const sentinel of sentinels) sentinel.remove();
		};
	});

	// Lock background scrolling while the mobile menu covers the page.
	$effect(() => {
		document.body.style.overflow = isOpen ? 'hidden' : '';
	});

	function handleKeydown(event: KeyboardEvent): void {
		if (event.key === 'Escape') isOpen = false;
	}
</script>

<svelte:window onkeydown={handleKeydown} />

<header
	class="fixed inset-x-0 top-0 z-50 transition-colors duration-300"
	class:bg-ink-950={isScrolled || isOpen || !isHome}
	class:shadow-lg={isScrolled && !isOpen}
	class:shadow-black={isScrolled && !isOpen}
>
	<nav
		aria-label="Main"
		class="mx-auto flex h-nav max-w-6xl items-center justify-between px-5 sm:px-8"
	>
		<a
			href={isHome ? '#top' : '/'}
			class="wordmark font-script text-xl text-sand-50 sm:text-2xl"
			class:is-hidden={!showWordmark}
			inert={!showWordmark}
			onclick={() => (isOpen = false)}
		>
			Tropic Life
		</a>

		<ul class="hidden items-center gap-8 md:flex">
			{#each site.nav as item (item.id)}
				<li>
					<a
						href="{linkPrefix}#{item.id}"
						class="text-sm font-medium tracking-widest text-sand-100/80 uppercase transition-colors hover:text-lagoon-300"
					>
						{item.label}
					</a>
				</li>
			{/each}
		</ul>

		<button
			type="button"
			class="-mr-2 inline-flex h-11 w-11 items-center justify-center rounded-md text-sand-50 md:hidden"
			aria-expanded={isOpen}
			aria-controls="mobile-menu"
			aria-label={isOpen ? 'Close menu' : 'Open menu'}
			onclick={() => (isOpen = !isOpen)}
		>
			<svg
				class="h-6 w-6"
				viewBox="0 0 24 24"
				fill="none"
				stroke="currentColor"
				stroke-width="2"
				stroke-linecap="round"
				aria-hidden="true"
			>
				{#if isOpen}
					<path d="M6 6l12 12M18 6L6 18" />
				{:else}
					<path d="M4 7h16M4 12h16M4 17h16" />
				{/if}
			</svg>
		</button>
	</nav>

	{#if isOpen}
		<div
			id="mobile-menu"
			class="fixed inset-x-0 top-nav bottom-0 z-40 bg-ink-950 md:hidden"
		>
			<ul class="flex flex-col gap-2 px-5 py-8">
				{#each site.nav as item (item.id)}
					<li>
						<a
							href="{linkPrefix}#{item.id}"
							class="block border-b border-white/10 py-4 text-2xl font-semibold tracking-tight text-sand-50"
							onclick={() => (isOpen = false)}
						>
							{item.label}
						</a>
					</li>
				{/each}
			</ul>
		</div>
	{/if}
</header>

<style>
	.wordmark {
		transition:
			opacity 300ms ease-out,
			transform 300ms ease-out;
	}

	.wordmark.is-hidden {
		opacity: 0;
		transform: translateY(-0.5rem);
	}

	@media (prefers-reduced-motion: reduce) {
		.wordmark {
			transition: none;
		}

		.wordmark.is-hidden {
			transform: none;
		}
	}
</style>
