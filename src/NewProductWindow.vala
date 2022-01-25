namespace LibreInventory {
    public class NewProductWindow : Gtk.Window {
        public Gtk.Box box;
        public Gtk.Entry name_entry;
        public Gtk.Entry description_entry;
        public Gtk.Entry sku_entry;
        public Gtk.Entry upc_entry;
        public Gtk.Entry price_entry;
        public Gtk.Entry units_left_entry;
        public Gtk.HeaderBar header_bar;
        Gtk.Button cancel_button;
        Gtk.Button create_button;

        public NewProductWindow () {
            box = new Gtk.Box (Gtk.Orientation.VERTICAL, 8);

            name_entry = new Gtk.Entry () {
                placeholder_text = "Product Name"
            };
            box.pack_start (name_entry, false, false, 2);

            description_entry = new Gtk.Entry () {
                placeholder_text = "Description"
            };
            box.pack_start (description_entry, false, false, 2);

            sku_entry = new Gtk.Entry () {
                placeholder_text = "SKU"
            };
            box.pack_start (sku_entry, false, false, 2);

            upc_entry = new Gtk.Entry () {
                placeholder_text = "UPC"
            };
            box.pack_start (upc_entry, false, false, 2);

            price_entry = new Gtk.Entry () {
                placeholder_text = "Price"
            };
            box.pack_start (price_entry, false, false, 2);

            units_left_entry = new Gtk.Entry () {
                placeholder_text = "Units Left"
            };
            box.pack_start (units_left_entry, false, false, 2);

            header_bar = new Gtk.HeaderBar () {
                title = "LibreInventory",
                subtitle = "New Product"
            };

            cancel_button = new Gtk.Button.with_label ("Cancel");
            cancel_button.clicked.connect (() => {
                destroy ();
            });
            header_bar.pack_start (cancel_button);

            create_button = new Gtk.Button.with_label ("Create");
            header_bar.pack_end (create_button);

            add (box);

            set_titlebar (header_bar);
            set_border_width (12);
            show_all ();
        }
    }
}