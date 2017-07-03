package main

import (
	"fmt"

	"github.com/klingtnet/go-project-template/meta"
)

func main() {
	fmt.Printf("Example@%s\nBuild time: %s", meta.Version, meta.BuildTime)
}
