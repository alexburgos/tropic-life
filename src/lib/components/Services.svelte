<script lang="ts">
	import { site } from '$lib/site';
</script>

<section id="services" class="bg-ink-900 py-20 sm:py-24">
	<div class="mx-auto max-w-6xl px-5 sm:px-8">

		<h2 class="font-semibold lg:text-2xl tracking-normal text-lagoon-400 ">Services</h2>

		<ul class="mt-12 grid gap-5 sm:grid-cols-2 lg:grid-cols-4">
			{#each site.services as service (service.title)}
				<li
					class="transition-colors hover:border-lagoon-400/60"
				>
					<h3 class="text-lg font-bold text-sand-50">{service.title}</h3>
					<p class="mt-3 text-sm leading-relaxed text-sand-300/80">{service.description}</p>
				</li>
			{/each}
		</ul>
	</div>
</section>
