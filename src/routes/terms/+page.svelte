<script lang="ts">
	import { site } from '$lib/site';

	const title = `Terms & Conditions — ${site.name}`;
	const lastUpdated = 'August 2026';
</script>

<svelte:head>
	<title>{title}</title>
	<meta name="description" content="Terms and conditions for {site.name} content services." />
	<meta name="robots" content="noindex" />
</svelte:head>

<section class="bg-sand-50 pt-nav text-ink-900">
	<div class="mx-auto max-w-3xl px-5 py-16 sm:px-8 sm:py-24">
		<h1 class="text-4xl font-black tracking-tight sm:text-5xl">Terms &amp; Conditions</h1>
		<p class="mt-3 text-sm text-ink-800/60">Last updated: {lastUpdated}</p>

		<div class="prose prose-lg mt-10 max-w-none prose-headings:font-bold prose-headings:tracking-tight">
			<p class="rounded-xl border border-brand-600/30 bg-brand-50 p-4 text-base">
				<strong>Draft.</strong> These terms are a starting point and have not been reviewed by a lawyer.
				Have them checked against Puerto Rico law before relying on them.
			</p>

			<h2>1. Services</h2>
			<p>
				{site.name} provides photography and video content services, including lifestyle and
				real-estate video, edited photography, and promotion on social media platforms. The specific
				deliverables, locations and dates for any engagement are those agreed in writing between
				{site.name} and the client before the shoot.
			</p>

			<h2>2. Booking and payment</h2>
			<p>
				A booking is confirmed only once the agreed deposit has been received. The remaining balance
				is due on delivery of the final files unless agreed otherwise in writing. Deposits secure the
				shoot date and are non-refundable where the client cancels, except as set out below.
			</p>

			<h2>3. Cancellation and rescheduling</h2>
			<p>
				Clients may reschedule at no cost with at least 48 hours' notice, subject to availability.
				Shoots cancelled with less than 48 hours' notice may be charged in full. Where weather,
				travel conditions or other circumstances outside either party's control make a shoot unsafe
				or impractical, it will be rescheduled at no extra cost.
			</p>

			<h2>4. Deliverables</h2>
			<p>
				Delivery timelines are agreed per project and typically run from one to three weeks after the
				shoot. Final files are delivered digitally in web-ready formats. Editing style, colour
				grading and clip selection are the creative judgement of {site.name}; one round of minor
				revisions is included unless agreed otherwise.
			</p>

			<h2>5. Usage rights and ownership</h2>
			<p>
				{site.name} retains copyright in all content produced. Clients receive a perpetual,
				non-exclusive licence to use the delivered content to promote their own property, business or
				event, including on their website, listings and social media. Resale, sublicensing or
				redistribution of the content to third parties requires prior written permission.
			</p>
			<p>
				{site.name} may display delivered content in its own portfolio, on this site and on social
				media, unless the client requests otherwise in writing before the shoot.
			</p>

			<h2>6. Client responsibilities</h2>
			<p>
				The client is responsible for securing access to the property or venue, any permits required
				for filming, and any consent needed from people appearing on camera. The client confirms it
				has the authority to authorise filming at the location provided.
			</p>

			<h2>7. Drone and aerial work</h2>
			<p>
				Aerial footage is captured in line with applicable aviation regulations and airspace
				restrictions. Where a location falls in restricted airspace or conditions are unsafe, aerial
				coverage may be reduced or dropped without affecting the rest of the engagement.
			</p>

			<h2>8. Liability</h2>
			<p>
				{site.name}'s total liability in connection with any engagement is limited to the fees paid
				for that engagement. {site.name} is not liable for indirect or consequential losses,
				including lost bookings or lost revenue. In the event of equipment failure, illness or other
				circumstances preventing delivery, the client will be offered a reshoot or a refund of fees
				paid.
			</p>

			<h2>9. Changes to these terms</h2>
			<p>
				These terms may be updated from time to time. The version in force is the one published on
				this page at the date of booking.
			</p>

			<h2>10. Contact</h2>
			<p>
				Questions about these terms can be sent to
				<a href="mailto:{site.email}">{site.email}</a>.
			</p>
		</div>

		<a
			href="/"
			class="mt-12 inline-flex items-center gap-2 text-sm font-semibold text-brand-600 underline underline-offset-4"
		>
			&larr; Back to home
		</a>
	</div>
</section>
