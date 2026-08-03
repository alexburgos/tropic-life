<script lang="ts">
	import { onMount } from 'svelte';
	import { page } from '$app/state';
	import { site } from '$lib/site';

	let isOpen = $state(false);
	let isScrolled = $state(false);

	// Nav links are fragments on the home page, so they need a leading "/" everywhere else.
	const isHome = $derived(page.url.pathname === '/');
	const linkPrefix = $derived(isHome ? '' : '/');

	onMount(() => {
		// A sentinel at the top of the document is cheaper than a scroll listener.
		const sentinel = document.createElement('div');
		sentinel.style.cssText = 'position:absolute;top:0;height:1px;width:1px;pointer-events:none';
		document.body.prepend(sentinel);

		const observer = new IntersectionObserver((entries) => {
			isScrolled = !entries[0].isIntersecting;
		});
		observer.observe(sentinel);

		return () => {
			observer.disconnect();
			sentinel.remove();
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
			class="text-lg font-bold tracking-tight text-sand-50 sm:text-xl"
			onclick={() => (isOpen = false)}
		>
			Tropic<span class="text-brand-500">Life</span>
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
