{config, pkgs, lib, ... }:

{
  home.username = "marcus";
  home.homeDirectory = "/home/marcus";



  home.packages = with pkgs; [
  python39
  python311Packages.pip
  tree
  neovim
  lunarvim
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
  programs.starship = {
    enable = true;
 #    custom settings
   settings = {
      add_newline = false;
      aws.disabled = true;
      gcloud.disabled = true;
     line_break.disabled = true;
    };
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    # custom settings
    settings = {
      env.TERM = "xterm-256color";
      font = {
        size = 12;
        draw_bold_text_with_bright_colors = true;
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };


shellAliases = {
      tc = "sensors";
      x = "exit";
      xx = "reset";
      xxxx = "shutdown";
      sn = "sudo nvim";
      nv = "nvim";
      cf = "cd /etc/nixos && sudo hx configuration.nix";
      fl = "cd /etc/nixos && sudo hx flake.nix";
      hm = "cd /etc/nixos && sudo hx home.nix";
      maj = "sudo nix flake update";
      rb = "sudo nixos-rebuild --flake .#MyNix switch";
      c = "clear";
      gs = "git status"; 
      g0 = "sudo git init";
      g1 = "sudo git add .";
      g2 = "sudo git commit -m";
      gc = "git commit -m";
      g3 = "sudo git push -u origin main";
      ga = "git init";
      lv = "lvim";
      gb = "git add .";
      gd = "git push -u origin master";
      xxx = "reboot";
      s = "sudo -s";
      pd = "cd /home/marcus/Programming/Python/Flake_Dev_Env";      
      #pf = "nix flake init -t github:MordragT/nix-templates#python-poetry";
      #pp = "cd ~/Poetry_Python";
      nd ="nix develop";      
      lq = "ls -ha";
      altcheck = "sudo nixos-rebuild test --flake .#MyNix";      
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
