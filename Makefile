GO_SOURCES	:=$(shell vgo list -f '{{ range $$element := .GoFiles }}{{ $$.Dir }}/{{ $$element }}{{ "\n" }}{{ end }}' ./...)

SYSTEM:=$(shell uname)
ifeq ($(SYSTEM), Darwin)
BUILD_DATE	:=$(shell date -u +"%Y-%m-%dT%H:%M:%SZ")
else
BUILD_DATE	:=$(shell date --iso-8601=seconds --utc)
endif

VERSION		:=$(shell git describe --tags --always)
META_PACKAGE:=$(shell vgo list -f '{{ .ImportPath }}' ./meta)
GO_FLAGS	:=-ldflags="-X $(META_PACKAGE_IMPORT_PATH).Version=$(VERSION) -X $(META_PACKAGE_IMPORT_PATH).BuildTime=$(BUILD_DATE)"

all: example

example: test $(GO_SOURCES)
	@touch meta/meta.go
	@vgo build $(GO_FLAGS) ./cmd/example
	
test: fmt check $(GO_SOURCES)
	@vgo test ./...

fmt: $(GO_SOURCES)
ifneq ($(shell gofmt -d -l .),)
	@echo "Please run 'gofmt -w .'"
	@gofmt -d -l . && exit 1
endif

check: vet lint

vet: $(GO_SOURCES)
	@vgo tool vet .

lint: $(GO_SOURCES)
	@golint -set_exit_status=1  ./...

clean:
	@rm -f example
