<script lang="ts">
	import SocialIcon from './SocialIcon.svelte';
	import { site } from '$lib/site';

	const year = new Date().getFullYear();
</script>

<footer class="border-t border-white/10 bg-ink-950 py-10">
	<div
		class="mx-auto flex max-w-6xl flex-col items-center gap-6 px-5 text-center sm:px-8 md:flex-row md:justify-between md:text-left"
	>
		<p class="text-sm text-sand-300/70">
			&copy; {year}
			{site.name}. All rights reserved.
		</p>

		<ul class="flex items-center gap-4">
			{#each site.socials as social (social.label)}
				<li>
					<a
						href={social.href}
						target="_blank"
						rel="noopener noreferrer"
						aria-label={social.label}
						class="inline-flex h-10 w-10 items-center justify-center rounded-full border border-white/15 text-sand-100 transition-colors hover:border-brand-500 hover:text-brand-500"
					>
						<SocialIcon name={social.label} class="h-4 w-4" />
					</a>
				</li>
			{/each}
		</ul>

		<a
			href="/terms"
			class="text-sm text-sand-300/70 underline underline-offset-4 transition-colors hover:text-lagoon-300"
		>
			Terms &amp; Conditions
		</a>
	</div>
</footer>
