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
			<p
				class="absolute -right-3 -bottom-6 rounded-xl bg-brand-600 px-5 py-4 text-center text-white shadow-xl sm:-right-6"
			>
				<span class="block text-3xl font-black leading-none">40+</span>
				<span class="mt-1 block text-[0.65rem] font-semibold tracking-[0.2em] uppercase">
					Airbnbs &amp; hotels
				</span>
			</p>
		</div>

		<div class="reveal mt-10 lg:mt-0" use:reveal>
			<p class="text-xs font-semibold tracking-[0.3em] text-lagoon-700 uppercase">About me</p>
			<h2 class="mt-4 text-4xl font-black tracking-tight sm:text-5xl">
				Visuals that make people book.
			</h2>
			<p class="mt-6 text-lg leading-relaxed text-ink-800/85">
				As an Air Force veteran and travel content creator, I craft high-impact visuals, edited
				photography and cinematic videos that elevate your brand's presence and drive meaningful
				traffic and growth. Worked with over 40 Airbnbs &amp; hotels to create captivating
				promotional content.
			</p>
			<p class="mt-4 text-lg leading-relaxed text-ink-800/85">
				I specialize in travel content, Airbnb &amp; hotel UGC, event recaps, and gastronomy
				content.
			</p>
		</div>
	</div>
</section>
