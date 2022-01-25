namespace LibreInventory {
    public class ProductsPage : Gtk.Grid {
        public Gtk.Label title_label;
        public ProductsPage () {
            title_label = new Gtk.Label ("<b>Products</b>") {
                use_markup = true
            };

            attach (title_label, 1, 1, 12, 1);
            set_border_width (12);
        }
    }
}