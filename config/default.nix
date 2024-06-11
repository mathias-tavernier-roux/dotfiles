{ computer, username }:
{ config, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    (import ./default {
      inherit computer username;
    })
    (import ./${computer.hostname} {
      inherit username;
    })
  ];
#######################################################################
}
