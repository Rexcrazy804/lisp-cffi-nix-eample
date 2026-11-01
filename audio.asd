(defsystem "audio"
  :description "a simple application to play audio"
  :version "0.1.0"
  :author "Rexiel Scarlet"
  :license "Unlicense"
  :depends-on (:cffi)
  :components 
  ((:module "src"
            :serial T
            :components 
            ((:file "main")))))
