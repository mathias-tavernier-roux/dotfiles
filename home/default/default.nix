{ username }:
{ pkgs, ... }:
{
###########
# Imports #
#######################################################################
  imports = [
    ## Config ------------------------------------------------------ ##
    ./extra_files
    ./gtk
    ./background
  
    ## Apps -------------------------------------------------------- ##
    ./kitty
    ./neofetch
    ./btop
    ./tmux
    ./git
    ./lvim
    ./libreoffice
    ./vencord

    ## System ------------------------------------------------------ ##
    ./fish
    ./rofi
    ./waybar
    ./lockscreen
    ./hyprland/hyprland
    ./hyprland/hyprland_color

    ## Other-------------------------------------------------------- ##
    ./programs.nix
  ];

############
# Packages #
#######################################################################
  home = {
    username = "${username}";
    homeDirectory = "/home/${username}";
    ## ------------------------------------------------------------- ##
    stateVersion = "24.05";
    sessionVariables = {
      EDITOR = "ide";
    };
    sessionPath = [
      "/home/${username}/.local/bin/"
    ];
    ## ------------------------------------------------------------- ##
    packages = with pkgs; [
      ### Settings ------------------------------------------------ ###
      brightnessctl
      rofi-wayland
      rofi-bluetooth
      rofi-wpa
      rofi-mixer
      backup-cli
      waybar
      libnotify
      dunst
      btop
      xdg-user-dirs
      acpi
      maim
      xclip
      looking-glass-client
      font-fixer
      (pkgs.callPackage ./hyprwal { })
      (pkgs.callPackage ./writable_configs { })
      wpgtk
      xorg.xhost

      ### Volume -------------------------------------------------- ###
      pavucontrol
      rofi-pulse-select
      rofi-beats
      easyeffects
      pulseaudio

      ### Messaging ----------------------------------------------- ###
      vesktop 
      linuxKernel.packages.linux_latest_libre.v4l2loopback

      ### Dev ----------------------------------------------------- ###
      jetbrains.phpstorm
      vscode
      kitty
      python311
      nodejs
      gnumake

      ### Games --------------------------------------------------- ###
      prismlauncher
      citra

      ### Misc ---------------------------------------------------- ###
      krita
      neofetch
      libreoffice
      onlyoffice-bin_latest
      gnome.file-roller
      qpdfview
      mpc-cli
      firefox
      vim
      viewnior
      cinnamon.nemo-with-extensions
      rofi-hyprshot
      rofi-power
      wineWowPackages.waylandFull

      ### Utils --------------------------------------------------- ###
      galculator
      flatpak
      lazygit
      mpd
      calc
      remmina
      pywal
      swaybg
      imagemagick
      freerdp
      sshfs
    ];
  };
#######################################################################
}
