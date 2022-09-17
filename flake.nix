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
              let install = pkgs.writeShellScriptBin "nixin" ''
                if [ $# -ne 1 ]; then
                    echo 'wrong arguments number'
                    echo 'usage: install <profile aka host>'
                    exit -1
                fi
                profile=$1
                [ ! -d "./nixos" ] && git clone gh:devrtc0/nixos.git
                cd nixos
                git pull
                [ ! -f "./hosts/$profile/disks.sh" ] && echo "No profile $profile" && exit -1
                sudo sh ./hosts/$profile/disks.sh
                [ $? -ne 0 ] && echo "Disk preparation failed" && exit -1
                [ "${profile:0:2}" = "vm" ] && substituters='--option substituters http://10.0.2.2:4444/'
                sudo nixos-install --flake .#$profile $substituters
              ''; in
              {
                programs.git = {
                  enable = true;
                  package = pkgs.gitMinimal;
                  config = {
                    init = {
                      defaultBranch = "master";
                    };
                    url = {
                      "https://github.com/" = {
                        insteadOf = [
                          "gh:"
                          "github:"
                        ];
                      };
                    };
                  };
                };
                environment.systemPackages = with pkgs; [
                  install
                ];
              })
          ];
        };
      };
  };
}
