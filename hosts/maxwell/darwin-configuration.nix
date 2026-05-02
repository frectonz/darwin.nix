{ flake, ... }:
{
  imports = [
    ./fonts.nix
    ./home-manager.nix
    ./nix.nix
    ./nixpkgs.nix
    ./user.nix
  ];

  system.stateVersion = 5;
  system.configurationRevision = flake.rev or flake.dirtyRev or null;
}
