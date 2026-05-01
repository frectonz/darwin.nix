{ pkgs, ... }:
{
  imports = [
    ./fish.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./nixvim.nix
    ./pass.nix
    ./starship.nix
  ];

  home.packages = with pkgs; [
    bat
    lsd
    duf
    htop
    btop
    ffmpeg
    lazygit
    ripgrep
    workspace
    difftastic

    fd
    uv
    sfz
    bun
    yarn
    ruby
    pnpm
    wget
    nixd
    ninja
    nodejs
    pkgconf
    typescript-language-server

    rust-bin.stable.latest.default
  ];

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.zellij = {
    enable = true;
    settings = {
      default_shell = "fish";
    };
  };

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
