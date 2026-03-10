{ pkgs, stdenv, amber-lang, ... }:

stdenv.mkDerivation {
  name = "amethyst";

  src = ./.;

  buildPhase = ''
    amber build src/main.ab
  '';

  installPhase = ''
    install -Dm755 src/main.sh $out/bin/amethyst
  '';

  nativeBuildInputs = with pkgs;
    [ amber-lang
    ];
}
