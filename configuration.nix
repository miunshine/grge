# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:
 {
  services.avahi.enable = true;
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./useNixUnstable.nix
      #./disableBacklight.nix
      ./disablekeys.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  # networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  # time.timeZone = "Europe/Amsterdam";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp4s0.useDHCP = true;
  networking.interfaces.wlp2s0.useDHCP = true;
  networking.networkmanager.enable = true;
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  hardware.bluetooth.enable = true;
  #services.blueman.enable = true;

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

    
  # Xfce Desktop Environment
  services.xserver.desktopManager.xterm.enable = false;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.displayManager.defaultSession = "xfce";
  # Configure keymap in X11
  # services.xserver.layout = "us";
  # services.xserver.xkbOptions = "eurosign:e";
  

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.moonshine = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    hashedPassword = "$6$GVTTyGJ.lQ$jmAkUw6yENRfrDN.jz3K5UArnNdk9UiOdnepVEcreFDn7LiUPO4CBIHKsNcEBZyGBrgnjDmzDFDQwAqLTmTy6.";
  };

  users.users.root.hashedPassword = "${config.users.users.moonshine.hashedPassword}";

  # Disable password prompt when using sudo for all users in the "wheel" group,
  # such as moonshine.
  security.sudo.wheelNeedsPassword = false;

  users.mutableUsers = false;

  boot.extraModprobeConfig = ''
    snd_hda_intel probe_only=0,1
  '';

  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim 
    wget
    firefox
    fossil
    chromium
    sqlite
    vlc
    mpv
    qbittorrent
    #(rstudioWrapper.override {
    #  packages = with rPackages; 
    #    [ ggplot2 dplyr shiny RSQLite ggiraph magrittr ggpubr DBI ];
    #})    
    pandoc
    hexchat
    ffmpeg
    unzip
    rar
    tcl
   # xorg.xmodmap
   # xorg.xkbcomp
    gimp
    pinta

    feh
    tclx
    file 
    git
    (perl532.withPackages (_: with perl532Packages; [ TextGlob Git ]))
    gnumake
    calibre

    mmark
    xml2rfc
    go
    mdbook
   
    
    blender
         ];


 # Virtual Box
  #virtualisation.virtualbox.host.enable = true;
  #users.extraGroups.vboxusers.members = ["moonshine"];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.05"; # Did you read the comment?

}

