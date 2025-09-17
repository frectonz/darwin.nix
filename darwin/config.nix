{ pkgs, ... }:
{
  environment.systemPackages = [ ];

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.sandbox = true;

  programs.fish.enable = true;

  users.users.frectonz = {
    name = "frectonz";
    home = "/Users/frectonz";
    shell = pkgs.fish;
  };

  environment.variables = {
    TERMINAL = "alacritty";
  };
}
