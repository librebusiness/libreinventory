namespace LibreInventory {
    public class ProductsPage : Gtk.Grid {
        public Gtk.Label title_label;
        public Gtk.SearchEntry search_entry;
        public Gtk.TreeView tree_view;

        public ProductsPage () {
            set_border_width (12);

            title_label = new Gtk.Label ("<b>Products</b>") {
                use_markup = true
            };

            attach (title_label, 1, 1, 4, 1);
            column_homogeneous = true;
            column_spacing = 6;
            row_spacing = 6;

            search_entry = new Gtk.SearchEntry ();
            attach (search_entry, 1, 2, 4, 1);

            tree_view = new Gtk.TreeView () {
                vexpand = true
            };
            attach (tree_view, 1, 3, 4, 1);

            var button = new Gtk.Button.with_label ("Delete Product");
            attach (button, 1, 4, 1, 1);

            button = new Gtk.Button.with_label ("Edit Product");
            attach (button, 2, 4, 1, 1);

            button = new Gtk.Button.with_label ("Show Product Details");
            attach (button, 3, 4, 1, 1);

            button = new Gtk.Button.with_label ("Create a Product");
            attach (button, 4, 4, 1, 1);
        }
    }
}