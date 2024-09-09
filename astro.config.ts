import mdx from '@astrojs/mdx';
import sitemap from '@astrojs/sitemap';
import { defineConfig } from 'astro/config';

import unocss from 'unocss/astro';
import icons from 'unplugin-icons/vite';
import glsl from 'vite-plugin-glsl';

// https://astro.build/config
export default defineConfig({
	site: 'https://me.dyn.gay',
	integrations: [
		unocss({
			injectReset: true,
		}),
		mdx(),
		sitemap(),
	],
	experimental: {
		contentIntellisense: true,
		contentLayer: true,
	},
	vite: {
		ssr: { noExternal: ['smartypants'] },
		plugins: [icons(), glsl()],
	},
});
