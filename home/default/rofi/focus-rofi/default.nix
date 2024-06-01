{ stdenv, lib }:
############
# Packages #
#######################################################################
stdenv.mkDerivation (finalAttrs: {
  pname = "focus-rofi";
  version = "unstable-2023-07-16";
  # ----------------------------------------------------------------- #
  src = ./src;
  # ----------------------------------------------------------------- #
  installPhase = ''
    runHook preInstall
    install -D --target-directory=$out/bin/ ./focus-rofi
    runHook postInstall
  '';
  # ----------------------------------------------------------------- #
  meta = with lib; {
    description = "rofi hyrpland focus fixer";
    maintainers = [ maintainers.pikatsuto ];
    licenses = licenses.lgpl;
    platforms = platforms.linux;
  };
#######################################################################
})
