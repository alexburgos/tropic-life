<script lang="ts">
	import { reveal } from '$lib/actions/reveal';
	import { site } from '$lib/site';
</script>

<section id="services" class="bg-ink-900 py-20 sm:py-24">
	<div class="mx-auto max-w-6xl px-5 sm:px-8">
		<div class="reveal max-w-2xl" use:reveal>
			<p class="text-xs font-semibold tracking-[0.3em] text-lagoon-400 uppercase">Services</p>
			<h2 class="mt-4 text-4xl font-black tracking-tight text-sand-50 sm:text-5xl">
				What I shoot for you.
			</h2>
		</div>

		<ul class="mt-12 grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
			{#each site.services as service (service.title)}
				<li
					class="reveal rounded-2xl border border-white/10 bg-white/[0.04] p-6 transition-colors hover:border-lagoon-400/60"
					use:reveal
				>
					<h3 class="text-lg font-bold text-sand-50">{service.title}</h3>
					<p class="mt-3 text-sm leading-relaxed text-sand-300/80">{service.description}</p>
				</li>
			{/each}
		</ul>
	</div>
</section>
