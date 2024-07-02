{ hostname, username, externalImport }:
{ config, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    (import ./default {
      inherit hostname username;
    })
    (import ./${hostname} {
      inherit username;
    })
    (import externalImport {
      inherit hostname username;
    })
  ];
#######################################################################
}
