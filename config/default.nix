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
    ./${computer.hostname}
  ];
#######################################################################
}
