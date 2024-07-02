{ username, hostname, home-manager, configsImports }:
{ config, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    (import ./config {
      inherit hostname username;
      externalImport =
        configsImports.revolunixos.base.graphical.system;
    })
    ## ------------------------------------------------------------- ##
    ./hardware/${hostname}.nix
    ## ------------------------------------------------------------- ##
    home-manager.nixosModules.home-manager {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username} = (import ./home {
          inherit username;
          hostname = hostname;
          externalImport =
            configsImports.revolunixos.base.graphical.home;
        });
      };
    }
  ];
#######################################################################
}

