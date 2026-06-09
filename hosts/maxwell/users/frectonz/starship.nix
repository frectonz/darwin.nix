{ pkgs, ... }:
let
  jjDetect = pkgs.writeShellScript "jj-detect" ''
    dir="$PWD"
    while :; do
      [ -d "$dir/.jj" ] && exit 0
      [ "$dir" = "/" ] && break
      dir=$(dirname "$dir")
    done
    exit 1
  '';
in
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    extraPackages = [ pkgs.jj-starship ];
    settings = {
      custom.jj.when = "${jjDetect}";
      custom.jj.command = "jj-starship";
      custom.jj.format = "$output ";
    };
  };
}
