{ hostname, username, externalImport }:
{ config, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    (import ./default {
      username = username;
    })
    ./${hostname}
    (import externalImport {
      inherit hostname username;
    })
  ];
#######################################################################
}
