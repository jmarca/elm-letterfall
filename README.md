# Elm letterfall

I call the general update example "letterfall".  I find it is a good
example to learn how to use a language to interop with D3.

In this case, I'm using Elm to generate the alphabet, randomize it,
and send it out to D3.  Big whoop, as that is only a few lines of code
in the original, but that's okay by me, I learned loads doing this.

To run it, do:

```
elm-make src/Letterfall.elm --output=resources/js/letterfall.js
```

Then load up './resources/index.html' in a browser, firefox or chrome
or whatever.
