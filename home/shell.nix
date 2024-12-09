{ pkgs, config, ... }:
let
  workspace = pkgs.writeShellScriptBin "workspace" ''
    find ~/workspace -maxdepth 1 -type d | ${pkgs.fzf}/bin/fzf
  '';
in {
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "lsd --group-directories-first -al";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      cat = "bat";
      df = "duf";
      work = "workspace";
      nix-shell = "nix-shell --command fish";
    };
    shellAbbrs = {
      lg = "lazygit";
      addall = "git add .";
      branches = "git branch";
      commit = "git commit -m";
      remotes = "git remote";
      clone = "git clone";
      pull = "git pull origin";
      push = "git push origin";
      pushup = "git push -U origin main";
      stat = "git status";

      dev = "nix develop -c fish";
      rebuild = "darwin-rebuild switch --flake ~/darwin.nix/";
    };
    functions = { fish_greeting = ""; };
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.git = {
    enable = true;
    userName = "frectonz";
    userEmail = "fraol0912@gmail.com";
    extraConfig = {
      init.defaultBranch = "main";
      diff.external = "difft";
      user.signing.key = "9CFA458945B7094F";
      commit.gpgSign = true;
      gpg.program = "${config.programs.gpg.package}/bin/gpg2";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    bat
    lsd
    duf
    htop
    btop
    lazygit
    ripgrep
    workspace
    difftastic
  ];
}
