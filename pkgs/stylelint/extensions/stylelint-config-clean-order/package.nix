{ lib, buildNpmPackage, fetchFromGitHub }:
buildNpmPackage rec {
  pname = "stylelint-config-clean-order";
  version = "v5.4.0";

  src = fetchFromGitHub {
    owner = "kutsan";
    repo = pname;
    rev = version;
    hash = "sha256-I8fBJFSS74FyA77IYWfTWlgEVwLMsHekmMOCaJcbH4E=";
  };

  dontNpmBuild = true;
  npmDepsHash = "sha256-b3lxKp+mK3wZUrks3nzcNjW/MNZTS3VH+eyJYsEK2hc=";
  npmFlags = [ "--legacy-peer-deps" ];
}

