# README

This is the source code for the halleluja.nu web site.

The site is built using the [EJS](https://ejs.co) (Embedded JavaScript) templating system.

## Installing development prerequisites

```shell
$ npm install
$ sudo apt-get install busybox entr
```

## Regenerate site

```shell
$ make
```

## Automatically regenerate site every time a source file is modified

```shell
$ make autobuild
```

## Run local web server to test it

```shell
$ make serve
```
