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
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixachupkgs.url = "github:NixAchu/nixachupkgs";
    ## ------------------------------------------------------------- ##
    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    ## ------------------------------------------------------------- ##
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
#############
# Variables #
#######################################################################
  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    nixos-hardware,
    home-manager,
    hosts,
    nixachupkgs,
    ...
  }: let
    username = "gabriel";
    system = "x86_64-linux";
    hostname = "NixAchu";

    applyAttrNames = builtins.mapAttrs (name: f: f name);

    pkgs-settings = {
      inherit system;
      config.allowUnfree = true;
    };
    pkgs = import nixpkgs (pkgs-settings // {
      overlays = [
        (_: _: {
          unstable = import nixpkgs-unstable pkgs-settings;
        })
        nixachupkgs.overlays.default
      ];
    });

    computers = applyAttrNames {
      "${hostname}-Fix" = self: {
        hostname = "${self}";
        modules = [];
      };
      ### --------------------------------------------------------- ### 
      "${hostname}-Lap" = self: {
        hostname = "${self}";
        modules = [
          nixos-hardware.nixosModules.asus-battery
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };
      "${hostname}-Fra" = self: {
        hostname = "${self}";
        modules = [
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };
    };
    ## ------------------------------------------------------------- ##
    default_modules = [
      nixachupkgs.nixosModules.virtualMachines
      hosts.nixosModule {
        networking.stevenBlackHosts = {
          blockFakenews = true;
          blockGambling = true;
          blockPorn = false;
          blockSocial = true;
        };
      }
    ];
##########
# Config #
#######################################################################
  in
  {
    nixosConfigurations = (nixpkgs.lib.genAttrs (builtins.attrNames computers)
    (name: nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit pkgs;
      };
      #### ----------------------------------------------------- ####
      inherit system;
      #### ----------------------------------------------------- ####
      modules = default_modules ++ computers."${name}".modules ++ [
        (import ./computer.nix {
          computer = computers."${name}";
          inherit username home-manager; 
        })
      ];
    }));
  };
#######################################################################
}
