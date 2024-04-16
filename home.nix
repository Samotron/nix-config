{ config, pkgs, lib, ... }:

let
 #Installing binaries like this espanso example https://github.com/knl/dotskel/blob/cd81cf92383049f8bb2d719369ce72b78c11b072/home.nix#L40 
  viktor_cli = let
    app = "viktor-cli";
    version = "0.33.1";
    sources = pkgs.fetchurl {
 url = "https://developers.viktor.ai/api/v1/get-cli/?platform=linux&format=binary";
      sha256 = "aWvxiZ+vw42xNbiBj/6OwpscRP/AU42VXV3/37k5tCs=";
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
    wslCheck = 
      lib.strings.hasInfix "LGB" (builtins.readFile "/etc/hostname");


in 
rec {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.

  #imports = [./configs/nix/i3.nix];
  programs.git = {
      enable = true;
      includes = [
      {
# personal
          condition = "gitdir:~/Dev/";
          contents.user = {
              email = "james.s.rogers23@gmail.com";
              name = "Sam";
            };
        }
      {
#Work
          condition = "gitdir:~/Projects/";
          contents.user = {
              email = "sam.rogers@atkinsrealis.com";
              name = "Sam Rogers";
            };
        }
      ];
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
	nos = "sudo nixos-rebuild switch --impure --flake /etc/nixos/#samotron-nixos";
        pg = "ping google.com -c 5";
        usage = "du -ch | grep total";
      };
    profileExtra = builtins.readFile ./configs/bash/bash_profile;
  };

  programs.zsh = {
      enable = true;
      initExtra = builtins.readFile ./configs/bash/.zshrc;
    shellAliases = {
        ga = "git add .";
        gc = "git commit -m";
        gp = "git push";
        gs = "git status";
        gt = "git tag";
        ls = "ls -a";
        hms = "home-manager switch";
	nos = "sudo nixos-rebuild switch --impure --flake /etc/nixos/#samotron-nixos";
        pg = "ping google.com -c 5";
        usage = "du -ch | grep total";
        foldersize = "du -h --max-depth=1 | sort -r -h";
        home-manager-gc = "home-manager expire-generations '-1 days'";

      };
      oh-my-zsh = {
          enable = true;
          plugins = ["git"];
          theme = "fino-time";
        };
      history.size = 10000;
      history.path = "${config.xdg.dataHome}/zsh/history";

    };

  programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
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

  home.username = "samotron";
  home.homeDirectory = "/home/samotron/";
  


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
    pkgs.pandoc
    pkgs.zsh
    pkgs.xclip
    pkgs.azure-functions-core-tools
    pkgs.asciinema
    pkgs.asciinema-agg
    pkgs.hledger
    pkgs.neofetch
    pkgs.emacsGcc
    #pkgs.zigpkgs.master
    viktor_cli
    pkgs.zig
    pkgs.openssl

# Elixir Stuff
    pkgs.elixir_1_14
    pkgs.erlang
    pkgs.gleam


    pkgs.bun
    pkgs.go

# Python Stuff
    pkgs.python311
    pkgs.poetry
    pkgs.black
    pkgs.mkdocs
    #viktor_cli # installed from above



# Things for none WSL 
#
#


  
 
    
    
  ] ++ (lib.optionals (!wslCheck) [
  pkgs.qgis
  ]); 

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
