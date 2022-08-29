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
            ({ pkgs, ... }: {
              environment.systemPackages = with pkgs; [
                git
              ];
            })
          ];
        };
      };
  };
}
