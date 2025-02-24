{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [ ];

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];

  homebrew.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.sandbox = true;
  nix.settings.experimental-features = "nix-command flakes";

  users.users.frectonz = {
    name = "frectonz";
    home = "/Users/frectonz";
  };
}
