{
  config,
  pkgs,
  ...
}: {
  # Enable direnv and bash, copied from
  # https://github.com/nix-community/nix-direnv?tab=readme-ov-file#via-home-manager
  programs = {
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    bash.enable = true;
  };
}
