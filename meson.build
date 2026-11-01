project(
  'simple-lib',
  'c',
  meson_version : '>= 1.3.0',
  version : '0.1',
  default_options : [
    'warning_level=3',
    'c_std=c23',
  ],
)

add_project_arguments(
  '-Wconversion',
  '-Wno-cpp',
  language: 'c',
)

dependencies = [ ]

lib_sources = [
  'src-c/lib.c',
]

library (
  'adder',
  lib_sources,
  dependencies : dependencies,
  install : true,
)

install_headers( 'src-c/lib.h' )
