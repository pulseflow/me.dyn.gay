export function resolvePath(path: string): string {
	const p = path.startsWith('/') ? path.substring(1) : path;
	return import.meta.env.BASE_URL + p;
}

export function qs<T extends HTMLElement>(selectors: string): T {
	return document.querySelector<T>(selectors)!;
}

export function qsAll<T extends HTMLElement>(selectors: string): NodeListOf<T> {
	return document.querySelectorAll<T>(selectors);
}
