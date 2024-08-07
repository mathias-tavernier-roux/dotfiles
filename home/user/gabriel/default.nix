{ username, ... }:
{ pkgs, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    ## Config ------------------------------------------------------ ##
    ./fish
    ./extraFiles
    ./git
    ./background
  
    ## Apps -------------------------------------------------------- ##

    ## System ------------------------------------------------------ ##
    ./hyprland/keybind
    ./hyprland/userConfig

    ## Other-------------------------------------------------------- ##
  ];

############
# Packages #
#######################################################################
  home = {
    sessionPath = [
      "/home/${username}/.local/bin/"
    ];
    sessionVariables = {
      EDITOR = pkgs.ide;
    };
    ## ------------------------------------------------------------- ##
    packages = with pkgs; [
      ### Settings ------------------------------------------------ ###

      ### Volume -------------------------------------------------- ###

      ### Messaging ----------------------------------------------- ###

      ### Dev ----------------------------------------------------- ###

      ### Games --------------------------------------------------- ###

      ### Misc ---------------------------------------------------- ###

      ### Utils --------------------------------------------------- ###
    ];
  };
#######################################################################
}
