# Go Project Template

This project acts as a template for new Go projects I develop.
Most of my projects follow a certain structure:

- there is a `Makefile` with common targets so everyone can easily build and test the project
	- the applications version and build time is set at compile time through `ldflags`
	- there is a `lint`ing target and one to `fmt` the code
	- a local `GOPATH` is setup
- [github.com/golang/dep](https://github.com/golang/dep) is used to vendor depdencies
	- dependencies are automatically installed through `make`

## Development

- build the project: `make`
- test the project: `make test`
- clean build artifacts and vendor folder: `make clean`
