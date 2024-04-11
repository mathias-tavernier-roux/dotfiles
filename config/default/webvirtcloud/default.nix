{ pkgs, ... }:
#############
# Variables #
#######################################################################
let
  test = pkgs.dockerTools.buildImage {
    name = "backend-deps";
    tag = "latest";

    fromImageName = "python";
    fromImageTag = "3.10-alpine";

    copyToRoot = pkgs.buildEnv {
      name = "image-root";
      paths = [
        "./webvirtbackend/requirements/production.txt"
        "./optional-requirements.txt*"
      ];
      pathsToLink = [
        "/requirements/requirements.txt"
          "/requirements/"
      ];
    };

    runAsRoot = ''
      #!${pkgs.runtimeShell}
      mkdir -p /data
      '';

    config = {
      Cmd = [ "/bin/redis-server" ];
      WorkingDir = "/data";
      Volumes = { "/data" = { }; };
    };

    diskSize = 1024;
    buildVMMemorySize = 512;
  }
in {
###########
# Service #
#######################################################################

#######################################################################
}
