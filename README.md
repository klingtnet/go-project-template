# Go Project Template

[![Github Action Status](https://github.com/klingtnet/go-project-template/workflows/Go/badge.svg)](https://github.com/klingtnet/go-project-template/actions)

This project acts as a template for new Go projects I develop.
Most of my projects follow a certain structure:

- there is a `Makefile` with common targets so everyone can easily build and test the project
	- the applications version and build time is set at compile time through `ldflags`
	- there is a `check` target to lint the code and ensure that it is properly formatted
	- it uses vgo and the new module system

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
$ git clone --depth=1 https://github.com/klingtnet/go-project-template.git my-new-project
```

and adjust the module path in the `go.mod` file.

## Development

- build the project: `make`
- test the project: `make test`
- clean build artifacts and vendor folder: `make clean`
