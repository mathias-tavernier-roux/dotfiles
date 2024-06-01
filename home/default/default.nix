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
    ./rofi/rofi
    ./waybar
    ./lockscreen/configs
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
    ## ------------------------------------------------------------- ##
    packages = with pkgs; [
      ### Settings ------------------------------------------------ ###
      brightnessctl
      rofi
      rofi-bluetooth
      (pkgs.callPackage ./rofi/rofi-wpa { })
      (pkgs.callPackage ./rofi/rofi-mixer { })
      (pkgs.callPackage ./rofi/rofi-backup { })
      (pkgs.callPackage ./rofi/focus-rofi { })
      waybar
      libnotify
      dunst
      btop
      xdg-user-dirs
      acpi
      maim
      xclip
      looking-glass-client
      (pkgs.callPackage ./lockscreen/package { })
      (pkgs.callPackage ./hyprwal { })
      (pkgs.callPackage ./writable_configs { })
      wpgtk
      xorg.xhost

      ### Volume -------------------------------------------------- ###
      pavucontrol
      rofi-pulse-select
      (pkgs.callPackage ./rofi/rofi-beats { })
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

      ### Games --------------------------------------------------- ###
      prismlauncher

      ### Misc ---------------------------------------------------- ###
      krita
      neofetch
      libreoffice
      gnome.file-roller
      qpdfview
      mpv
      mpc-cli
      youtube-dl
      firefox
      vim
      viewnior
      cinnamon.nemo-with-extensions
      wf-recorder
      wl-clipboard
      ffmpeg
      grim
      slurp
      jq
      (pkgs.callPackage ./hyprshot { })

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
