{
  description = "Minimal Home Manager Configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: let
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {

    # Standalone home-manager configuration entrypoint
    homeConfigurations."{{ username }}" = home-manager.lib.homeManagerConfiguration {
      pkgs = nixpkgs.legacyPackages."{{ system }}";
      modules = [ ./home.nix ];
    };

    # Set formatter so we can format nix files with `nix fmt`
    # https://nix.dev/manual/nix/2.24/command-ref/new-cli/nix3-fmt
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);
  };
}
