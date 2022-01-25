namespace LibreInventory {
    public class DashboardPage : Gtk.Grid {
        public Gtk.Label title_label;

        public DashboardPage () {
            title_label = new Gtk.Label ("<b>Dashboard</b>") {
                use_markup = true
            };

            attach (title_label, 1, 1, 12, 1);
            set_border_width (12);
        }
    }
}