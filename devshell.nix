{ pkgs, ... }:
pkgs.mkShell {
  packages = [
    pkgs.nh
    pkgs.nixd
    pkgs.statix
  ];
}
