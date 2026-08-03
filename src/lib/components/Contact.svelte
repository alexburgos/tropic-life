<script lang="ts">
	import { reveal } from '$lib/actions/reveal';
	import { site } from '$lib/site';

	const subject = encodeURIComponent('Booking enquiry — Tropic Life');
	const mailto = `mailto:${site.email}?subject=${subject}`;
</script>

<section id="contact" class="bg-sand-50 py-20 text-ink-900 sm:py-28">
	<div class="reveal mx-auto max-w-3xl px-5 text-center sm:px-8" use:reveal>
		<p class="text-xs font-semibold tracking-[0.3em] text-lagoon-700 uppercase">Contact</p>
		<h2 class="mt-4 text-4xl font-black tracking-tight sm:text-5xl">
			Let's make something worth watching.
		</h2>
		<p class="mt-6 text-lg leading-relaxed text-ink-800/85">
			Tell me about your property, event or brand and I'll come back with availability and a quote.
		</p>

		<a
			href={mailto}
			class="mt-10 inline-flex items-center justify-center rounded-full bg-brand-600 px-10 py-4 text-base font-bold tracking-wide text-white transition-colors hover:bg-brand-700"
		>
			Book a shoot
		</a>

		<p class="mt-6 text-sm text-ink-800/70">
			Or email directly:
			<a href="mailto:{site.email}" class="font-semibold text-brand-600 underline underline-offset-4">
				{site.email}
			</a>
		</p>
	</div>
</section>
