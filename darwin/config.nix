{ pkgs, ... }:
{
  environment.systemPackages = [ ];

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.sandbox = true;

  users.users.frectonz = {
    name = "frectonz";
    home = "/Users/frectonz";
  };

  environment.variables = {
    TERMINAL = "alacritty";
  };
}
