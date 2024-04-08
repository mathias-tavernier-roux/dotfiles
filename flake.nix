{
###########
# Imports #
#######################################################################
  description = "Pikatsuto dotfiles";
  # ----------------------------------------------------------------- #
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";
    ## ------------------------------------------------------------- ##
    hosts.url = "github:StevenBlack/hosts";
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    ## ------------------------------------------------------------- ##
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
#############
# Variables #
#######################################################################
  outputs = {
    self,
    nixpkgs,
    nixos-hardware,
    home-manager,
    hosts,
    ...
  } @inputs: let
    username = "gabriel";
    system = "x86_64-linux";
    hostname = "NixAchu";

    applyAttrNames = builtins.mapAttrs (name: f: f name);

    computers = applyAttrNames {
      "${hostname}-Fix" = self: {
        hostname = "${self}";
        vms = [
          {
            name = "win11";
            os = "win11";
            ssdEmulation = true;
            isoName = "win11.iso";
            cores = 4;
            threads = 2;
            memory = 12;
            diskSize = 512;
            diskPath = "/var/lib/libvirt/images";
            restartDm = false;
            videoVirtio = false;
            blacklistPcie = "";
            pcies = [
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "0";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
              blacklistPcie = false;
            }
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "1";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
              blacklistPcie = false;
            }
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "2";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
              blacklistPcie = false;
            }
            {
              pcie = {
                vmBus = "09";
                bus = "01";
                slot = "00";
                function = "3";
              };
              driver = ''nouveau'';
              blacklistDriver = true;
              blacklistPcie = false;
            }
            ];
          }
        ];
        modules = [];
      };
      ### --------------------------------------------------------- ### 
      "${hostname}-Lap" = self: {
        hostname = "${self}";
        vms =  [
          {
            name = "win11";
            os = "win11";
            ssdEmulation = true;
            isoName = "win11.iso";
            cores = 2;
            threads = 2;
            memory = 8;
            diskSize = 128;
            diskPath = "/home/${username}/VM/Disk";
            restartDm = false;
            videoVirtio = true;
            blacklistPcie = "";
            pcies = false;
          }
        ];
        modules = [
          nixos-hardware.nixosModules.asus-battery
            nixos-hardware.nixosModules.common-cpu-intel
            nixos-hardware.nixosModules.common-pc
            nixos-hardware.nixosModules.common-pc-ssd
        ];
      };
      "${hostname}-Fra" = self: {
        hostname = "${hostname}-Lap";
        vms = [
          {
            name = "win11";
            os = "win11";
            ssdEmulation = true;
            isoName = "win11.iso";
            cores = 5;
            threads = 2;
            memory = 20;
            diskSize = 128;
            diskPath = "/home/${username}/VM/Disk";
            restartDm = false;
            videoVirtio = false;
            blacklistPcie = "1002:7480,1002:ab30";
            pcies = [
            {
              pcie = {
                vmBus = "09";
                bus = "03";
                slot = "00";
                function = "0";
              };
              driver = "amdgpu";
              blacklistDriver = false;
              blacklistPcie = true;
            }
            {
              pcie = {
                vmBus = "09";
                bus = "03";
                slot = "00";
                function = "1";
              };
              driver = "amdgpu";
              blacklistDriver = false;
              blacklistPcie = true;
            }
            ];
          }
        ];
        modules = [
          nixos-hardware.nixosModules.common-cpu-intel
          nixos-hardware.nixosModules.common-pc
          nixos-hardware.nixosModules.common-pc-ssd
        ];
      };
    };
    ## ------------------------------------------------------------- ##
    default_modules = [
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
