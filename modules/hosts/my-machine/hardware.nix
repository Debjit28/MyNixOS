{ self, inputs, ... }: {

  flake.nixosModules.myMachineHardware = { config, lib, pkgs, modulesPath, ... }: {

    imports = [
      (modulesPath + "/installer/scan/not-detected.nix")
    ];

    boot.initrd.availableKernelModules = [ "xhci_pci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ "kvm-intel" ];
    boot.extraModulePackages = [ ];

    fileSystems."/" = {
      device = "/dev/disk/by-uuid/5581a2f8-a41e-4d14-a45f-71becab86a68";
      fsType = "ext4";
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/C826-79F3";
      fsType = "vfat";
      options = [ "fmask=0077" "dmask=0077" ];
    };

    swapDevices = [ ];
    nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
    hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  };

}