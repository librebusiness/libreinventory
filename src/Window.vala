namespace LibreInventory {
    public class Window : Gtk.ApplicationWindow {
        Gtk.HeaderBar header_bar;

        public Window(Gtk.Application app) {
            Object (
                application: app
            );

            var label = new Gtk.Label ("Hello World!");
            add (label);
            header_bar = new Gtk.HeaderBar () {
                title = "LibreInventory",
                subtitle = "Free inventory management system",
                show_close_button = true
            };
            set_titlebar (header_bar);

            set_default_size (800, 600);

            show_all ();
        }
    }
}