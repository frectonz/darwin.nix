{ pkgs, ... }:
{
  imports = [
    ./fd.nix
    ./gh.nix
    ./jj.nix
    ./nh.nix
    ./bat.nix
    ./git.nix
    ./gpg.nix
    ./lsd.nix
    ./btop.nix
    ./fish.nix
    ./htop.nix
    ./pass.nix
    ./atuin.nix
    ./helix.nix
    ./direnv.nix
    ./nixvim.nix
    ./zellij.nix
    ./lazygit.nix
    ./ripgrep.nix
    ./starship.nix
    ./asciinema.nix
    ./nix-index.nix
    ./difftastic.nix
  ];

  home.packages = with pkgs; [
    duf
    wget
    ffmpeg
    workspace
    mole-cleaner
  ];

  home.stateVersion = "24.11";
  programs.home-manager.enable = true;
}
