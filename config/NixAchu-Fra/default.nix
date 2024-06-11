{ username }:
{ config, pkgs, lib, ... }:
{
  boot = {
    kernelParams = [
      "amd_iommu=on"
      "radeon.si_support=0"
      "amdgpu.si_support=1"
      "radeon.cik_support=0"
      "amdgpu.cik_support=1"
      "video=eDP-2:2560x1600@165"
      "mem_sleep_default=deep"
    ];

    supportedFilesystems = [ "ntfs" ];
  };

  services.fprintd.enable = true;

  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];

  hardware.opengl = {
	  enable = true;
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
      mesa_drivers
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-media-driver
    ];
    extraPackages32 = with pkgs; [
      driversi686Linux.amdvlk
    ];
    driSupport = true;
    driSupport32Bit = true;
  };

  services.xserver.videoDrivers = [ "amdgpu" ];

  virtualisation.virtualMachines = {
    enable = true;
    username = username;
    sambaAccess.enable = true;

    machines = [
      {
        hardware = {
          cores = 5;
          memory = 20;
        };

        passthrough = {
          enable = true;
          pcies = [
            {
              lines = {
                bus = "03";
                slot = "00";
                functions = [
                  "0"
                  "1"
                ];
                ids = [
                  "1002:7480"
                  "1002:ab30"
                ];
              };
              driver = ''amdgpu'';
            }
          ];
        };
      }
    ];
  };
}
