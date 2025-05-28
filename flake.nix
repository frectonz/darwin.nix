{
  description = "frectonz nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    mac-app-util.url = "github:hraban/mac-app-util";
    mac-app-util.inputs.nixpkgs.follows = "nixpkgs";
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, mac-app-util, nur
    , nixvim }:
    let
      systems = [ "aarch64-darwin" ];

      forAllSystems = function:
        nixpkgs.lib.genAttrs systems (system:
          function (import nixpkgs {
            inherit system;
            overlays = [ ];
          }));
    in {
      darwinConfigurations."maxwell" = nix-darwin.lib.darwinSystem {
        pkgs = import nixpkgs {
          system = "aarch64-darwin";
          overlays = [ nur.overlays.default ];
          config.allowUnfree = true;
        };

        modules = [
          mac-app-util.darwinModules.default
          {
            # Used for backwards compatibility, please read the changelog before changing.
            # $ darwin-rebuild changelog
            system.stateVersion = 5;

            # Set Git commit hash for darwin-version.
            system.configurationRevision = self.rev or self.dirtyRev or null;

            # The platform the configuration will be used on.
            nixpkgs.hostPlatform = "aarch64-darwin";
            nixpkgs.config.allowUnfree = true;
          }
          ./darwin/config.nix

          home-manager.darwinModules.home-manager
          {
            # To enable it for all users:
            home-manager.sharedModules = [
              mac-app-util.homeManagerModules.default
              nixvim.homeManagerModules.nixvim
            ];

            home-manager.useUserPackages = true;
            home-manager.users.frectonz = import ./home/config.nix;
          }
        ];
      };

      formatter = forAllSystems (pkgs: pkgs.nixfmt-classic);
    };
}
