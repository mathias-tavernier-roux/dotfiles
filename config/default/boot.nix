{ config, pkgs, ... }:
{
  boot = {
    initrd.availableKernelModules = [
      "ahci"
      "ohci_pci"
      "ehci_pci"
      "pata_atiixp"
      "xhci_pci"
      "firewire_ohci"
      "usb_storage"
      "usbhid"
      "sd_mod"
      "sr_mod"
    ];

    kernel.sysctl = { "vm.swappiness" = 1;};
    loader = {
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        gfxmodeEfi = "1920x1080x32";
        useOSProber = true;
      };
    };

    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    
    kernelModules = [
      "v4l2loopback"
    ];
  };
}
