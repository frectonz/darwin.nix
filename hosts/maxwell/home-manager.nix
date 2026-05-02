{ flake, ... }:
{
  home-manager.backupCommand = "echo";
  home-manager.sharedModules = [
    flake.inputs.nixvim.homeModules.nixvim
  ];
}
