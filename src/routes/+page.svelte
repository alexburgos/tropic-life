<script lang="ts">
	import Hero from '$lib/components/Hero.svelte';
	import About from '$lib/components/About.svelte';
	import Services from '$lib/components/Services.svelte';
	import ReelCarousel from '$lib/components/ReelCarousel.svelte';
	import Contact from '$lib/components/Contact.svelte';
	import { site } from '$lib/site';

	const title = `${site.name} — Travel & Lifestyle Content in Puerto Rico`;
</script>

<svelte:head>
	<title>{title}</title>
	<meta name="description" content={site.description} />
	<meta property="og:title" content={title} />
	<meta property="og:description" content={site.description} />
	<!--
		The hero is the LCP element, and without this the browser only discovers it after
		parsing past ten modulepreloads. Only the AVIF is preloaded: browsers that can't
		decode it ignore the tag and pick up the webp from <picture> as usual, whereas
		preloading both would make AVIF-capable browsers download the image twice.
		imagesrcset/imagesizes must match Hero.svelte's <source> exactly.
	-->
	<link
		rel="preload"
		as="image"
		type="image/avif"
		imagesrcset="/media/images/cover-900.avif 900w, /media/images/cover-1400.avif 1400w, /media/images/cover-2000.avif 2000w"
		imagesizes="100vw"
		fetchpriority="high"
	/>
</svelte:head>

<Hero />
<About />
<Services />
<ReelCarousel />
<Contact />
