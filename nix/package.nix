{
  lib,
  sbcl,
  writeText,
  makeWrapper,
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

  nativeLibs = [makeWrapper];

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

    runHook postInstall
  '';
}
