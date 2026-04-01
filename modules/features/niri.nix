{ self, inputs, ... }: {
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    programs.niri = {
      enable = true;
      package = self.packages.${pkgs.stdenv.hostPlatform.system}.myNiri;
    };
  };

  perSystem = { pkgs, lib, self', ... }: {
    packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
      inherit pkgs;
      settings = {
        spawn-at-startup = [
          (lib.getExe self'.packages.myNoctalia)
        ];

        xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

        input.keyboard.xkb.layout = "us";

        layout.gaps = 5;

        binds = {
          # Apps
          "Mod+Return".spawn-sh = lib.getExe pkgs.kitty;
          "Mod+B".spawn-sh = lib.getExe pkgs.brave;
          "Mod+V".spawn-sh = "code";
          "Mod+S".spawn-sh = "${lib.getExe self'.packages.myNoctalia} ipc call launcher toggle";
          "Mod+E".spawn-sh = "kitty lf";

          # Screenshots
          "Mod+Shift+S".screenshot = null;
          "Print".screenshot-screen = null;
          "Alt+Print".screenshot-window = null;

          # Window management
          "Mod+Q".close-window = null;
          "Mod+F".fullscreen-window = null;
          "Mod+Shift+F".toggle-window-floating = null;
          "Mod+C".center-window = null;

          # Focus (arrow keys + vim)
          "Mod+Left".focus-column-left = null;
          "Mod+Right".focus-column-right = null;
          "Mod+Up".focus-window-up = null;
          "Mod+Down".focus-window-down = null;
          "Mod+H".focus-column-left = null;
          "Mod+L".focus-column-right = null;
          "Mod+K".focus-window-up = null;
          "Mod+J".focus-window-down = null;

          # Move windows
          "Mod+Shift+Left".move-column-left = null;
          "Mod+Shift+Right".move-column-right = null;
          "Mod+Shift+H".move-column-left = null;
          "Mod+Shift+L".move-column-right = null;

          # Resize
          "Mod+Minus".set-column-width = "-10%";
          "Mod+Equal".set-column-width = "+10%";
          "Mod+R".switch-preset-column-width = null;

          # Workspaces
          "Mod+1".focus-workspace = 1;
          "Mod+2".focus-workspace = 2;
          "Mod+3".focus-workspace = 3;
          "Mod+4".focus-workspace = 4;
          "Mod+5".focus-workspace = 5;
          "Mod+Shift+1".move-column-to-workspace = 1;
          "Mod+Shift+2".move-column-to-workspace = 2;
          "Mod+Shift+3".move-column-to-workspace = 3;
          "Mod+Shift+4".move-column-to-workspace = 4;
          "Mod+Shift+5".move-column-to-workspace = 5;
          "Mod+Tab".focus-workspace-down = null;
          "Mod+Shift+Tab".focus-workspace-up = null;
          "Mod+O".toggle-overview = null;

          # Audio
          "XF86AudioRaiseVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
          "XF86AudioLowerVolume".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          "XF86AudioMute".spawn-sh = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
          "XF86AudioPlay".spawn-sh = "playerctl play-pause";
          "XF86AudioNext".spawn-sh = "playerctl next";
          "XF86AudioPrev".spawn-sh = "playerctl previous";

          # Brightness
          "XF86MonBrightnessUp".spawn-sh = "brightnessctl set 5%+";
          "XF86MonBrightnessDown".spawn-sh = "brightnessctl set 5%-";

          # System
          "Mod+Shift+Q".quit = null;
          "Mod+Shift+R".reload-config = null;
        };
      };
    };
  };
}
