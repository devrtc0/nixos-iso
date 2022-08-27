#!/usr/bin/env sh

EXEC_DIR=$(dirname $(readlink -f $0))

NIXPKGS_DIR="$EXEC_DIR/nixpkgs"
[ ! -d "$NIXPKGS_DIR" ] && echo "$NIXPKGS_DIR dosn't exist" && exit -1

NIX_PATH=nixpkgs=$NIXPKGS_DIR nix-shell -p nixos-generators --run "nixos-generate --format iso --configuration $EXEC_DIR/nixos-iso.nix -o $EXEC_DIR/result"
