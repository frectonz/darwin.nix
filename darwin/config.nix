{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  nix = {
    linux-builder.enable = true;
    settings.trusted-users = [ "@admin" ];
  };

  programs.fish.enable = true;

  users.users.frectonz = {
    name = "frectonz";
    home = "/Users/frectonz";
    shell = pkgs.fish;
  };

  environment.variables = { TERMINAL = "alacritty"; };
}
