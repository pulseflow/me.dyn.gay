export type IconType = typeof import('~icons/*').default;

export interface SocialLink {
	me?: string;
	text: string;
	icon: IconType;
	href: string;
	platform: string;
	footerOnly?: boolean;
}

export interface Project {
	name: string;
	description: string;
	logo?: IconType;
	tag?: string;
	descriptionLong?: string;
	hasPage?: boolean;
}

export interface Config {
	name: string;
	title: string;
	description: string;
	projects: Project[];
	image: {
		src: string;
		alt: string;
	};
	socials: SocialLink[];
}

export const config: Config = {
	name: 'Pauline',
	title: 'Pauline',
	description: 'somewhere in spacetime',
	image: {
		src: '/media/pauline.svg',
		alt: 'me',
	},
	socials: [],
	projects: [],
};

export default config;
