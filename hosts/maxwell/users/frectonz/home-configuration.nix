{ pkgs, ... }:
{
  imports = [
    ./atuin.nix
    ./direnv.nix
    ./fish.nix
    ./gh.nix
    ./git.nix
    ./gpg.nix
    ./helix.nix
    ./nh.nix
    ./nix-index.nix
    ./nixvim.nix
    ./pass.nix
    ./starship.nix
    ./zellij.nix
    ./jj.nix
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

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;

  programs.asciinema.enable = true;
  programs.asciinema.package = pkgs.asciinema_3;
}
