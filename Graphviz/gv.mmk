@doc
	####  Package `gv.mmk`

	[`Graphviz`] uses a simple text language called `dot` to describe diagrams of abstract graphs and networks. [`viz.js`] is a JavaScript library which translates `dot` to `svg` (scalable vector graphics) an XML based vector image format for two dimensional graphics supported by most browsers.
	
	This package  uses the "lite" version of `viz.js` to define the type `gv` whose content is `dot`. This type can be used to define custom notations or as a file type for @including external `.gv` files.
	
	Examples (uses `demo.mmk`):
	demo
		A simple graph:
		.gv
			digraph G { A -> B -> C; A -> C; }
		---
		A graph of structures:
		.gv
			digraph structs {
			node [shape=record];
			struct1 [shape=record,label="<f0> left|<f1> middle|<f2> right"];
			struct2 [shape=record,label="<f0> one|<f1> two"];
			struct3 [shape=record,label="hello\nworld |{ b |{c|<here> d|e}| f}| g | h"];
			struct1:f1 -> struct2:f0;
			struct1:f2 -> struct3:here;
			}

		& .gv .. <- gv
	Note: To render this documentation, define:
	eg
		metadoc :: (doc) => markit('myword', doc.replace(/(\n|\r\n?)(\t|[ ]{4})/g, '\n'))
	and `@import` this package.

	&
		[`Graphviz`] <- link http://www.graphviz.org
		[`viz.js`]   <- link https://github.com/mdaines/viz.js

@import viz-lite.js
gv  :: (dotgraph) => Viz(dotgraph)
