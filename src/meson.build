libreinventory_sources = [
  'main.vala',
  'window.vala',
  'application.vala',

  'SecretManagement/DatabaseData.vala',

  'Settings/Database/Window.vala',
  'Settings/Database/ConfigGrid.vala',
]

libreinventory_deps = [
  dependency('gtk4'),
  dependency('libsecret-1'),
]

gnome = import('gnome')

libreinventory_sources += gnome.compile_resources('libreinventory-resources',
  'libreinventory.gresource.xml',
  c_name: 'libreinventory'
)

executable('libreinventory', libreinventory_sources,
  vala_args: '--target-glib=2.50',  dependencies: libreinventory_deps,
  install: true,
)
