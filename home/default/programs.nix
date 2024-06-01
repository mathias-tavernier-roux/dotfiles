{ config, pkgs, ... }:
{
############
# Programs #
#######################################################################
  nixpkgs.config.allowUnfree = true;
  # ----------------------------------------------------------------- #
  xdg.mimeApps = {
    enable = true;
    ## ------------------------------------------------------------- ##
    defaultApplications = {
      "application/zip" = [
       "xarchiver.desktop"
       "unzip"
      ];
      "text/plain" = [
        "code.desktop"
        "neovim.desktop"
      ];
      "application/pdf" = [
        "qpdfview.desktop"
        "firefox.desktop"
      ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        "libreoffice.desktop";
      "application/vnd.oasis.opendocument.text" =
        "libreoffice.desktop";
      "image/png" = [
        "viewnior.desktop"
        "feh.desktop"
      ];
      "image/jpg" = [
        "viewnior.desktop"
        "feh.desktop"
      ];
      "image/jpeg" = [
        "viewnior.desktop"
        "feh.desktop"
      ];
      "image/gif" = [
        "viewnior.desktop"
        "feh.desktop"
      ];
      "image/webm" = [
        "viewnior.desktop"
        "feh.desktop"
      ];
      "application/vnd.microsoft.portable-executable" =
        "wine";
    };
  };
  # ----------------------------------------------------------------- #
  programs = {
    home-manager.enable = true;
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
