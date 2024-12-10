{ pkgs, ... }:
let
  firefox = pkgs.stdenv.mkDerivation rec {
    pname = "Firefox";
    version = "134.0b8";

    buildInputs = [ pkgs.undmg ];
    sourceRoot = ".";
    phases = [ "unpackPhase" "installPhase" ];
    installPhase = ''
      mkdir -p "$out/Applications"
      cp -r Firefox.app "$out/Applications/Firefox.app"
    '';

    src = pkgs.fetchurl {
      name = "Firefox-${version}.dmg";
      url =
        "https://download-installer.cdn.mozilla.net/pub/firefox/releases/${version}/mac/en-US/Firefox%20${version}.dmg";
      sha256 = "sha256-jYdvkCBwIKqrOKJvpkVVd0UUA6bl/QPgClpu+pXImac=";
    };
  };
in {
  programs.firefox = {
    enable = true;
    package = firefox;
    profiles.frectonz = {
      containers = {
        personal = {
          color = "green";
          icon = "tree";
          id = 1;
        };
        work = {
          color = "yellow";
          icon = "briefcase";
          id = 2;
        };
      };

      search = {
        default = "DuckDuckGo";
        engines = {
          "Nix Packages" = {
            urls = [{
              template = "https://search.nixos.org/packages";
              params = [
                {
                  name = "type";
                  value = "packages";
                }
                {
                  name = "query";
                  value = "{searchTerms}";
                }
              ];
            }];

            icon =
              "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
            definedAliases = [ "@np" ];
          };

          "NixOS Wiki" = {
            urls = [{
              template =
                "https://wiki.nixos.org/index.php?search={searchTerms}";
            }];
            iconUpdateURL = "https://wiki.nixos.org/favicon.png";
            updateInterval = 24 * 60 * 60 * 1000; # every day
            definedAliases = [ "@nw" ];
          };

          "Bing".metaData.hidden = true;
          "Google".metaData.alias = "@g";
        };
        order = [ "DuckDuckGo" "Google" ];
      };

      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        onetab
        tabliss
        ublock-origin
        privacy-badger
      ];
    };
  };
}
