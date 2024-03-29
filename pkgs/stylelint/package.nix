{ lib, pkgs, writeShellScriptBin, makeWrapper, buildNpmPackage, fetchFromGitHub }:
let
  env = f: writeShellScriptBin "stylelint" ''
    export NODE_PATH="$NODE_PATH:${
      lib.makeSearchPath "lib/node_modules"
      ([ stylelint ] ++ (f stylelint.extensions))}"

    exec ${stylelint}/bin/stylelint "$@"
  '';

  stylelint = buildNpmPackage rec {
    pname = "stylelint";
    version = "16.1.0";

    src = fetchFromGitHub {
      owner = "stylelint";
      repo = pname;
      rev = version;
      hash = "sha256-r6FSPMOvx0SI8u2qqk/ALmlSMCcCb3JlAHEawdGoERw=";
    };

    npmDepsHash = "sha256-SHZ7nB4//8IAc8ApmmHbeWi954Za6Ryv+bYuHnZ3Ef0=";

    passthru = {
      extensions = import ./extensions { inherit pkgs; };
      withExtensions = env;
    };
  };
in stylelint
