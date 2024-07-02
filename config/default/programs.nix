{ pkgs, ... }:
let
  custonFonts = with pkgs; [
    dina-font
    fira-code
    fira-code-symbols
    liberation_ttf
    mplus-outline-fonts.githubRelease
    noto-fonts-emoji
    nerdfonts
    terminus-nerdfont
    inconsolata-nerdfont
    dejavu_fonts
    hackgen-nf-font
    proggyfonts
    wine64Packages.fonts
    corefonts
    vistafonts
    material-icons
    material-design-icons
  ];
in {
############
# Settings #
#######################################################################
  programs = {
    command-not-found.enable = false;
    dconf.enable = true;
    ## ------------------------------------------------------------- ##
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    ## ------------------------------------------------------------- ##
    fish.enable = true;
    ## ------------------------------------------------------------- ##
    corectrl.enable = true;
  };
#########
# Fonts #
#######################################################################
  nixpkgs.config.allowUnfreePredicate = custonFonts;
  fonts.packages = custonFonts;
###########
# Package #
#######################################################################
  environment = {
    shells = with pkgs; [ fish ];
    variables.EDITOR = "ide";
    unixODBCDrivers = with pkgs; [
      unixODBCDrivers.msodbcsql18
    ];
    systemPackages = with pkgs; [
      ### Utils --------------------------------------------------- ###
      git
      htop
      tree
      nano
      wget
      curl
      zip
      unzip
      winetricks
      fish
      fishPlugins.bobthefish
      killall
      bc
      tmux
      pciutils
      nix-direnv
      fishPlugins.bass
      droidcam
      android-tools

      ### System -------------------------------------------------- ###
      modemmanager
      gdu
      xdotool
      wpgtk
      swaylock-effects
      ldacbt
      coreutils
      v4l-utils
      bluez-tools
      bluez-alsa
      bluetuith

      ### Dev ----------------------------------------------------- ###
      virt-manager
      neovim
      lazygit
      ide
      man-pages
      man-pages-posix
      wireguard-tools
      openvpn

      ### Game ---------------------------------------------------- ###
      lutris
      heroic
      mangohud
    ];
  };
 # ------------------------------------------------------------------ #
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
#######################################################################
}
