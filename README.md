# MyWord-Package-Library
Packages are collections of [MyWord](http://ridgeworks.github.io/MyWord/) type and notation definitions that can be used to extend the *lingo* available to authors of MyWord documents. If you are unfamiliar with MyWord, an extendable, light weight markup language, please read the MyWord documentation on the [project webpage](http://ridgeworks.github.io/MyWord/).
 
This project contains a selection of MyWord packages, many based on third party JavaScript libraries, that may be of interest depending on the document content. The top level directory (seen above in Github) shows all the packages in this library. The `metamark` file (suffix `.mmk`) at the top level of each package directory must be `@import`ed into the document to make the meta-defintions usable in the document. The directories may also contain other files (`.js` and `.css`) automatically `@import`ed by the main `.mmk` package file.

In many cases the documentation for any package is contained in `@doc` blocks inside the `.mmk` files. `@doc` blocks can be read as raw source, e.g., in the Github viewer, or can be usually be rendered by defining a `metadoc` transform when `@import`ing the package; consult the `.mmk` package file for details when this applies. Additional README or other documentation may also be present in the package directory. 

Unfortunately, there's no approved way to download individual packages from this project. If the entire project is downloaded, it is recommended that any package directories of interest be moved to the local MyWord `pkg/` directory, if one exists. 

There are no licensing requirements to use these packages but please respect any license conditions imposed by any included third party software. In most cases this entails nothing more than including their license agreements with any source distribution.
 
There will not be any coordinated releases of this project and no attempt to synchronize the packages with any third party software they might use. Users are encouraged to check if more recent versions are available of any third party software used.

Suugestions and contributions to this library are encouraged.