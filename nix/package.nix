{
  sbcl,
  writeText,
  makeWrapper,
}:
sbcl.buildASDFSystem {
  pname = "audio";
  version = "0.1.0";
  src = ../.;

  nativeLibs = [makeWrapper];

  systems = ["audio"];

  buildScript =
    writeText "build.lisp"
    # lisp
    ''
      (in-package :cl-user)
      (load "@asdf@")

      (defun load-systems ()
        (handler-case
            (let ((systems (uiop:getenv "systems")))
              (dolist (s (uiop:split-string systems :separator " "))
                (asdf:load-system s)))
          (error (c)
            (format t "BUILD FAILED: ~A~%" c)
            (uiop:quit 1)))
        (uiop:quit 0))

      (load-systems)

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
