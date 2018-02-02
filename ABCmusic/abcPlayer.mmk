@doc
	####  Package `abcPlayer.mmk`

	This package adds a music player for content rendered by `abc.mmk`, i.e., `<myword-abc>` custom elements. Clicking
	on the rendered music will start and stop the player. The player requires the scripts `abc2svg-1.js` and `play-1.js`
	to be loaded on the main page. 
	
	As of Jan. 2018, this feature does not work on Safari (and possibly others).
	
	Example:
	demo
		&
			.abc .. <- abc
			@require .. <- require
			require :: (urllist) => urllist.trim().split(/\s+/)
								.map((url) => `<script src='${url.trim()}'></script>`)
								.join('')
			
		This would load the necessary scripts (path adjustment required):
		eg
			@require abc2svg-1.js play-1.js
		
		Click on the music to start/stop playing:
		.abc
			X:1
			T:Speed the Plough
			M:4/4
			C:Trad.
			K:G
			|:GABc dedB|dedB dedB|c2ec B2dB|c2A2 A2BA|
			GABc dedB|dedB dedB|c2ec B2dB|A2F2 G4:|
			|:g2gf gdBd|g2f2 e2d2|c2ec B2dB|c2A2 A2df|
			g2gf g2Bd|g2f2 e2d2|c2ec B2dB|A2F2 G4:|
		
	Note: To render this documentation, define:
	eg
		metadoc :: (doc) => markit('myword', doc.replace(/(\n|\r\n?)(\t|[ ]{4})/g, '\n'))
	and `@import` this package.


@javascript
	// <myword-abc> abc music element
	( () => {

		class MyWordAbcPlayer extends HTMLElement {
			constructor() {
				super();
			} // constructor()

			connectedCallback() {
				//console.log('Connecting MyWordAbcPlayer.')
				this._play = false
				this._playEvents = null
				this._abcplay = null
				this._user = {  // abc2svg API object to collect output and error messages
					myAbcPlayer:   this,
					errmsg:        (msg) => {console.error("MyWordAbcPlayer error:" + msg)},
					img_out:       (str) => true,
					read_file:     (url) => '',
					get_abcmodel:  function(tsfirst, voice_tb, music_types, info) {  // can't use '=>' here
									   if (this.myAbcPlayer._play) this.myAbcPlayer._abcplay.add(tsfirst, voice_tb)
								   }
				}
				this.addEventListener('click', clickHandler)
				this._clickHandler = clickHandler
				
				function clickHandler() {
					//console.log('abcplay='+this._play) //+ev.toString())
					if (typeof AbcPlay !== "undefined") {
						if (!this._abcplay)
							this._abcplay = new AbcPlay({ endplay: function() {this._play = false} })
						if (this._play) {
							this._abcplay.stop()
							this._play = false
						} else {
							this._play = true
							if (!this._playEvents) {
								var abc = new Abc(this._user);
								this._abcplay.clear();
								abc.tosvg("play", "%%play");
								try {
									abc.tosvg("MyWordAbcPlayer", this.querySelector('code.my_abc').innerText)
								} catch (e) {
									console.error(e.message + "\nabc2svg tosvg bug - stack:\n" + e.stack);
									this._play = false
									this._playEvents = null;
									return
								}
								this._playEvents = this._abcplay.clear()
							}
							this._abcplay.play(0, 1e5, this._playEvents)
						}
					}
				} // clickHandler()
			} // connectedCallback()
			
			disconnectedCallback() {
				//console.log('Disconnecting MyWordAbcPlayer.')
				this.removeEventListener('click', this._clickHandler)
				if (this._abcplay)
					this._abcplay.stop()
			} // disconnectedCallback()
			
		} // MyWordAbcPlayer

		if (!customElements.get('myword-abc'))
		customElements.define('myword-abc', MyWordAbcPlayer)

	})()
