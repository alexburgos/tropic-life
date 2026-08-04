<script lang="ts">
	import { reveal } from '$lib/actions/reveal';
</script>

<section id="about" class="bg-sand-50 py-20 text-ink-900 sm:py-28">
	<div class="mx-auto grid max-w-6xl items-center gap-12 px-5 sm:px-8 lg:grid-cols-2 lg:gap-16">
		<div class="reveal relative mx-auto w-full max-w-md lg:mx-0" use:reveal>
			<img
				src="/media/images/about.webp"
				alt="Eric of Tropic Life in a red Tropic Life hoodie beside an infinity pool in the mountains of Puerto Rico"
				class="w-full rounded-2xl object-cover shadow-2xl"
				width="800"
				height="800"
				loading="lazy"
				decoding="async"
			/>
		</div>

		<div class="reveal mt-10 lg:mt-0" use:reveal>
			<h2 class="lg:text-2xl text-lagoon-500 tracking-normal">About me</h2>
			<p class="mt-6 text-lg leading-relaxed text-ink-800/85">
				As an Air Force veteran and travel content creator, I craft high-impact visuals, edited
				photography and cinematic videos that elevate your brand's presence and drive meaningful
				traffic and growth. Worked with <strong class="text-lagoon-700"> over 40 Airbnbs &amp; hotels </strong> to create captivating
				promotional content.
			</p>
			<p class="mt-4 text-lg leading-relaxed text-ink-800/85">
				I specialize in travel content, Airbnb &amp; hotel UGC, event recaps, and gastronomy
				content.
			</p>
		</div>
	</div>
</section>
