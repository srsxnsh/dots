 { config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "neoptolemus";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_GB.UTF-8";
    LC_IDENTIFICATION = "en_GB.UTF-8";
    LC_MEASUREMENT = "en_GB.UTF-8";
    LC_MONETARY = "en_GB.UTF-8";
    LC_NAME = "en_GB.UTF-8";
    LC_NUMERIC = "en_GB.UTF-8";
    LC_PAPER = "en_GB.UTF-8";
    LC_TELEPHONE = "en_GB.UTF-8";
    LC_TIME = "en_GB.UTF-8";
  };

  console.keyMap = "uk";
  
  programs.sway.enable = true;


  programs.foot = {
    enable = true;
    settings = {
    colors = {
      alpha = "1.0";
      background = "24273a";
      foreground = "cad3f5";
      regular0 = "494d64";
      regular1 = "ed8796";
      regular2 = "a6da95";
      regular3 = "eed49f";
      regular4 = "8aadf4";
      regular5 = "f5bde6";
      regular6 = "8bd5ca";
      regular7 = "b8c0e0";
      bright0 = "5b6078";
      bright1 = "ed8796";
      bright2 = "a6da95";
      bright3 = "eed49f";
      bright4 = "8aadf4";
      bright5 = "f5bde6";
      bright6 = "8bd5ca";
      bright7 = "a5adcb";
    };
  };

  };

  programs.neovim = {
  enable = true;
  configure = {
    packages.myPlugins = with pkgs.vimPlugins; {
      start = [ catppuccin-nvim ];
    };
    customRC = ''
      lua << EOF
      require("catppuccin").setup({
        flavour = "macchiato"
      })
      vim.cmd("colorscheme catppuccin")
      EOF
    '';
  };
  };

  users.users.srsxnsh = {
    isNormalUser = true;
    description = "srsxnsh";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
	obsidian
	vivaldi
	mullvad-browser
	cmatrix
    ];
  };

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
	grim
	slurp
	foot
	git
	wmenu
	fastfetch
	ranger
	sxiv
	nim
	wget
  ];

  system.stateVersion = "25.11"; # Did you read the comment?
}
