{ pkgs, ... }: {
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
        indent-guides.render = true;
      };
      keys.insert = {
        j = { k = "normal_mode"; }; # Maps `jk` to exit insert mode
      };
    };
  };

  programs.nixvim = {
    enable = true;
    vimAlias = true;

    opts = {
      backup = false;
      clipboard = "unnamedplus";
      completeopt = [ "menuone" "noselect" ];
      conceallevel = 0;
      fileencoding = "utf-8";
      hlsearch = true;
      ignorecase = true;
      mouse = "a";
      pumheight = 10;
      showmode = false;
      showtabline = 2;
      smartcase = true;
      smartindent = true;
      splitbelow = true;
      splitright = true;
      swapfile = false;
      termguicolors = true;
      timeoutlen = 1000;
      undofile = true;
      updatetime = 300;
      writebackup = false;
      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      cursorline = true;
      number = true;
      relativenumber = true;
      numberwidth = 4;
      signcolumn = "yes";
      wrap = true;
      scrolloff = 8;
      sidescrolloff = 8;
    };

    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    keymaps = let
      options = {
        noremap = true;
        silent = true;
      };
    in [
      {
        inherit options;
        key = "<C-h>";
        action = "<C-w>h";
        mode = "n";
      }
      {
        inherit options;
        key = "<C-j>";
        action = "<C-w>j";
        mode = "n";
      }
      {
        inherit options;
        key = "<C-k>";
        action = "<C-w>k";
        mode = "n";
      }
      {
        inherit options;
        key = "<C-l>";
        action = "<C-w>l";
        mode = "n";
      }
      {
        inherit options;
        key = "<C-Up>";
        action = ":resize -2<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "<C-Down>";
        action = ":resize +2<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "<C-Left>";
        action = ":vertical resize -2<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "<C-Right>";
        action = ":vertical resize +2<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "<S-l>";
        action = ":bnext<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "<S-h>";
        action = ":bprevious<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "<A-j>";
        action = "<Esc>:m .+1<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "<A-k>";
        action = "<Esc>:m .-2<CR>";
        mode = "n";
      }
      {
        inherit options;
        key = "jk";
        action = "<ESC>";
        mode = "i";
      }
      {
        inherit options;
        key = "<";
        action = "<gv";
        mode = "v";
      }
      {
        inherit options;
        key = ">";
        action = ">gv";
        mode = "v";
      }
      {
        inherit options;
        key = "<A-j>";
        action = ":m .+1<CR>==";
        mode = "v";
      }
      {
        inherit options;
        key = "<A-k>";
        action = ":m .-2<CR>==";
        mode = "v";
      }
      {
        inherit options;
        key = "<A-k>";
        action = ":move '<-2<CR>gv-gv";
        mode = "x";
      }
      {
        inherit options;
        key = "<A-j>";
        action = ":move '>+1<CR>gv-gv";
        mode = "x";
      }
      {
        inherit options;
        key = "<leader>e";
        action = ":Explore<cr>";
        mode = "n";
      }
      {
        inherit options;
        key = "<Up>";
        action = "";
        mode = "";
      }
      {
        inherit options;
        key = "<Down>";
        action = "";
        mode = "";
      }
      {
        inherit options;
        key = "<Left>";
        action = "";
        mode = "";
      }
      {
        inherit options;
        key = "<Right>";
        action = "";
        mode = "";
      }
      {
        inherit options;
        key = "<leader>s";
        action = ":w<CR>";
        mode = "n";
      }
    ];

    plugins.treesitter = {
      enable = true;
      settings = {
        highlight = {
          enable = true;
          additional_vim_regex_highlighting = true;
        };
        indent = { enable = true; };
        rainbow = {
          enable = true;
          extended_mode = true;
        };
        context_commentstring = {
          enable = true;
          enable_autocmd = false;
        };
      };

      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        nix
        lua
        rust
        commonlisp
        astro
        tsx
        typescript
        javascript
        vimdoc
        css
        svelte
        html
        ocaml
        elm
        ruby
        elixir
        heex
        unison
        roc
        hcl
        terraform
        hurl
        graphql
      ];
    };

    colorschemes.ayu.enable = true;

    plugins.lualine.enable = true;
    plugins.bufferline.enable = true;
    plugins.autoclose.enable = true;

    plugins.web-devicons.enable = true;
    plugins.telescope = {
      enable = true;
      keymaps = {
        "<leader>t" = "live_grep";
        "<leader>f" = "find_files";
      };
    };

    plugins.fidget.enable = true;
    plugins.gitsigns = {
      enable = true;
      settings = {
        signs = {
          add = { text = "│+"; };
          change = { text = "│-"; };
          delete = { text = "_"; };
          topdelete = { text = "‾"; };
          changedelete = { text = "~"; };
          untracked = { text = "┆"; };
        };
        attach_to_untracked = true;
        current_line_blame = true;
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
      settings.sources =
        [ { name = "nvim_lsp"; } { name = "path"; } { name = "buffer"; } ];
      settings.mapping = {
        "<C-Space>" = "cmp.mapping.complete()";
        "<C-d>" = "cmp.mapping.scroll_docs(-4)";
        "<C-e>" = "cmp.mapping.close()";
        "<C-f>" = "cmp.mapping.scroll_docs(4)";
        "<CR>" = "cmp.mapping.confirm({ select = true })";
        "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
        "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      };

      filetype = { gitcommit = { sources = [{ name = "git"; }]; }; };

      cmdline = {
        "/" = { sources = [{ name = "buffer"; }]; };
        ":" = {
          sources = [
            { name = "path"; }
            {
              name = "cmdline";
              option = { ignore_cmds = [ "Man" "!" ]; };
            }
          ];
        };
      };
    };

    plugins.lsp = {
      enable = true;
      inlayHints = true;
      keymaps.lspBuf = {
        K = "hover";
        gD = "references";
        gd = "definition";
        gi = "implementation";
        gt = "type_definition";
      };

      servers.nixd.enable = true;
      servers.rust_analyzer = {
        enable = true;
        installCargo = true;
        installRustc = true;
        installRustfmt = true;
      };
      servers.svelte.enable = true;
      servers.elmls.enable = true;
      servers.astro.enable = true;
      servers.tailwindcss.enable = true;
      servers.emmet_ls.enable = true;
      servers.cssls.enable = true;
      servers.typst_lsp.enable = true;
      servers.solargraph.enable = true;
      servers.elixirls.enable = true;
    };
  };

  programs.neovide = {
    enable = true;
    settings = {
      fork = true;
      maximized = true;
    };
  };

  home.sessionVariables = { EDITOR = "hx"; };
}
