{ pkgs, ... }:
pkgs.mkShell {
  packages = [
    pkgs.statix
  ];
}
