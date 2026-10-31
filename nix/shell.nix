{
  lib,
  sbcl,
  mkShellNoCC,
  xterm,
  curl,
  pkg-config,
}:
mkShellNoCC rec {
  name = "lisp-dev";
  packages = [
    xterm # too lazy to bother editing swank
    (sbcl.withPackages (p:
      with p; [
        swank
        harmony
        cffi
      ]))
  ];

  buildInputs = [
    curl
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}
