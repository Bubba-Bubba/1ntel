{config, pkgs, lib, ... }:

{
  home.username = "marcus";
  home.homeDirectory = "/home/marcus";

nixpkgs = {
    overlays = [
      (final: prev: {
        vimPlugins = prev.vimPlugins // {
          own-onedark-nvim = prev.vimUtils.buildVimPlugin {
            name = "onedark";
            src = inputs.plugin-onedark;
          };
        };
      })
    ];
  };

  programs.neovim = 
  let
    toLua = str: "lua << EOF\n${str}\nEOF\n";
    toLuaFile = file: "lua << EOF\n${builtins.readFile file}\nEOF\n";
  in
  {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    extraPackages = with pkgs; [
      lua-language-server
      rnix-lsp

      xclip
      wl-clipboard
    ];

    plugins = with pkgs.vimPlugins; [

      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./nvim/plugin/lsp.lua;
      }

      {
        plugin = comment-nvim;
        config = toLua "require(\"Comment\").setup()";
      }

      {
        plugin = gruvbox-nvim;
        config = "colorscheme gruvbox";
      }

      neodev-nvim

      nvim-cmp 
      {
        plugin = nvim-cmp;
        config = toLuaFile ./nvim/plugin/cmp.lua;
      }

      {
        plugin = telescope-nvim;
        config = toLuaFile ./nvim/plugin/telescope.lua;
      }

      telescope-fzf-native-nvim

      cmp_luasnip
      cmp-nvim-lsp

      luasnip
      friendly-snippets


      lualine-nvim
      nvim-web-devicons

      {
        plugin = (nvim-treesitter.withPlugins (p: [
          p.tree-sitter-nix
          p.tree-sitter-vim
          p.tree-sitter-bash
          p.tree-sitter-lua
          p.tree-sitter-python
          p.tree-sitter-json
        ]));
        config = toLuaFile ./nvim/plugin/treesitter.lua;
      }

      vim-nix

      # {
      #   plugin = vimPlugins.own-onedark-nvim;
      #   config = "colorscheme onedark";
      # }
    ];

    extraLuaConfig = ''
      ${builtins.readFile ./nvim/options.lua}
    '';

    # extraLuaConfig = ''
    #   ${builtins.readFile ./nvim/options.lua}
    #   ${builtins.readFile ./nvim/plugin/lsp.lua}
    #   ${builtins.readFile ./nvim/plugin/cmp.lua}
    #   ${builtins.readFile ./nvim/plugin/telescope.lua}
    #   ${builtins.readFile ./nvim/plugin/treesitter.lua}
    #   ${builtins.readFile ./nvim/plugin/other.lua}
    # '';
  };



#programs.nixvim = {
#    enable = true;
#    colorschemes.kanagawa.enable = true;
#    plugins.lightline.enable = true;
    # Configure neovim options...
#    options = {
#      relativenumber = true;
#      incsearch = true;
#      shiftwidth = 3;
#        };

    # ...mappings...
#    maps.normal = {
#      "<C-s>" = ":w<CR>";
#      "<esc>" = { action = ":noh<CR>"; silent = true; };
#    };

    # ... and plugins
#    plugins = {
#      telescope.enable = true;
#      harpoon = {  # Hi Prime :)
#        enable = true;
#        keymaps.addFile = "<leader>a";
#      };
#    };
#  };


  home.packages = with pkgs; [
  python39
  python311Packages.pip
  tree
  nnn
  eza
  ripgrep
  neofetch
  fzf
  dnsutils
  gawk
  nix-output-monitor
  glow
  lsof
  nodejs_20
  go
  hugo
  lsof
  which
 
  ];


programs.bash = {
    enable = true;
    enableCompletion = true;
    bashrcExtra = ''
      export PATH="$PATH:$HOME/bin:$HOME/.local/bin:$HOME/go/bin"
      alias lk="ls -lat"
            '';

# Git config using Home Manager modules
#  note: git remote set-url origin https://USERNAME:TOKEN@github.com/USERNAME/REPOSITORY.git
#  programs.git = {
#    enable = true;
#    userName = "BriefNCounter";
#    userEmail = "marcusdurston@yandex.com";
#  };

# starship - an customizable prompt for any shell
#  programs.starship = {
#    enable = true;
#    # custom settings
#   settings = {
 #     add_newline = false;
 #     aws.disabled = true;
 #     gcloud.disabled = true;
 #    line_break.disabled = true;
  #  };
 # };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
#  programs.alacritty = {
 #   enable = true;
  #  # custom settings
 #   settings = {
  #    env.TERM = "xterm-256color";
   #   font = {
  #      size = 12;
   #     draw_bold_text_with_bright_colors = true;
    #  };
   #   scrolling.multiplier = 5;
    #  selection.save_to_clipboard = true;
#    };
 # };


shellAliases = {
      tc = "sensors";
      x = "exit";
      xx = "reset";
      xxxx = "shutdown";
      sn = "sudo nvim";
 #     nv = "nvim";
      cf = "cd /etc/nixos && sudo hx configuration.nix";
      fl = "cd /etc/nixos && sudo hx flake.nix";
      hm = "cd /etc/nixos && sudo hx home.nix";
      maj = "sudo nix flake update";
      rb = "sudo nixos-rebuild --flake .#My_Nix switch";
      c = "clear";
      gs = "git status"; 
      g0 = "sudo git init";
      g1 = "sudo git add .";
      g2 = "sudo git commit -m";
      gc = "git commit -m";
      g3 = "sudo git push -u origin main";
      ga = "git init";
      gb = "git add .";
      gd = "git push -u origin master";
      xxx = "reboot";
      s = "sudo -s";
      pd = "cd /home/marcus/Programming/Python/Flake_Dev_Env";      
      #pf = "nix flake init -t github:MordragT/nix-templates#python-poetry";
      #pp = "cd ~/Poetry_Python";
      nd ="nix develop";      
      lq = "ls -ha";
      altcheck = "sudo nixos-rebuild test --flake .#My_Nix";      
      check = "sudo nix flake check";
      show = "nix flake show";
      nx = "cd /etc/nixos";
      add = "cd /etc/nixos && sudo git init && sudo git add .";
      man = "man home-configuration.nix";
      gens = "nix profile history --profile /nix/var/nix/profiles/system";
      flup = "sudo nix flake update && rb";
      system = "nix -vv --version";
      spd = "cd /home/marcus/Screenplays/Fade_In/fade_in/usr/bin && fhs";
      sp = "./fadein";
      dhc = "cd /home/marcus/Websites/DHC/data/en";
      dhd = "cd /home/marcus/Websites/DHC";
      dhs = "cd /home/marcus/Websites/DHC && hugo serve";
      dhp = "dhd && ga && gb";
      v = "virtualenv";
      trim25 = "sudo nix profile wipe-history --older-than 25d --profile /nix/var/nix/profiles/system";
      trim12 = "sudo nix profile wipe-history --older-than 12d --profile /nix/var/nix/profiles/system";
      trim8 = "sudo nix profile wipe-history --older-than 8d --profile /nix/var/nix/profiles/system";
      trim4 = "sudo nix profile wipe-history --older-than 4d --profile /nix/var/nix/profiles/system";
      dbug = "sudo nix store gc --debug";
      p ="python";
      
      };
};

  home.stateVersion = "23.05";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
