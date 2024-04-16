{ config, pkgs, ... }:
{
############
# Programs #
#######################################################################
  nixpkgs.config.allowUnfree = true;
  # ----------------------------------------------------------------- #
  programs = {
    home-manager.enable = true;
    ## ------------------------------------------------------------- ##
    bat = {
      enable = true;
      config.theme = "base16";
    };
    ## ------------------------------------------------------------- ##
    dircolors.enable = true;
    ## ------------------------------------------------------------- ##
    obs-studio = {
      enable = true;
      plugins = [ pkgs.obs-studio-plugins.droidcam-obs ];
    };
    ## ------------------------------------------------------------- ##
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      enableZshIntegration = true;
    };
    ## ------------------------------------------------------------- ##
    feh.enable = true;
    lazygit.enable = true;
    neovim = {
      extraPackages = with pkgs; [
        clang-tools
        llvmPackages_latest.clang
        nil
      ];
      enable = true;
    };
  };
#######################################################################
}
