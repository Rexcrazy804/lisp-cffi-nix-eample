{
  sbcl,
  mkShell,
  xterm,
}:
mkShell {
  name = "lisp-dev";
  packages = [
    xterm # too lazy to bother editing swank
    (sbcl.withPackages (p:
      with p; [
        swank
        harmony
      ]))
  ];
}
