{ config, pkgs, lib,  ... }:

let
 #Installing binaries like this espanso example https://github.com/knl/dotskel/blob/cd81cf92383049f8bb2d719369ce72b78c11b072/home.nix#L40 
  viktor_cli = let
    app = "viktor-cli";
    version = "0.33.1";
    sources = pkgs.fetchurl {
 url = "https://developers.viktor.ai/api/v1/get-cli/?platform=linux&format=binary";
      sha256 = "h4YUi5r7JN6Leey8hE5+F+KnaYI1um/8OAZGJrVse5s=";
    };

  in 
  pkgs.stdenvNoCC.mkDerivation rec {
      pname = "viktor-cli";
      inherit version;

      src = sources;
      phases = ["installPhase"];

      installPhase = ''
      mkdir -p "$out/bin"
      cp $src $out/bin/viktor-cli
      chmod +x $out/bin/viktor-cli
      '';

      meta = {
        description = "Tools for workking with Viktor";
        homepage = "https://viktor.ai";
        };
    };
in 
rec {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "samotron";
  home.homeDirectory = "/home/samotron";
  #imports = [./configs/nix/i3.nix];
  programs.git = {
      enable = true;
      userName = "Sam";
      userEmail = "james.s.rogers23@gmail.com";
      aliases = {
        prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
      };
      extraConfig = {
        color.ui = true;
        init.defaultBranch = "main";
        push = {
            autoSetupRemote = true;
          };
      };
    };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;
  };
  programs.starship = {
      enable = true;
    };

  programs.bash = {
    enable = true;
    initExtra = builtins.readFile ./configs/bash/.bashrc; 
    shellAliases = {
        ga = "git add .";
        gc = "git commit -m";
        gp = "git push";
        gs = "git status";
        gt = "git tag";
        ls = "ls -a";
        hms = "home-manager switch";
        pg = "ping google.com -c 5";
        usage = "du -ch | grep total";
      };
    profileExtra = builtins.readFile ./configs/bash/bash_profile;
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.11"; # Please read the comment before changing.

  xdg.configFile."nvim".source = ./configs/nvim;
  xdg.configFile."tmux".source = ./configs/tmux;
  


  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
    #

# Development tools
    pkgs.bash
    pkgs.tmux
    pkgs.htop
    pkgs.starship
    pkgs.ripgrep
    pkgs.lazygit
    pkgs.fd 
    pkgs.fira-code-nerdfont
    pkgs.tree-sitter
    pkgs.gnumake
    pkgs.gh
    
# Compilers
    pkgs.gcc

# Elixir Stuff
    pkgs.elixir_1_14

# Rust Stuff
    pkgs.rustc
    pkgs.cargo

# Zig Stuff
    pkgs.zig

# Go Stuff
    pkgs.go 
    pkgs.cobra-cli
    pkgs.gopls


# Clojure Stuff
    pkgs.clojure
    pkgs.babashka

# Javascript Stuff
    pkgs.nodejs_21
    pkgs.bun

# Python Stuff
    pkgs.python311
    pkgs.poetry
    viktor_cli



# Things for none WSL 
#
#

  
 
    
    
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. If you don't want to manage your shell through Home
  # Manager then you have to manually source 'hm-session-vars.sh' located at
  # either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/samotron/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
