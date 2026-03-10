{ description = "A version manager, and project manager for Amber";

  inputs."nixpkgs".url = github:NixOS/nixpkgs;
  inputs."amber".url = github:amber-lang/amber/0.5.1-alpha;

  inputs."amethyst-bootstrap".url = github:ArjixWasTaken/amethyst/v0.0.1;
  inputs."amethyst-bootstrap".flake = false;

  outputs = { self, nixpkgs, amber, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem
    (system:
    let pkgs = import nixpkgs { inherit system; };
        amber-lang = amber.outputs.packages.${system}.default;

        amethyst-bootstrap = pkgs.stdenv.mkDerivation {
          pname = "amethyst";
          version = "0.0.1";

          src = self.inputs.amethyst-bootstrap;

          nativeBuildInputs = [ amber-lang ];
          propagatedBuildInputs = with pkgs; [ bc ];

          buildPhase = "amber build src/main.ab";
          installPhase = "install -Dm755 src/main.sh $out/bin/amethyst";
        };
    in
    { packages.default = pkgs.callPackage ./default.nix { inherit amber-lang amethyst-bootstrap; };
    });
}
