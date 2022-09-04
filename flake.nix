{
  description = "NixOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.05";
  };
  outputs = { self, nixpkgs }: {
    nixosConfigurations =
      let
        system = "x86_64-linux";
      in
      {
        nixosIso = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            "${nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
            ({ pkgs, ... }:
              let prepare = pkgs.writeShellScriptBin "prepare" ''
                git clone https://github.com/devrtc0/nixos.git
                cd nixos
              ''; in
              {
                environment.systemPackages = with pkgs; [
                  gitMinimal
                  prepare
                ];
              })
          ];
        };
      };
  };
}
