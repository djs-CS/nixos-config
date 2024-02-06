# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  ...
}: let
  unstable =
    import (builtins.fetchTarball https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz)
    {config = config.nixpkgs.config;};
  home-manager = builtins.fetchTarball https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz;
in {
  # Include the results of the hardware scan.
  imports = [
    ./hardware-configuration.nix
    (import "${home-manager}/nixos")
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Sao_Paulo";

  # Configure keymap in X11
  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    layout = "us";
    xkbVariant = "";

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    # Remove xTerm app
    excludePackages = [pkgs.xterm];
    desktopManager.xterm.enable = false;
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.djs = {
    isNormalUser = true;
    description = "Dylan Josef Sumser";
    extraGroups = ["networkmanager" "wheel"];
  };

  home-manager.useGlobalPkgs = true;
  home-manager.users.djs = {
    programs.alacritty = {
      enable = true;
      package = unstable.alacritty;
      # use a color scheme from the overlay
      settings = {
        colors = {
          # Default colors
          primary = {
            background = "#24273A"; # base
            foreground = "#CAD3F5"; # text
            # Bright and dim foreground colors
            dim_foreground = "#CAD3F5"; # text
            bright_foreground = "#CAD3F5"; # text
          };

          # Cursor colors
          cursor = {
            text = "#24273A"; # base
            cursor = "#F4DBD6"; # rosewater
          };
          vi_mode_cursor = {
            text = "#24273A"; # base
            cursor = "#B7BDF8"; # lavender
          };

          # Search colors
          search = {
            matches = {
              foreground = "#24273A"; # base
              background = "#A5ADCB"; # subtext0
            };
            focused_match = {
              foreground = "#24273A"; # base
              background = "#A6DA95"; # green
            };
          };

          # Keyboard regex hints
          hints = {
            start = {
              foreground = "#24273A"; # base
              background = "#EED49F"; # yellow
            };
            end = {
              foreground = "#24273A"; # base
              background = "#A5ADCB"; # subtext0
            };
          };

          # Selection colors
          selection = {
            text = "#24273A"; # base
            background = "#F4DBD6"; # rosewater
          };

          # Normal colors
          normal = {
            black = "#494D64"; # surface1
            red = "#ED8796"; # red
            green = "#A6DA95"; # green
            yellow = "#EED49F"; # yellow
            blue = "#8AADF4"; # blue
            magenta = "#F5BDE6"; # pink
            cyan = "#8BD5CA"; # teal
            white = "#B8C0E0"; # subtext1
          };

          # Bright colors
          bright = {
            black = "#5B6078"; # surface2
            red = "#ED8796"; # red
            green = "#A6DA95"; # green
            yellow = "#EED49F"; # yellow
            blue = "#8AADF4"; # blue
            magenta = "#F5BDE6"; # pink
            cyan = "#8BD5CA"; # teal
            white = "#A5ADCB"; # subtext0
          };

          # Dim colors
          dim = {
            black = "#494D64"; # surface1
            red = "#ED8796"; # red
            green = "#A6DA95"; # green
            yellow = "#EED49F"; # yellow
            blue = "#8AADF4"; # blue
            magenta = "#F5BDE6"; # pink
            cyan = "#8BD5CA"; # teal
            white = "#B8C0E0"; # subtext1
          };

          indexed_colors = [
            {
              index = 16;
              color = "#F5A97F";
            }
            {
              index = 17;
              color = "#F4DBD6";
            }
          ];
        };
      };
    };
    gtk = {
      enable = true;

      iconTheme = {
        name = "Papirus";
        package = pkgs.catppuccin-papirus-folders.override {
          accent = "mauve";
          flavor = "macchiato";
        };
      };

      theme = {
        name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
        package = pkgs.catppuccin-gtk.override {
          accents = ["mauve"];
          size = "compact";
          tweaks = ["normal"];
          variant = "macchiato";
        };
      };
    };
    home = {
      stateVersion = "23.11";
    };

    dconf = {
      enable = true;
      settings = {
        "org/gnome/shell" = {
          enabled-extensions = [
            "paperwm@paperwm.github.com"
            "pomodoro@arun.codito.in"
            "sp-tray@sp-tray.esenliyim.github.com"
            "user-theme@gnome-shell-extensions.gcampax.github.com"
            "vertical-workspaces@G-dH.github.com"
            "trayIconsReloaded@selfmade.pl"
          ];
          favorite-apps = [
            "Alacritty.desktop"
            "code.desktop"
            "obsidian.desktop"

            "todoist.desktop"
            "morgen.desktop"
            "chromium-browser.desktop"

            "spotify.desktop"
            "slack.desktop"
            "figma-linux.desktop"
          ];
        };

        "org/gnome/shell/extensions/user-theme" = {
          name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
        };

        "org/gnome/desktop/interface" = {
          icon-theme = "Papirus";
          gtk-theme = "Catppuccin-Macchiato-Compact-Mauve-Dark";
          color-scheme = "prefer-dark";

          font-name = "Geist Light 11";
          document-font-name = "Geist Medium 11";
          monospace-font-name = "Geist Mono 10";
        };

        "org/gnome/desktop/peripherals/mouse".natural-scroll = true;

        "org/gnome/settings-daemon/plugins/media-keys" = {
          screensaver = ["<Control><Super>q"];
        };

        "org/gnome/desktop/background" = {
          color-shading-type = "solid";
          picture-opacity = 100;
          picture-options = "zoom";
          picture-uri = "file:///usr/share/nix.png";
          picture-uri-dark = "file:///usr/share/nix.png";
          primary-color = "#000000";
          secondary-color = "#000000";
          show-desktop-icons = false;
        };

        "org/gnome/desktop/screensaver" = {
          user-switch-enabled = true;
        };
      };
    };
  };

  nixpkgs.config = {
    allowUnfree = true; # allow unfree packages
    permittedInsecurePackages = [
      "electron-25.9.0"
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    gh

    anki
    unstable.obsidian
    unstable.vscode

    spotify
    chromium

    slack
    figma-linux
    zoom-us

    todoist-electron
    morgen
    _1password-gui

    neofetch

    gnomeExtensions.paperwm
    gnomeExtensions.vertical-workspaces
    gnomeExtensions.spotify-tray
    gnomeExtensions.tray-icons-reloaded
    gnome.gnome-tweaks
    gnome.gnome-themes-extra

    gnome.pomodoro

    alejandra # nix languageformatter
  ];

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-photos
      gnome-tour
      gnome-console # terminal emulator
    ])
    ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-music
      gnome-terminal
      gedit # text editor
      epiphany # web browser
      geary # email reader
      evince # document viewer
      gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.chromium = {
    enable = true;
    extensions = [
      "aeblfdkhhhdcdjpifhhbdiojplfjncoa" #1Password
      "cjpalhdlnbpafiamejdnhcphjbkeiagm" #uBlock Origin
      "jldhpllghnbhlbpcmnajkpdmadaolakh" #ToDoist
      "cmpdlhmnmjhihmcfnigoememnffkimlk" #Catpuccin Theme
      "jjhefcfhmnkfeepcpnilbbkaadhngkbi" #Readwise Highlighter
    ];
    extraOpts = {
      "PasswordManagerEnabled" = false;
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = [
        "de"
        "en-US"
        "pt-BR"
      ];
    };
  };

  programs.dconf = {
    enable = true;
    profiles = {
      gdm.databases = [
        {
          settings = {
            "org/gnome/login-screen" = {
              banner-message-enable = true;
              banner-message-text = "Get Focused\nHave Fun\nBegin Again";
            };
          };
        }
      ];
    };
  };
  environment.variables = {
    EDITOR = "nvim";
    SUDO_EDITOR = "nvim";
    GTK_THEME = "Catppuccin-Macchiato-Compact-Mauve-Dark"; # This allows GTK-4 Styles to be applied automatically
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).

  system.stateVersion = "23.11"; # Did you read the comment?
}
