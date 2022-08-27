#!/usr/bin/env sh

nix build .#nixosConfigurations.nixosIso.config.system.build.isoImage
