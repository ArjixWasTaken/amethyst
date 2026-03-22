{ pkgs, stdenv, amber-lang, amethyst-bootstrap, ... }:

pkgs.callPackage ./nix/buildAmethystApplication.nix {
  pname = "amethyst";
  amethyst = amethyst-bootstrap;

  src = ./.;
  vendorHash = "sha256-rTXHj8ub/bEa7H83pdGuR9o7CaHn/0Jcyx4O+MArewU=";

  propagatedBuildInputs = with pkgs;
    [ curl jq python3 git bc ];

  passthru.buildAmethystApplication = pkgs.callPackage ./nix/buildAmethystApplication.nix;
}
