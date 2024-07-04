{ hostname, username, externalImports }:
{ lib, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    (import ./default {
      inherit hostname username;
    })

    (import ./computer/${hostname} {
      inherit hostname username;
    })

    (import ./user/${username} {
      inherit hostname username;
    })

  ] ++ (lib.forEach externalImports (externalImport:
    (import externalImport {
      inherit hostname username;
    })
  ));
#######################################################################
}
