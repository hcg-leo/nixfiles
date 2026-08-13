{ config, lib, pkgs, inputs, ... }: {

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Boot 
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelModules = [ "i2c-dev" ];
  boot.kernelParams = [ "video=efifb:off" ];

  boot.loader.timeout = 10;
  boot.loader.limine = {
    enable = true;
    enableEditor = true;
    maxGenerations = 10;
    style = {
      wallpapers = [ "/home/tsukasa/walls/1.png" ];
      wallpaperStyle = "stretched";
      graphicalTerminal = {
        foreground = "c3c3c3";
	palette = "121212;3a3a3a;545454;707070;8b8b8b;a5a5a5;7d8180;c3c3c3" ;
        margin = 40;
      };
    };
  };

  # Networking
  networking.hostName = "shitbox";
  networking.networkmanager.enable = false;
  networking.dhcpcd.enable = true;
  networking.wireless.iwd.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };

#  nixpkgs.config.permittedInsecurePackages = [
#      "electron-40.10.5"
#    ];
#    #TODO: Remove when electron stops being shit

  # Locale & Time 
  time.timeZone = "Asia/Singapore";
  i18n.defaultLocale = "en_US.UTF-8";

  # Security
  security.polkit.enable = true;
  security.rtkit.enable = true;
  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [{
      groups = [ "wheel" ];
      keepEnv = true;
      persist = true;
    }];
  };

  # Hardware 
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver # or mesa.drivers if using AMD
    ];
  };
  hardware.i2c.enable = true;

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
    SUBSYSTEM=="backlight", RUN+="${pkgs.coreutils}/bin/chgrp video /sys/class/backlight/%k/brightness", RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/class/backlight/%k/brightness"
  '';

  # Audio
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # Desktop & Portals
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    config.common.default = "*";
  };

  # Fonts
  fonts = {
    packages = with pkgs; [
      nerd-fonts.go-mono
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      libertinus
    ];
  };

  # Programs
  programs.ssh.startAgent = true;

  # Storage
  fileSystems."/".options       = [ "compress=zstd" "noatime" ];
  fileSystems."/home".options = [ "compress=zstd" "noatime" ];
  fileSystems."/nix".options  = [ "compress=zstd" "noatime" ];
  fileSystems."/var/log".options = [ "compress=zstd" "noatime" ];
  fileSystems."/swap".options = [ "noatime" ];

  swapDevices = [{
    device = "/swap/swapfile";
    size = 8192;
  }];

  # User Management
  users.mutableUsers = true;
  users.users.tsukasa = {
    isNormalUser = true;
    shell = pkgs.mksh;
    extraGroups = [ "wheel" "video" "audio" "input" "i2c" ];
    packages = with pkgs; [
      neovim 
      imv 
      graphviz 
      btop
      fastfetch 
      foot 
      mako 
      waybar 
      glib 
      nix-index 
      swaybg 
      wofi 
      wl-clipboard 
      wlr-randr 
      grim 
      slurp 
      vesktop 
      localsend
      zathura 
      ani-cli
      tree 
      taglib
      halloy
      inputs.swindle.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.twobwc.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.make2flake.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.m701.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.sb.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.termipedia.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };

  environment.shells = [ "${pkgs.busybox}/bin/ash" pkgs.mksh ];
  
  environment.systemPackages = with pkgs; [
    git 
    mercurial
    gnumake 
    busybox 
    pkg-config 
    efibootmgr 
    curl 
    gcc
  ];

  system.stateVersion = "25.11";
}

