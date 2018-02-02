@doc
	####  Package `beautify.mmk`

	[`js-beautify.js`] is a JavaScript library that reformats and reindents JavaScript content, perhaps due to packing.
	The same library also supports CSS and HTML beautifiers. This package defines types `jsraw`, `cssraw`, and `htmlraw`
	for reformatting "raw" JavaScript, CSS, and HTML content respectively. A single notation can combine beautfiy and
	syntax highlighting as shown in the examples below (uses `demo.mmk`):
	
	demo
		&
			.jsraw ..   <- <pre> jsraw
			.cssraw ..  <- <pre> cssraw
			.htmlraw .. <- <pre> htmlraw
			.js ..      <- <pre> js
			
			js  :: (code) => markit('highlight', markit('jsraw', code))
			
		Raw Javascript:
		.jsraw function indentMe() {"no, me!";}

		With syntax colouring (requires package `highlight.mmk`):
		.js function indentMe() {"no, me!";}
		---
		Raw CSS:
		.cssraw body {font-family: 'Helvetica Neue', Helvetica, Arial, serif;font-size: 1em;line-height: 1.5;}
		---
		Raw HTML:
		.htmlraw <html><head><script src='lib/x-markup.js'></script></head><body><div class=x-markup src="SimpleExample.myw"></div></body></html>
	
	Note: To render this documentation, define:
	eg
		metadoc :: (doc) => markit('myword', doc.replace(/(\n|\r\n?)(\t|[ ]{4})/g, '\n'))
	and `@import` this package.
	
	& [`js-beautify.js`] <- link https://github.com/beautify-web/js-beautify
	
@import
	js-beautify-1.7.5/js/lib/beautify.js
	js-beautify-1.7.5/js/lib/beautify-css.js
	js-beautify-1.7.5/js/lib/beautify-html.js

jsraw    :: (content) => js_beautify(content)

cssraw   :: (content) => css_beautify(content)

htmlraw  :: (content) => markit('text', html_beautify(content))
