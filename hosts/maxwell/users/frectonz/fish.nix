{
  programs.fish = {
    enable = true;
    shellAliases = {
      ls = "lsd --group-directories-first -al";
      cp = "cp -i";
      mv = "mv -i";
      rm = "rm -i";
      cat = "bat";
      df = "duf";
      work = "cd $(workspace)";
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
      rebuild = "sudo darwin-rebuild switch --flake .";
    };
    functions = {
      fish_greeting = "";
    };
  };
}
