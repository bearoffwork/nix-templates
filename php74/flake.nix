# vi: sw=2 ts=2 et
{
  description = "A basic flake with a shell";

  nixConfig = {
    extra-substituters = [
      "https://fossar.cachix.org"
    ];
    extra-trusted-public-keys = [
      "fossar.cachix.org-1:Zv6FuqIboeHPWQS7ysLCJ7UT7xExb4OE8c4LyGb5AsE="
    ];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    phps.url = "github:fossar/nix-phps";
  };

  outputs = {
    nixpkgs,
    flake-utils,
    phps,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        php = phps.packages.${system}.php74;
      in {
        formatter = nixpkgs.legacyPackages.${system}.alejandra;
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            bashInteractive
            php
            php.packages.composer
          ];
          shellHook = ''
            mkdir -p .bin
            ln -sf ${php}/bin/php .bin/php
            ln -sf ${php.packages.composer}/bin/composer .bin/composer
          '';
        };
      }
    );
}

