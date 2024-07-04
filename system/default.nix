{ hostname, users, externalImports }:
{ lib, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    (import ./default {
      inherit hostname users;
    })

    (import ./computer/${hostname} {
      inherit hostname users;
    })

  ] ++ (lib.forEach externalImports (externalImport:
    (import externalImport {
      inherit hostname users;
    })
  ));
#######################################################################
}
