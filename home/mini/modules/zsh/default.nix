{
  config,
  pkgs,
  ...
}: {
  imports = [
    # # Choose one of the following prompts.
    # # Uncomment following line to enable powerlevel10k prompt.
    # ./powerlevel10k
    # # Uncomment following line to enable starship prompt.
    # ./starship
  ];

  home.packages = with pkgs; [
    # some basic packages
    # https://github.com/zsh-users/zsh-completions
    zsh-completions
    # https://github.com/zsh-users/zsh-autosuggestions
    zsh-autosuggestions
    # https://github.com/zsh-users/zsh-syntax-highlighting
    zsh-syntax-highlighting

    # replace default tab menu with fzf
    # https://github.com/Aloxaf/fzf-tab
    zsh-fzf-tab

    # A smarter cd command, like z and autojump.
    # https://github.com/ajeetdsouza/zoxide
    zoxide
    
    # fuzzy finder
    # https://github.com/junegunn/fzf
    fzf

    # ls but prettier, with tree support.
    # https://github.com/eza-community/eza
    #
    # here's the default aliases:
    # alias -- la='eza -a'
    # alias -- ll='eza -l'
    # alias -- lla='eza -la'
    # alias -- ls=eza
    # alias -- lt='eza --tree'
    #
    eza
  ];

  programs = {
    zsh = {
      # Let Home Manager manage zsh environment, it will generate `.zshrc` and `.zshenv` for you.
      enable = true;

      # set default keymap to emacs
      defaultKeymap = "emacs";

      # Alternative ZDOTDIR
      dotDir = ".config/zsh";

      # Enable zsh-completions
      enableCompletion = true;
      # Enable zsh-autosuggestions
      autosuggestion.enable = true;
      # Enable zsh-syntax-highlighting
      syntaxHighlighting.enable = true;
      
      # history substring search, type `cd` and press up arrow to search history with `cd` in it.
      # https://github.com/zsh-users/zsh-history-substring-search
      historySubstringSearch.enable = true;

      # Store history file to xdg data directory for keeping home directory clean.
      history = {
        path = "${config.xdg.dataHome}/zsh/zsh_history";
      };

      # prompt at bottom
      # `initExtraFirst` will be added to the top of `.zshrc`
      initExtraFirst = ''
        # prompt at bottom
        tput cup $(tput lines)
      '';

      # Extra commands that should be added to `.zshrc`.
      initExtra = ''
        # source fzf-tab plugin
        '.' '${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh'

        # use ctrl + arrow keys to move between words
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      options = ["--cmd cd"];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    eza = {
      # see here for more options:
      # https://mynixos.com/home-manager/options/programs.eza
      enable = true;
      enableZshIntegration = true;
      git = true;

      # If you don't like icons, delete this line.
      icons = true;
    };
  };
}
