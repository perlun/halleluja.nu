# README

This is the source code for the halleluja.nu web site.

The site is built using [sitegen](https://github.com/perlun/sitegen), a
tailor-made Static Site Generator developed by Per Lundberg. It is similar to
Jekyll, Hugo and others, but writing a site generator of our own had some
advantages in making it easier to customize small, semantic details which are
important for the development of this web site (particularly in moving towards
proper multi-language support).

## Installing development prerequisites

- NET Core SDK 3.1: https://dotnet.microsoft.com/download/dotnet-core/3.1
- `apt-get install make`, to use our [Makefile](Makefile) for building sitegen
  and the site itself.

## Rebuild sitegen and site

```shell
$ make
```

## Regenerate site

```shell
$ make site
```

## Run local web server to test it

```shell
$ make serve
```

## [HTML template](https://github.com/h5bp/html5boilerplate.com) license

Copyright (c) HTML5 Boilerplate

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
