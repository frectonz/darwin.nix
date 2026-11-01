{ pkgs, ... }:
{
  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
    # 18.24.4 fails its tests; use cached 18.24.2 until nixpkgs fixes it.
    package = pkgs.symlinkJoin {
      name = "atuin-18.24.2";
      paths = [
        (builtins.fetchClosure {
          fromStore = "https://cache.nixos.org";
          fromPath = /nix/store/71b0hd03a7k790g0ps327jkbplrxisba-atuin-18.24.2;
          inputAddressed = true;
        })
      ];
      meta.mainProgram = "atuin";
    };
  };
}
