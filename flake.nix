{
  description = "frectonz nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    rust-overlay.url = "github:oxalica/rust-overlay";
    rust-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      home-manager,
      nur,
      nixvim,
      rust-overlay,
    }:
    let
      systems = [ "aarch64-darwin" ];

      forAllSystems =
        function:
        nixpkgs.lib.genAttrs systems (
          system:
          function (
            import nixpkgs {
              inherit system;
              overlays = [ (import rust-overlay) ];
            }
          )
        );
    in
    {
      darwinConfigurations."maxwell" = nix-darwin.lib.darwinSystem {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          overlays = [
            nur.overlays.default
            (import rust-overlay)
          ];
          config.allowUnfree = true;
        };

        modules = [
          {
            system.stateVersion = 5;
            system.configurationRevision = self.rev or self.dirtyRev or null;
            nixpkgs.hostPlatform = "aarch64-darwin";
            nixpkgs.config.allowUnfree = true;
          }

          ./darwin/config.nix

          home-manager.darwinModules.home-manager
          {
            home-manager.sharedModules = [
              nixvim.homeManagerModules.nixvim
            ];

            home-manager.useGlobalPkgs = true;
            home-manager.users.frectonz = import ./home/config.nix;
            home-manager.backupCommand = "echo";
          }
        ];
      };

      formatter = forAllSystems (
        pkgs:
        pkgs.treefmt.withConfig {
          runtimeInputs = [ pkgs.nixfmt-rfc-style ];

          settings = {
            # Log level for files treefmt won't format
            on-unmatched = "info";

            # Configure nixfmt for .nix files
            formatter.nixfmt = {
              command = "nixfmt";
              includes = [ "*.nix" ];
            };
          };
        }
      );
    };
}
