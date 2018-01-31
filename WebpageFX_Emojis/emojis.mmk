@doc
	#### Package `emojis.mmk`
	
	This simple *emojis* package uses the [WebpageFX emoji] cheat sheet to map emoji names to their corresponding graphics. The type `emoji` maps a text name to an `<img>` element referencing the corresponding `.png` file on the cheat sheet. A default style of `{width:3ex; height:3ex; vertical-align: bottom;}` is applied; use CSS selector `img.my_emoji` to change it.
	
	Example (uses `demo.mmk`):
	demo
		Use any emoji by name by enclosing it in colons.
		For example, :smile: :smiley: :cry: :wink:.
		
		& : .. : <- emoji
	
	This use of `: .. :` is common practice, but may not be the best choice since '`:`' is standard punctuation.

	Note: To render this documentation, define:
	eg
		metadoc :: (doc) => markit('myword', doc.replace(/(\n|\r\n?)(\t|[ ]{4})/g, '\n'))
	and `@import` this package.
	& [WebpageFX emoji] <- link https://www.webpagefx.com/tools/emoji-cheat-sheet/

emoji :: (emoji) => 
	`<img class=my_emoji src="https://www.webpagefx.com/tools/emoji-cheat-sheet/graphics/emojis/${emoji}.png"></img>`

@css img.my_emoji {width:3ex; height:3ex; vertical-align: bottom;}
