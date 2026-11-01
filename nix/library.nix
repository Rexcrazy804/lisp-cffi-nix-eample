{
  lib,
  stdenv,
  meson,
  ninja,
  pkg-config,
}:
stdenv.mkDerivation (final: let
  inherit (lib.fileset) unions toSource;
in {
  name = "simple-lib";
  src = toSource {
    root = ../.;
    fileset = unions [
      ../src-c
      ../meson.build
    ];
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];
})
