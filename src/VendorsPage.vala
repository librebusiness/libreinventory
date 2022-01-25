namespace LibreInventory {
    public class VendorsPage : Gtk.Grid {
        public Gtk.Label title_label;

        public VendorsPage () {
            title_label = new Gtk.Label ("<b>Vendors</b>") {
                use_markup = true
            };

            attach (title_label, 1, 1, 12, 1);
            set_border_width (12);
        }
    }
}