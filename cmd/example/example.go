package main

import (
	log "github.com/sirupsen/logrus"

	"github.com/klingtnet/go-project-template/meta"
)

func main() {
	log.Infof("Example@%s build time: %s", meta.Version, meta.BuildTime)
}
