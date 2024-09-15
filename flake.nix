{
  description = "nix flake templates";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    templates = {
      home-mini = {
        path = ./home/mini;
      };
    };
  };
}
