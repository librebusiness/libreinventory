namespace LibreInventory {
    public class CustomersPage : Gtk.Grid {
        public Gtk.Label title_label;

        public CustomersPage () {
            title_label = new Gtk.Label ("<b>Customers</b>") {
                use_markup = true
            };

            attach (title_label, 1, 1, 12, 1);
            set_border_width (12);
        }
    }
}