{
  flake,
  perSystem,
  pkgs,
  ...
}:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (_final: _prev: { inherit (perSystem.self) workspace; })
    (import flake.inputs.rust-overlay)
  ];

  system.stateVersion = 5;
  system.configurationRevision = flake.rev or flake.dirtyRev or null;

  fonts.packages = with pkgs; [ nerd-fonts.fira-code ];

  nix.settings.experimental-features = "nix-command flakes";
  nix.settings.sandbox = true;

  users.users.frectonz = {
    name = "frectonz";
    home = "/Users/frectonz";
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
  environment.shells = [ pkgs.fish ];

  home-manager.backupCommand = "echo";
  home-manager.sharedModules = [
    flake.inputs.nixvim.homeModules.nixvim
  ];
}
