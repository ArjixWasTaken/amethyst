{ description = "A version manager, and project manager for Amber";

  inputs."nixpkgs".url = github:NixOS/nixpkgs;
  inputs."amber".url = github:amber-lang/amber/0.5.1-alpha;

  outputs = { self, nixpkgs, amber, flake-utils, ... }:
  flake-utils.lib.eachDefaultSystem
    (system:
    let pkgs = import nixpkgs { inherit system; };
        amber-lang = amber.outputs.packages.${system}.default;
    in
    { packages.default = pkgs.callPackage ./default.nix { inherit amber-lang; };
    });
}
