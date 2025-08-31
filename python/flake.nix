{
  description = "Reusable Python development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            uv        # Fast Python package manager
            ruff      # Python linter / formatter
            jupyter   # Notebook
          ];

          shellHook = ''
            echo "🐍 Python dev shell ready"
            echo " - uv: $(uv --version)"
            echo " - ruff: $(ruff --version)"
          '';
        };
      });
}

