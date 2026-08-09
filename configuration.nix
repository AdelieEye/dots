{ config, pkgs, ... }:

{
    imports = [ ./hardware-configuration.nix ];

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;

    networking.hostName = "adelie";
    networking.networkmanager.enable = true;

    time.timeZone = "Asia/Kolkata";
    i18n.defaultLocale = "en_US.UTF-8";
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

    services.xserver.xkb = {
        layout = "us";
        variant = "";
    };

    programs.sway.enable = true;
    programs.sway.xwayland.enable = true;

    services.kanata = {
        enable = true;
        keyboards = {
            "kbd" = {
                devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
                config = builtins.readFile ./dotfiles/kanata/kanata.kbd;
                extraDefCfg = ''
                    process-unmapped-keys yes
                    '';
            };
        };
    };

    #VM Config
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;

    users.users."_adelie" = {
        isNormalUser = true;
        description = "_adelie";
        extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
        packages = with pkgs; [];
    };

    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
        vim
        gcc15
        wl-clipboard
        chromium
    ];

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono   
        noto-fonts-cjk-sans  
    ];

    nix.settings.experimental-features = [ "nix-command" "flakes" ];
    networking.firewall.enable = true;

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

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    system.stateVersion = "26.05";

}
