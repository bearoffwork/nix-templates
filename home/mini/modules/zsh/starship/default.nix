{
  config,
  pkgs,
  ...
}: {
  # copy starship.toml to ~/.config/starship.toml
  home.file."${config.xdg.configHome}/starship.toml".source = ./starship.toml;

  programs = {
    # enable starship prompt
    starship.enable = true;

    # This is a basic trainsient prompt implementation for starship,
    # NOT TESTED THROUGHLY, use with caution.
    # zsh = {
    #   initExtra = ''
    #     set-long-prompt() {
    #       PROMPT="$(starship prompt)"
    #       RPROMPT="$(starship prompt --right)"
    #     }
    #     precmd_functions+=(set-long-prompt)
    #
    #     set-short-prompt() {
    #       if [[ $PROMPT != '%# ' ]]; then
    #         PROMPT="$(starship prompt --profile transient)"
    #         RPROMPT=""
    #         zle .reset-prompt 2>/dev/null # hide the errors on ctrl+c
    #       fi
    #     }
    #
    #     zle-line-finish() { set-short-prompt }
    #     zle -N zle-line-finish
    #
    #     trap 'set-short-prompt; return 130' INT
    #   '';
    # };
  };
}
