{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let pkgs = import nixpkgs { inherit system; };
      in rec {
        formatter = pkgs.nixfmt;

        packages = import ./pkgs { inherit pkgs; };

        devShells.default = pkgs.mkShell {
          packages = (with pkgs; [
            editorconfig-checker
            nixpkgs-fmt
            statix
          ]) ++ (with pkgs.nodePackages; [
            prettier
          ]) ++ [
            (packages.stylelint.withExtensions (p: with p; [
              stylelint-config-standard
              stylelint-config-clean-order
            ]))
          ];
        };
      });
}
