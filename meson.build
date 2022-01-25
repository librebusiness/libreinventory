project('com.github.librepos.libreinventory', 'vala', 'c')

sources = files(
    'src/Main.vala',
    'src/Window.vala',
    'src/Application.vala',
)

deps = [
    dependency('gtk+-3.0'),
]

executable('LibreInventory', sources, dependencies: deps, install: true)