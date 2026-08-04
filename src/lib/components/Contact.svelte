<script lang="ts">
	import { reveal } from '$lib/actions/reveal';
	import { site } from '$lib/site';

	const subject = encodeURIComponent('Booking enquiry — Tropic Life');
	const mailto = `mailto:${site.email}?subject=${subject}`;
</script>

<section id="contact" class="bg-sand-50 py-20 text-ink-900 sm:py-28">
	<div class="reveal mx-auto max-w-3xl px-5 text-center sm:px-8" use:reveal>
		<h2 class="mt-4 text-2xl leading-tight md:text-4xl">
			Want to work together?
		</h2>
		<p class="mt-6 text-lg leading-relaxed text-ink-800/85">
			Tell me about your property, event or brand and I'll come back with availability and a quote.
		</p>

		<a
			href={mailto}
			class="mt-10 inline-flex items-center justify-center rounded-full bg-lagoon-400 px-10 py-4 text-base font-bold tracking-wide text-white transition-colors hover:bg-lagoon-500"
		>
		Send a message
		</a>

		<p class="mt-6 text-sm text-ink-800/70">
			Or email directly:
			<a href="mailto:{site.email}" class="font-semibold text-lagoon-400 underline underline-offset-4">
				{site.email}
			</a>
		</p>
	</div>
</section>
