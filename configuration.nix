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

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_BR.UTF-8";
    LC_IDENTIFICATION = "pt_BR.UTF-8";
    LC_MEASUREMENT = "pt_BR.UTF-8";
    LC_MONETARY = "pt_BR.UTF-8";
    LC_NAME = "pt_BR.UTF-8";
    LC_NUMERIC = "pt_BR.UTF-8";
    LC_PAPER = "pt_BR.UTF-8";
    LC_TELEPHONE = "pt_BR.UTF-8";
    LC_TIME = "pt_BR.UTF-8";
  };

  # Configure keymap in X11
  services.xserver = {
    enable = true; # Enable the X11 windowing system.
    layout = "us";
    xkbVariant = "";

    # Enable the GNOME Desktop Environment.
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
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
            "user-theme@gnome-shell-extensions.gcampax.github.com"
          ];
        };

        "org/gnome/shell/extensions/user-theme" = {
          name = "Catppuccin-Macchiato-Compact-Mauve-Dark";
        };

        "org/gnome/desktop/interface" = {
          icon-theme = "Papirus";
          gtk-theme = "Catppuccin-Macchiato-Compact-Mauve-Dark";
          color-scheme = "prefer-dark";
        };

        "org/gnome/desktop/peripherals/mouse".natural-scroll = true;

        "org/gnome/settings-daemon/plugins/media-keys" = {
          screensaver = ["<Control><Super>q"];
        };

        "org/gnome/desktop/wm/keybindings" = {
          close = ["<Super>q"];
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
    brave

    todoist-electron
    morgen
    _1password-gui

    neofetch

    gnome.gnome-terminal
    gnomeExtensions.paperwm
    gnomeExtensions.vertical-workspaces
    gnome.gnome-tweaks
    gnome.gnome-themes-extra

    alejandra # nix languageformatter
  ];

  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };

  programs.dconf = {
    enable = true;
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
