{ pkgs, ... }:
{
  environment.systemPackages = [ ];

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.sandbox = true;

  users.users.frectonz = {
    name = "frectonz";
    home = "/Users/frectonz";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  environment.variables = {
    TERMINAL = "alacritty";
  };
}
