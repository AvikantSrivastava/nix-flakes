{
  description = "Reusable Go development environment";

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
            go       # Go compiler & toolchain
            gopls    # Go language server
            delve    # Debugger
            gotools  # Misc. Go tools
          ];

          shellHook = ''
            export GOPATH=$HOME/go
            export PATH=$GOPATH/bin:$PATH
            echo "✅ Go dev shell active (Go ${pkgs.go.version})"
          '';
        };
      });
}

