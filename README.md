# MyWord-Package-Library
Packages are collections of [MyWord](http://ridgeworks.github.io/MyWord/) type and notation definitions that can be used to extend the *lingo* available to authors of MyWord documents. This project contains a selection of such packages, many based on third party JavaScript libraries, that may be of interest depending on the document content. Each package is contained in a directory at the to level of this project. The `metamark` file (suffix `.mmk`) at the to level of the directory must be `@import`ed into the document to make the meta-defintions usable in the document. The directories also contain any other files (`.js` and `.css`) necessary to the package.

In many cases the documentation for any package is contained in `@doc` blocks inside the `.mmk` files. Additional README or other documentation may be present in the package directory.
 
There are no licensing requirements to use these packages but please respect any license conditions imposed by any included third party software. In most cases this entails nothing more than including their license agreements with any source distribution.
 
There will not be any coordinated releases of this project and no attempt to synchronize the packages with any third party software they might use. Users are encouraged to check if more recent versions are available of any third party software used. 