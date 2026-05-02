{ pkgs, ... }:
{
  users.users.frectonz = {
    name = "frectonz";
    home = "/Users/frectonz";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];
}
