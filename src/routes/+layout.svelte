<script lang="ts">
	import './layout.css';
	import Nav from '$lib/components/Nav.svelte';
	import Footer from '$lib/components/Footer.svelte';
	import { site } from '$lib/site';

	let { children } = $props();

	const jsonLd = {
		'@context': 'https://schema.org',
		'@type': 'ProfessionalService',
		name: site.name,
		description: site.description,
		url: site.domain,
		email: site.email,
		areaServed: 'Puerto Rico',
		image: `${site.domain}/media/images/cover-2000.webp`,
		sameAs: site.socials.map((social) => social.href)
	};
</script>

<svelte:head>
	<!--
		Served straight from static/ rather than imported through Vite: browsers request
		/favicon.ico at a fixed path, so it must not get a hashed filename.
	-->
	<link rel="icon" href="/favicon.ico" sizes="any" />
	<link rel="icon" type="image/png" sizes="32x32" href="/favicon-32x32.png" />
	<link rel="icon" type="image/png" sizes="16x16" href="/favicon-16x16.png" />
	<link rel="apple-touch-icon" sizes="180x180" href="/apple-touch-icon.png" />
	<link rel="manifest" href="/site.webmanifest" />
	<!-- The hero title is above the fold, so the swap shouldn't wait on CSS discovery. -->
	<link
		rel="preload"
		href="/fonts/montserrat-900-latin.woff2"
		as="font"
		type="font/woff2"
		crossorigin="anonymous"
	/>
	<link rel="canonical" href={site.domain} />
	<meta name="theme-color" content="#050b0b" />
	<meta property="og:site_name" content={site.name} />
	<meta property="og:type" content="website" />
	<meta property="og:url" content={site.domain} />
	<meta property="og:image" content="{site.domain}/media/images/cover-2000.webp" />
	<meta name="twitter:card" content="summary_large_image" />
	{@html `<script type="application/ld+json">${JSON.stringify(jsonLd)}</script>`}
</svelte:head>

<Nav />
<main>
	{@render children()}
</main>
<Footer />
