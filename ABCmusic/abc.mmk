@doc
	####  Package `abc.mmk`

	[`abc`] is an ASCII based music notation and a de facto standard for folk and traditional music. [`abc2svg`] renders `abc` content to `svg` (scalable vector graphics) an XML based vector image format for two dimensional graphics supported by most browsers. 
	
	This package uses `abc2svg` to define the type `abc` for `abc` content. This type can be used to define custom notations or as a file type for @including external `.abc` files. The rendered output is a custom `<myword-abc>` element which contains the original `abc` content as well as the visible graphics.
	
	Example (uses `demo.mmk`)
	demo
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
			
		& .abc .. <- abc
	
	Note: To render this documentation, define:
	eg
		metadoc :: (doc) => markit('myword', doc.replace(/(\n|\r\n?)(\t|[ ]{4})/g, '\n'))
	and `@import` this package.
	&
		[`abc`]     <- link http://abcnotation.com
		[`abc2svg`] <- link http://moinejf.free.fr/js/

@import abc2svg-1.js

abc :: (abcontent) => {
		var svg = []
		var errors = []
		var user = {  // abc2svg API object to collect output and error messages
			errmsg:      (msg) => {errors.push(msg)},
			img_out:     (str) => {svg.push(str)},
			read_file:   (url) => { // sync IO for I:abc-include
				var status = 0;
				if (typeof XMLHttpRequest != 'undefined') {
					var request = new XMLHttpRequest();
					request.open("GET", url, false);   //synchronous IO, requires Worker mode in browsers
					request.setRequestHeader("Accept","text/*,*/*")
					request.onerror = function () {status = 404};
					request.send();
					status = ((status == 0) ? request.status : status );
					if ((status === 200 || status === 0)) {
						return request.responseText
					} else {
						throw new Error(`Reading '${url}' status=${status}`)
					}
				} else {	// try Nodejs file system
					return fs.readFileSync(url, "utf8");
				}
			},
			page_format: true
		}
		try {
			new Abc(user).tosvg("myword-abc", abcontent)
		} catch (e) {
			user.errmsg("abc2svg javascript error: " + e.message)
		}
		return (errors.length > 0)
			? markit('errorString', errors.join('\n'))
			: `<myword-abc><code class=my_abc hidden>${abcontent}</code>${svg.join('')}</myword-abc>`
	}
