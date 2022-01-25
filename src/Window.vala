namespace LibreInventory {
    public class Window : Gtk.Window {
        public Window(Gtk.Application app) {
            set_application (app);

            var label = new Gtk.Label ("Hello World!");
            add (label);

            show_all ();
        }
    }
}