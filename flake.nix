{
  description = "Top-level flake";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  inputs.flake-utils.url = "github:numtide/flake-utils";

  # Use local path inputs for sub-flakes
  inputs.go = { url = "path:./go"; };
  inputs.python = { url = "path:./python"; };

  outputs = { self, nixpkgs, flake-utils, go, python }:
    flake-utils.lib.eachDefaultSystem (system:
      {
        devShells.python = python.devShells.${system};
        devShells.go     = go.devShells.${system};
      });
}

