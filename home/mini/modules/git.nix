{
  config,
  pkgs,
  ...
}: {
  # Installs git and github cli
  home.packages = with pkgs; [
    git
    gh
  ];

  # Aliases git to g
  # home.shellAliases = {
  #   g = "git";
  # };

  programs.git = {
    # Let home-manager manage git configuration
    enable = true;

    # FIXME update user name and email
    # userName = "user";
    # userEmail = "user@example.com";

    extraConfig = {
      # Opinionated git configuration.
      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      merge.ff = false;
      rerere.enabled = true;
    };

    # Declares aliases
    # aliases = {
    #   sw = "show";
    #   st = "status";
    #   ch = "checkout";
    #   pu = "push";
    #   pl = "pull";
    #   aa = "add -A";
    #   cm = "commit -m";
    #   cam = "commit -am";
    #   caa = "commit -a --amend";
    #   caam = "commit -a --amend -m";
    #   mr = "merge --no-ed";
    #   rst = "reset";
    # };
  };
}
