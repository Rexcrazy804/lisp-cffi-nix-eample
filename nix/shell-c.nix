{
  mkShell,
  cmake,
  meson,
  ninja,
  pkg-config,
  clang-tools,
}:
mkShell {
  name = "c-dev";
  packages = [
    cmake
    meson
    ninja
    pkg-config
    clang-tools
  ];
}
