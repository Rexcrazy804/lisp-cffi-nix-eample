(load (sb-ext:posix-getenv "ASDF"))
(asdf:load-asd (truename "audio.asd"))
(asdf:load-system :audio)
