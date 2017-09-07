.PHONY: clean test fmt vet lint

SHELL		:=bash
GOPATH		:=$(PWD)/.go
NAMESPACE	:=github.com/klingtnet/go-project-template
WORKSPACE	:=$(GOPATH)/src/$(NAMESPACE)
GO_SOURCES	:=$(wildcard cmd/example/*.go)
GO_PACKAGES	:=$(dir $(GO_SOURCES))
VERSION	:=$(shell git describe --tags --always)
GO_FLAGS	:=-ldflags="-X $(NAMESPACE)/meta.Version=$(VERSION) -X $(NAMESPACE)/meta.BuildTime=$(shell date --iso-8601=seconds --utc)"
DEP_ARGS	:=-v

all: example

example: setup.lock test $(GO_SOURCES)
	@touch meta/meta.go
	@cd $(WORKSPACE)\
		&& go install $(GO_FLAGS) $(NAMESPACE)/cmd/example
	@cp $(GOPATH)/bin/$@ $(PWD)
	
test: setup.lock
	@cd $(WORKSPACE)\
		&& go test $(addprefix $(NAMESPACE)/,$(GO_PACKAGES))

setup.lock: $(WORKSPACE) vendor
	@echo $(VERSION) > setup.lock

fmt: $(GO_SOURCES)
	gofmt -w $<
	goimports -w $<

check: vet lint

vet: $(GO_SOURCES)
	go vet $(addprefix $(NAMESPACE)/,$(GO_PACKAGES))

lint: check-lint $(GO_SOURCES)
	golint $(addprefix $(NAMESPACE)/,$(GO_PACKAGES))

dep: $(WORKSPACE)
	@cd $(WORKSPACE) && dep $(ARGS)

vendor: Gopkg.toml Gopkg.lock
	@cd $(WORKSPACE) && dep ensure $(DEP_ARGS)

$(GOPATH):
	@mkdir -p $@

$(WORKSPACE): $(GOPATH)
	@mkdir -p $(dir $@)
	@ln -s $(PWD) $@

clean:
	@rm -f example
	@rm -rf vendor .go setup.lock
