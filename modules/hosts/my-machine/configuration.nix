{ self, inputs, ... }: {

  flake.nixosModules.myMachineConfiguration = { config, lib, pkgs, ... }: {

    imports = [
      self.nixosModules.myMachineHardware
      self.nixosModules.niri
    ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "MrFool";
    networking.networkmanager.enable = true;
    networking.firewall.allowedTCPPorts = [ 22 ];

    time.timeZone = "Asia/Kolkata";
    i18n.defaultLocale = "en_IN";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };

    # Login manager
    services.greetd = {
      enable = true;
      settings.default_session = {
        command = "${pkgs.cage}/bin/cage -s -- ${pkgs.greetd.regreet}/bin/regreet";
        user = "greeter";
      };
    };

    programs.regreet = {
      enable = true;
      theme = {
        name = "Adwaita-dark";
        package = pkgs.gnome-themes-extra;
      };
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
      font = {
        name = "JetBrainsMono Nerd Font";
        size = 16;
      };
      extraCss = ''
        window {
          background-image: url("file:///etc/greetd/wallpaper.jpg");
          background-size: cover;
          background-position: center;
        }
        box#main_box {
          background-color: rgba(0, 0, 0, 0.5);
          border-radius: 16px;
          padding: 32px;
          border: 1px solid rgba(255, 255, 255, 0.1);
        }
        entry {
          background-color: rgba(255, 255, 255, 0.1);
          border-radius: 8px;
          border: 1px solid rgba(255, 255, 255, 0.2);
          color: white;
          padding: 8px;
        }
        button {
          background-color: rgba(100, 150, 255, 0.7);
          border-radius: 8px;
          color: white;
          border: none;
          padding: 8px 16px;
        }
        button:hover {
          background-color: rgba(100, 150, 255, 0.9);
        }
        label {
          color: white;
        }
      '';
    };

    # Wallpaper for login screen
    environment.etc."greetd/wallpaper.jpg".source = ./wallpaper.jpg;

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    fonts = {
      enableDefaultPackages = true;
      packages = with pkgs; [
        nerd-fonts.jetbrains-mono
      ];
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    users.users.mr_fool = {
      isNormalUser = true;
      description = "Mr Fool";
      extraGroups = [ "networkmanager" "wheel" "wireshark" "docker" "video" "audio" ];
      shell = pkgs.zsh;
    };

    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      ohMyZsh = {
        enable = true;
        theme = "robbyrussell";
        plugins = [ "git" "sudo" "history" ];
      };
    };

    programs.starship = {
      enable = true;
      settings.add_newline = false;
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };

    programs.wireshark.enable = true;

    hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    services.blueman.enable = true;

    services.openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = false;
        PermitRootLogin = "no";
      };
    };
    services.avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    virtualisation.docker.enable = true;

    services.postgresql = {
      enable = true;
      package = pkgs.postgresql_16;
      dataDir = "/var/lib/postgresql/16";
    };

    services.flatpak.enable = true;
    services.printing.enable = true;
    services.udev.packages = with pkgs; [ rpi-imager ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      lf htop fastfetch vscode git blueman bluez
      unzip unrar wget curl docker-compose starship
      zlib fuse3 icu nss openssl expat
      python3 python3Packages.pip python3Packages.virtualenv
      nodejs jdk17 maven gradle uv go gcc
      brave postgresql_16
      nftables tcpdump nmap bettercap netcat
      wireshark rpi-imager putty openssh bind nettools
      xwayland-satellite playerctl brightnessctl cage
      papirus-icon-theme gnome-themes-extra metasploit
      nmap inetutils
    ];

    system.stateVersion = "25.11";
  };

}