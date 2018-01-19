package main

import (
	"github.com/requilence/integram"
	"github.com/integram-org/bitbucket"
	"github.com/kelseyhightower/envconfig"
)

func main(){
	var cfg bitbucket.Config
	envconfig.MustProcess("BITBUCKET", &cfg)

	integram.Register(
		cfg,
		cfg.BotConfig.Token,
	)

	integram.Run()
}