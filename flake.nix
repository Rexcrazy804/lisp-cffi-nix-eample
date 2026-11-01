{
  description = "A very basic flake";

  inputs.nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

  outputs = {
    self,
    nixpkgs,
  }: let
    inherit (nixpkgs.lib) genAttrs;
    systems = ["x86_64-linux" "aarch64-linux"];
    pkgsOf = nixpkgs.legacyPackages;
    eachSystem = genAttrs systems;
  in {
    packages = eachSystem (system: {
      default = self.packages.${system}.audio;
      audio = pkgsOf.${system}.callPackage ./nix/package.nix {};
      simple-lib = pkgsOf.${system}.callPackage ./nix/library.nix {};
    });

    devShells = eachSystem (system: {
      lisp = pkgsOf.${system}.callPackage ./nix/shell.nix {};
      c = pkgsOf.${system}.callPackage ./nix/shell-c.nix {};
      default = self.devShells.${system}.lisp;
    });
  };
}
