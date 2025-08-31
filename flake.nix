{
  description = "Top-level flake aggregating sub-flakes";

  inputs.go.url = "https://avikant.com/nix-flakes/go";
  inputs.python.url = "https://avikant.com/nix-flakes/python";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils, go, python }: 
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
    in {
      devShells.python = python.devShells.${system};
      devShells.go     = go.devShells.${system};
    });
}

