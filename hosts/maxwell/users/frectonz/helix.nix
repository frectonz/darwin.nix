{
  programs.helix = {
    enable = true;
    settings = {
      theme = "ayu_evolve";
      editor = {
        mouse = false;
        line-number = "relative";
        bufferline = "multiple";
        cursor-shape.insert = "bar";

        whitespace.render = {
          space = "all";
          tab = "all";
          newline = "none";
        };

        lsp.display-inlay-hints = true;
        lsp.display-progress-messages = true;
        indent-guides.render = true;
      };
      keys.insert = {
        j = {
          k = "normal_mode";
        };
      };
    };
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };
}
