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
      default = pkgsOf.${system}.callPackage ./nix/package.nix {};
    });

    devShells = eachSystem (system: {
      default = pkgsOf.${system}.callPackage ./nix/shell.nix {};
    });
  };
}
