#!/usr/bin/env sh

curl 'https://codeload.github.com/NixOS/nixpkgs/tar.gz/refs/heads/nixos-unstable' --output /tmp/nixpkgs.tar.gz

rm -rf nixpkgs
mkdir nixpkgs
tar --strip-components=1 -C nixpkgs -xf /tmp/nixpkgs.tar.gz
