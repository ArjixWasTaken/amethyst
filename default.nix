{ pkgs, stdenv, amber-lang, amethyst-bootstrap, ... }:

stdenv.mkDerivation {
  name = "amethyst";

  src = ./.;

  buildPhase = ''
    mkdir -p /tmp/.local/share/amethyst/amber
    ln -s ${amber-lang}/bin/amber /tmp/.local/share/amethyst/amber/amber.${amber-lang.version}.bin
    HOME=/tmp amethyst build
  '';

  installPhase = ''
    install -Dm755 target/amethyst.sh $out/bin/amethyst
  '';

  nativeBuildInputs =
    [ amber-lang
      amethyst-bootstrap
    ];

  propagatedBuildInputs = with pkgs;
    [ curl jq python3 git ];
}
