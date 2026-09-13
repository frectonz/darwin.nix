{ perSystem, ... }:
{
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (_final: _prev: { inherit (perSystem.self) workspace; })
  ];
}
