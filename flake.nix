{
###########
# Imports #
#######################################################################
  description = "Pikatsuto dotfiles";
  # ----------------------------------------------------------------- #
  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
  };
  # ----------------------------------------------------------------- #
  inputs = {
    nixpkgs.url = "github:RevoluNix/revolunixpkgs/testing";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
#############
# Variables #
#######################################################################
  outputs = {
    nixos-hardware,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    hostname = "RevoluNixOS";
    pkgs = nixpkgs.revolunixpkgs;

    users = rec {
      primaryUser = "gabriel";
      allUsers = [
        primaryUser
      ];

      configs = {
        home = builtins.listToAttrs
          (nixpkgs.lib.forEach allUsers (username: {
            name = username;
            value = (import ./home {
              inherit username hostname;
              externalImports = [
                nixpkgs.configsImports.revolunixos.base.graphical.home
              ];
            });
          }));

        system = builtins.listToAttrs
          (nixpkgs.lib.forEach allUsers (username: {
            name = username;
            value = {
              isNormalUser = true;
              shell = pkgs.fish;
              extraGroups = [
                "wheel"
              ];
              initialPassword = "admin";
            };
          }));
      };
    };

    applyAttrNames = builtins.mapAttrs (name: f: f name);

    computers = applyAttrNames {
      "${hostname}" = self: {
        hostname = "${self}";
        modules = [
          nixos-hardware.nixosModules.asus-battery
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };
    };
    ## ------------------------------------------------------------- ##
    defaultModules = [
      # nixpkgs.nixosModules.virtualMachines
    ];
##########
# Config #
#######################################################################
  in
  {
    nixosConfigurations = (nixpkgs.lib.genAttrs
    (builtins.attrNames computers)
    (name: nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit pkgs;
      };
      inherit system;

      modules = defaultModules
        ++ nixpkgs.defaultModules
        ++ computers.${name}.modules
        ++ [

          (import ./system {
            inherit hostname users;
            externalImports = [
              nixpkgs.configsImports.revolunixos.base.graphical.system
            ];
          })

          ./hardware/${hostname}.nix

          home-manager.nixosModules.home-manager {home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users = users.configs.home;
          };}
        ];
    }));
  };
#######################################################################
}
