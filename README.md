# Go Project Template

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
INFO[0000] Example@b9db4c8ca30e8e6301c80fc429c6829fe48164b1 build time: 2017-07-03T11:57:09+00:00
```

## Development

- build the project: `make`
- test the project: `make test`
- clean build artifacts and vendor folder: `make clean`
