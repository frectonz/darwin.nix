{ flake, ... }:
{
  imports = [
    ./nix.nix
    ./defaults
    ./user.nix
    ./fonts.nix
    ./nixpkgs.nix
    ./home-manager.nix
  ];

  system.stateVersion = 5;
  system.configurationRevision = flake.rev or flake.dirtyRev or null;
}
