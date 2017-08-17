# Go Project Template

[![Build Status](https://travis-ci.org/klingtnet/go-project-template.svg?branch=master)](https://travis-ci.org/klingtnet/go-project-template)

This project acts as a template for new Go projects I develop.
Most of my projects follow a certain structure:

- there is a `Makefile` with common targets so everyone can easily build and test the project
	- the applications version and build time is set at compile time through `ldflags`
	- there is a `lint`ing target and one to `fmt` the code
	- a local `GOPATH` is setup
- [github.com/golang/dep](https://github.com/golang/dep) is used to vendor depdencies
	- dependencies are automatically installed through `make`

## Run

```bash
$ git clone https://github.com/klingtnet/go-project-template.git
$ cd go-project-template
$ make
$ ./example
INFO[0000] Example@0.0.1-2-g9c29ba5 build time: 2017-07-03T12:31:38+00:00
```

## Use

How to use this as a start for a new project:

```sh
$ git clone --depth=1 git@github.com:klingtnet/go-project-template.git my-new-project
# edit the Makefile's `NAMESPACE:=github.com/klingtnet/go-project-template` variable
# done!
```

Dependencies can be added through the `dep` wrapper:

```sh
$ make ARGS='ensure github.com/foo/bar' dep
```

## Development

- build the project: `make`
- test the project: `make test`
- clean build artifacts and vendor folder: `make clean`
