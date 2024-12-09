{ pkgs, ... }: {
  imports = [ ./shell.nix ./terminals.nix ./editors.nix ];

  services.gpg-agent = {
    enable = true;
  };
  programs.gpg.enable = true;
  programs.fish.loginShellInit = "gpgconf --launch gpg-agent";

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
