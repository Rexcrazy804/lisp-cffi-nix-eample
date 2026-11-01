{
  lib,
  sbcl,
  writeText,
  makeWrapper,
  simple-lib,
  libffi,
}:
sbcl.buildASDFSystem {
  pname = "audio";
  version = "0.1.0";
  src = let
    inherit (lib.fileset) unions toSource;
  in
    toSource {
      root = ../.;
      fileset = unions [
        ../src
        ../audio.asd
      ];
    };

  lispLibs = with sbcl.pkgs; [
    cffi
    cffi-libffi
  ];

  nativeLibs = [makeWrapper simple-lib libffi];

  systems = ["audio"];

  buildScript =
    writeText "build.lisp"
    # lisp
    ''
      ;; Load ASDF
      (load (concatenate 'string (sb-ext:posix-getenv "asdfFasl") "/asdf.fasl"))
      (defpackage :nix.build-script (:use :cl :asdf))
      (in-package :nix.build-script)

      ;; Load asdf systems
      (initialize-output-translations '(:output-translations :disable-cache :inherit-configuration))
      (mapcar #'load-system (uiop:split-string (sb-ext:posix-getenv "systems")))

      ;; Load project asdf
      (load "audio.asd")
      (asdf:load-system :audio)

      ;; Create executable
      (sb-ext:save-lisp-and-die "audio" :toplevel #'audio::main :executable t)
      (exit)
    '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    install -Dm777 audio $out/bin

    # sometimes nativeLibs isn't sufficient
    # in this case libadder.so from simple-lib doesn't need this
    # but libffi does.
    # life do be funny like this
    wrapProgram $out/bin/audio \
      --prefix LD_LIBRARY_PATH : "$LD_LIBRARY_PATH"

    runHook postInstall
  '';
}
