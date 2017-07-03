.PHONY: clean check-dep

SHELL		:=bash
GOPATH		:=$(PWD)/.go
NAMESPACE	:=github.com/klingtnet/go-project-template
WORKSPACE	:=$(GOPATH)/src/$(NAMESPACE)
GO_SOURCES	:=$(wildcard cmd/example/*.go)
GO_PACKAGES	:=$(dir $(GO_SOURCES))
GO_FLAGS	:=-ldflags="-X $(NAMESPACE)/meta.Version=$(shell git rev-parse HEAD) -X $(NAMESPACE)/meta.BuildTime=$(shell date --iso-8601=seconds --utc)"

all: setup example

example: test $(GO_SOURCES)
	@cd $(WORKSPACE)\
		&& go install $(GO_FLAGS) $(NAMESPACE)/cmd/example
	@cp $(GOPATH)/bin/$@ $(PWD)
	
test: $(GO_PACKAGES)
	@cd $(WORKSPACE)\
		&& go test $(addprefix $(NAMESPACE)/,$<)

fmt: $(GO_SOURCES)
	gofmt -w $<
	goimports -w $<

check: vet lint

vet: $(GO_SOURCES)
	go vet $(addprefix $(NAMESPACE)/,$(GO_PACKAGES))

lint: check-lint $(GO_SOURCES)
	golint $(addprefix $(NAMESPACE)/,$(GO_PACKAGES))

setup: check-dep $(WORKSPACE)
	@cd $(WORKSPACE) && dep ensure

$(GOPATH):
	@mkdir -p $@

$(WORKSPACE): $(GOPATH)
	@mkdir -p $$(dirname $@)
	@ln -s $(PWD) $@

check-dep:
	@hash dep 2>/dev/null\
		|| (echo -e "dep is missing:\ngo get -u github.com/golang/dep/cmd/dep"; false)

check-lint:
	@hash golint 2>/dev/null\
		|| (echo -e "golint is missing:\ngo get -u github.com/golang/lint/golint"; false)

clean:
	@rm -f example
	@rm -rf vendor
