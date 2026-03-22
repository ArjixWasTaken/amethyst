{ pkgs, stdenv, lib, amethyst, amber-lang

  # Name of the project
, pname ? ""

  # Version of the project
, version ? ""

  # Name of the resulting package
, name ? if (version == "") then pname else "${pname}-${version}"

  # Path to the project source code.
, src

  # Commands that are needed to build the app
, nativeBuildInputs ? []

  # Commands that will be needed to run the app
, propagatedBuildInputs ? []

  # Result hash for vendored Amethyst dependencies.
  # Don't know what to put in here? Leave it empty and Nix will give you the
  # correct hash.
, vendorHash

, passthru ? {}
, ... }@as:

let
  vendor = import ./vendor.nix { inherit pkgs stdenv amethyst amber-lang name src vendorHash; };
in
stdenv.mkDerivation {
  inherit pname name version src propagatedBuildInputs;

  nativeBuildInputs = [
    amethyst
    amber-lang
  ] ++ nativeBuildInputs;

  configurePhase = ''
    ln -s ${vendor}/vendor vendor
    ln -s ${vendor}/amethyst_modules amethyst_modules

    # oh my god this is so ugly don't look
    export project_name=$(git config -f amethyst.ini --get project.name)
  '';

  buildPhase = ''
    HOME=/tmp amethyst build
  '';

  installPhase = ''
    install -Dm755 target/$project_name.sh $out/bin/$project_name
  '';

  passthru = { inherit vendor; } // passthru;
}
