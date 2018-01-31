@doc
	#### Package `mermaid.mmk`
	
	[`mermaid`] is a javaScript library that supports the generation of diagrams and flowcharts from text, i.e., a light weight markup for graphics. Its architecture precludes running it in a Web Worker, so the primary job of this package is to wrap the `mermaid` source text in a custom element (`my-mermaid`) and provide lifecycle methos for the element which call the `mermaid` API from the main thread to render the graphics.
	
	The `mermaid` library must be loaded by the main webpage either by a staic `<script>` element in the host HTML of via a `@require` notation shown in the examples below (uses `demo.mmk`).
	demo
		This would load the necessary script (path adjustment required):
		eg
			@require mermaid-7.0.0_dist/dist/mermaidAPI.min.js
			
		.mmd
			graph TD;
				A-->B;
				A-->C;
				B-->D;
				C-->D;
		---
		.mmd
			gantt
				title A Gantt Diagram

				section Section
				A task           :a1, 2014-01-01, 30d
				Another task     :after a1  , 20d
				section Another
				Task in sec      :2014-01-12  , 12d
				anther task      : 24d
		&
			.mmd .. <- mmd
			@require .. <- require
			require :: (urllist) => urllist.trim().split(/\s+/)
									.map((url) => `<script src='${url.trim()}'></script>`)
									.join('')

	Note: To render this documentation, define:
	eg
		metadoc :: (doc) => markit('myword', doc.replace(/(\n|\r\n?)(\t|[ ]{4})/g, '\n'))
	and `@import` this package.
	& [`mermaid`] <- link https://github.com/knsv/mermaid

@import  mermaid-7.0.0_dist/dist/mermaid.css
mmd  :: (content) => `<my-mermaid style='visibility:hidden'>${markit('text', content)}</my-mermaid>`

@javascript
	// <my-mermaid> table of contents
	( () => {

		class MyMermaid extends HTMLElement {
			constructor() {
				super();
			} // constructor()

			connectedCallback() {
				var container = this
				renderMermaid()

				function renderMermaid() {
					// may need to wait until 'mermaidAPI' is available.
					if (typeof mermaidAPI !== 'undefined') {
						//console.log('mermaidAPI ready.')
						if (!container.querySelector('svg'))  // not already rendered?
							mermaidAPI.render('mermaid' + new Date().getTime(), container.textContent, insertSvg)
					} else {
						//console.log('Waiting for mermaidAPI.')
						setTimeout(renderMermaid,250)
					}
				} // renderMermaid()

				function insertSvg(svgCode) {
					container.innerHTML = svgCode
					container.style.visibility = 'visible'
					container.querySelector('svg').style.height = 'inherit'
				} // insertSvg(svgCode)

			} // connectedCallback()
		} // MyMermaid

		if (!customElements.get('my-mermaid'))
		customElements.define('my-mermaid', MyMermaid)

	})()
