{ stdenv, lib, pkgs }:
############
# Packages #
#######################################################################
let 
  pname = "citra";
  appimageName = "citra-qt.AppImage";
  iconPath = "dist/citra.png";
  name = "Citra PabloMK7";
  comment = "Citra 3DS emulator";
  # ----------------------------------------------------------------- #
in stdenv.mkDerivation (finalAttrs: {
  pname = pname;
  version = "unstable-2023-07-16";
  # ----------------------------------------------------------------- #
  src = pkgs.fetchurl {
    url = "https://github.com/PabloMK7/citra/releases/download/rde1f082/citra-linux-appimage-20240601-de1f082.tar.gz";
    sha256 = "4c8e57d5e891b0f75baa8ff605c9fa4d90f13e15f8d60daa0edb21763b9a70da";
  };
  # ----------------------------------------------------------------- #
  installPhase = ''
    runHook preInstall

    mkdir -p $out/Applications
    cp -r ./ $out/Applications/${pname}

    echo -e "#!" "/usr/bin/env sh\n\n" \
      "${pkgs.appimage-run}/bin/appimage-run" \
      "$out/Applications/${pname}/${appimageName}" \
      > ./${pname}
    install -D --target-directory=$out/bin/ \
      ./citra

    echo -e "[Desktop Entry]\n" \
      "Type=Application\n" \
      "Name=${name}\n" \
      "Comment=${comment}\n" \
      "Icon=$out/Applications/${pname}/${iconPath}\n" \
      "Exec=$out/bin/${pname}\n" \
      "Terminal=false" > ./${pname}.desktop
    install -D --target-directory=$out/share/applications/ \
      ${pname}.desktop

    runHook postInstall
  '';
  # ----------------------------------------------------------------- #
  meta = with lib; {
    description = comment;
    maintainers = [ maintainers.pikatsuto ];
    licenses = licenses.gpl2;
    platforms = platforms.linux;
  };
#######################################################################
})
