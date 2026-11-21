{
  lib,
  sbcl,
  mkShell,
  xterm,
  c-lib,
  raylib,
}:
mkShell rec {
  name = "lisp-dev";
  packages = [
    xterm # too lazy to bother editing swank
    (sbcl.withPackages (p:
      with p; [
        swank
        cffi
        cffi-libffi
      ]))
  ];

  buildInputs = [
    c-lib 
    raylib
  ];

  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}
