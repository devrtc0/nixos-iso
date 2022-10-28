#!/usr/bin/env sh

# nix flake update

nix build .#nixosConfigurations.nixosIso.config.system.build.isoImage --extra-experimental-features nix-command --extra-experimental-features flakes
