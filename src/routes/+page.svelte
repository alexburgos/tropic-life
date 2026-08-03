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
</svelte:head>

<Hero />
<About />
<Services />
<ReelCarousel />
<Contact />
