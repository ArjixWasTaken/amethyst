{ description = "A version manager, and project manager for Amber";

  inputs."nixpkgs".url = "github:NixOS/nixpkgs";
  inputs."amber".url = "github:amber-lang/amber/0.5.1-alpha";

  # TODO: Switch to upstream bootstrap branch once it exists
  inputs."amethyst-bootstrap".url = "github:thesola10/amethyst/bootstrap";
  inputs."amethyst-bootstrap".flake = false;

  outputs = { self, nixpkgs, amber, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem
    (system:
    let pkgs = import nixpkgs
        { inherit system;
          overlays = [ (s: super: {
            amber-lang = amber.outputs.packages.${system}.default;

            amethyst-bootstrap = s.stdenv.mkDerivation {
              pname = "amethyst";
              version = "0.0.1";

              src = self.inputs.amethyst-bootstrap;

              nativeBuildInputs = [ s.amber-lang ];
              propagatedBuildInputs = [ s.bc s.curl s.jq s.python3 s.git ];

              buildPhase = "amber build src/main.ab";
              installPhase = "install -Dm755 src/main.sh $out/bin/amethyst";
            };

            amethyst = s.callPackage ./default.nix {};
          }) ];
        };
    in
    { packages.default = pkgs.amethyst;

      checks.selfBootstrap = pkgs.amethyst.buildAmethystApplication {
        src = ./.;
        pname = "amethyst";
        vendorHash = "sha256-/A6lintzCKLvNOs55Up091Tu5xJJWTVN/B5wSwgmOyc=";
      };
    });
}
