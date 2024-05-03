{ username, computer, home-manager }:
{ config, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    (import ./config {
      inherit computer username;
    })
    ## ------------------------------------------------------------- ##
    ./hardware/${computer.hostname}.nix
    ## ------------------------------------------------------------- ##
    home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username} = (import ./home {
          inherit username;
          hostname = computer.hostname;
        });
      };
    }
  ];
#######################################################################
}

