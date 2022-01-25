project('com.github.librepos.libreinventory', 'vala', 'c')

sources = files(
    'src/Main.vala',
    'src/ProductsPage.vala',
    'src/DashboardPage.vala',
    'src/NewProductWindow.vala',
    'src/Window.vala',
    'src/Application.vala',
)

deps = [
    dependency('gtk+-3.0'),
]

executable('LibreInventory', sources, dependencies: deps, install: true)