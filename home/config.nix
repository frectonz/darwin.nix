{ pkgs, config, ... }: {
  imports = [ ./shell.nix ./terminals.nix ./editors.nix ./browsers.nix ];

  services.gpg-agent.enable = true;
  programs.gpg.enable = true;
  programs.fish.loginShellInit = "gpgconf --launch gpg-agent";

  programs.password-store = {
    enable = true;
    settings = {
      PASSWORD_STORE_DIR = "${config.home.homeDirectory}/.password-store";
      PASSWORD_STORE_KEY = "9CFA458945B7094F";
    };
  };

  programs.mpv.enable = true;
  home.packages = [ pkgs.vlc-bin ];

  nixpkgs.config.allowUnfree = true;

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
