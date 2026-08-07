export interface SocialLink {
	label: string;
	href: string;
}

export interface NavItem {
	label: string;
	/** Fragment id of the section on the home page. */
	id: string;
}

export interface Service {
	title: string;
	description: string;
}

export interface Reel {
	/** Basename of the encoded files in static/media/videos (`<src>.mp4` + `<src>.webp` poster). */
	src: string;
	title: string;
}

export interface SiteConfig {
	name: string;
	tagline: string;
	domain: string;
	description: string;
	/** TODO: replace the three placeholders below with the real booking address and profiles. */
	email: string;
	socials: SocialLink[];
	nav: NavItem[];
	services: Service[];
	reels: Reel[];
}

export const site: SiteConfig = {
	name: 'Tropic Life',
	tagline: 'Tourism / Experience / Lifestyle',
	domain: 'https://tropiclifepr.com',
	description:
		'Air Force veteran and travel content creator in Puerto Rico. Cinematic video and edited photography for Airbnbs, hotels, events and gastronomy.',
	email: 'eric@tropiclifepr.com',
	socials: [
		{ label: 'Facebook', href: 'https://facebook.com/tropiclifepr' },
		{ label: 'Instagram', href: 'https://instagram.com/tropiclifepr' }
	],
	nav: [
		{ label: 'About', id: 'about' },
		{ label: 'Services', id: 'services' },
		{ label: 'Work', id: 'work' },
		{ label: 'Contact', id: 'contact' }
	],
	services: [
		{
			title: 'Lifestyle video',
			description:
				'Cinematic lifestyle films of your property or business that show guests what the stay actually feels like.'
		},
		{
			title: 'Real-estate video',
			description:
				'Captivating, dynamic walkthroughs and aerials that make a listing impossible to scroll past.'
		},
		{
			title: 'Edited photography',
			description:
				'High-impact stills, colour graded and retouched, ready for your listing, site and press kit.'
		},
		{
			title: 'Social promotion',
			description:
				'Promotion across social platforms so the content reaches the travellers already looking for you.'
		}
	],
	reels: [
		{ src: 'video-1-allure', title: 'Allure' },
		{ src: 'video-2-fiji', title: 'Fiji' },
		{ src: 'video-3-hotel-vista-alegre', title: 'Hotel Vista Alegre' },
		{ src: 'video-3-prcocktail', title: 'PR Cocktail' }
	]
};
