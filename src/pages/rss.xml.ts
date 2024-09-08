import rss from '@astrojs/rss';
import { getCollection } from 'astro:content';
import type { APIRoute } from 'astro';

function sortPosts(a: { data: { publishDate: Date } }, b: { data: { publishDate: Date } }) {
	return Number(b.data.publishDate) - Number(a.data.publishDate);
}

function formatDate(date: Date) {
	date.setUTCHours(0);
	return date;
}

export const GET: APIRoute = async (context) => {
	const unsortedPosts = [...(await getCollection('blog'))];
	const posts = unsortedPosts.sort((a, b) => sortPosts(a, b));

	return rss({
		title: 'paulies thoughts',
		description: 'some random blog stuff',
		site: (context.site as URL).href,
		items: posts.map(post => ({
			title: post.data.title,
			description: post.data.description,
			pubDate: formatDate(post.data.publishDate),
			link: `/blog/${post.slug}/`,
		})),
	});
};
