import type { Action } from 'svelte/action';

const REVEALED_CLASS = 'is-revealed';
const ROOT_MARGIN = '0px 0px -10% 0px';
const THRESHOLD = 0.15;

/**
 * Adds `is-revealed` the first time an element scrolls into view, so CSS can fade it in.
 * Reveals immediately (no animation) when the visitor prefers reduced motion.
 */
export const reveal: Action<HTMLElement> = (node) => {
	const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;

	if (prefersReducedMotion || typeof IntersectionObserver === 'undefined') {
		node.classList.add(REVEALED_CLASS);
		return;
	}

	const observer = new IntersectionObserver(
		(entries) => {
			for (const entry of entries) {
				if (!entry.isIntersecting) continue;
				entry.target.classList.add(REVEALED_CLASS);
				observer.unobserve(entry.target);
			}
		},
		{ rootMargin: ROOT_MARGIN, threshold: THRESHOLD }
	);

	observer.observe(node);

	return {
		destroy() {
			observer.disconnect();
		}
	};
};
