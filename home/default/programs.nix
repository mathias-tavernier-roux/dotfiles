{ config, pkgs, ... }:
{
############
# Programs #
#######################################################################
  xdg.mimeApps = {
    enable = true;
    associations.added = {
      "application/x-msdownload" =
        "wine.desktop";
      "application/vnd.microsoft.portable-executable" =
        "wine.desktop";
    };
    ## ------------------------------------------------------------- ##
    defaultApplications = {
      "application/zip" = "file-roller.desktop";
      "application/rar" = "file-roller.desktop";
      "application/x-compressed-tar" = "file-roller.desktop";
      "text/plain" = [
        "code.desktop"
        "neovim.desktop"
      ];
      "application/pdf" = [
        "qpdfview.desktop"
        "firefox.desktop"
      ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.text" =
        "writer.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
        "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.presentation" =
        "impress.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
        "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.spreadsheet" =
        "calc.desktop";
      "application/msword" =
        "onlyoffice-desktopeditors.desktop";
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
      "application/x-msdownload" =
        "wine.desktop";
      "application/vnd.microsoft.portable-executable" =
        "wine.desktop";
    };
  };
#######################################################################
}
