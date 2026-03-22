{ pkgs, stdenv, amethyst, amber-lang
, src
, name
, vendorHash
}:

stdenv.mkDerivation {
  inherit src;

  name = "${name}-vendor";
  outputHash = vendorHash;
  outputHashAlgo = "sha256";
  outputHashMode = "nar";

  dontPatchShebangs = true;

  phases = [ "unpackPhase" "buildPhase" "installPhase" ];

  nativeBuildInputs = [
    amethyst
    amber-lang
    pkgs.cacert
  ];

  buildPhase = ''
    amethyst install
    rm -rf amethyst_modules/*.git/hooks/
    rm -rf amethyst_modules/*.git/worktrees/*
  '';

  installPhase = ''
    mkdir -p $out
    cp -r amethyst_modules vendor $out/
  '';
}
