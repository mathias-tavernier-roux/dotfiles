{ stdenv, lib, pkgs }:
############
# Packages #
#######################################################################
stdenv.mkDerivation (finalAttrs: {
  pname = "rofi-backup";
  version = "unstable-2023-07-16";
  # ----------------------------------------------------------------- #
  src = ./src;
  buildInputs = with pkgs; [
    rsync
    sshfs
  ];
  # ----------------------------------------------------------------- #
  installPhase = ''
    runHook preInstall
    install -D --target-directory=$out/bin/ ./backup-cli
    install -D --target-directory=$out/bin/ ./rofi-backup
    runHook postInstall
  '';
  # ----------------------------------------------------------------- #
  meta = with lib; {
    description = "rofi rsync backup manager";
    maintainers = [ maintainers.pikatsuto ];
    licenses = licenses.lgpl;
    platforms = platforms.linux;
  };
#######################################################################
})
