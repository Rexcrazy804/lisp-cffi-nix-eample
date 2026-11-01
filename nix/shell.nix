{
  lib,
  sbcl,
  mkShell,
  xterm,
  c-lib,
}:
mkShell rec {
  name = "lisp-dev";
  packages = [
    xterm # too lazy to bother editing swank
    (sbcl.withPackages (p:
      with p; [
        swank
        cffi
      ]))
  ];

  buildInputs = [c-lib];

  LD_LIBRARY_PATH = lib.makeLibraryPath buildInputs;
}
