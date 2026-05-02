{
  flake,
  lib,
  config,
  ...
}:
{
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
}
