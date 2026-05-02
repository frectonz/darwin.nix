{
  flake,
  perSystem,
  lib,
  config,
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

  nix =
    let
      flakeInputs = lib.filterAttrs (_: lib.isType "flake") flake.inputs;
    in
    {
      settings = {
        experimental-features = "nix-command flakes";
        sandbox = true;
        flake-registry = "";
        nix-path = config.nix.nixPath;
        connect-timeout = 10;
        http-connections = 25;
        download-attempts = 5;
      };
      channel.enable = false;
      registry = lib.mapAttrs (_: f: { flake = f; }) flakeInputs;
      nixPath = lib.mapAttrsToList (n: _: "${n}=flake:${n}") flakeInputs;
    };

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
