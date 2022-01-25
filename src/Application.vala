namespace LibreInventory {
    public class Application : Gtk.Application {
        public LibreInventory.Window window;

        public Application() {
            Object (
                application_id: "com.github.librepos.libreinventory",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {
            window = new LibreInventory.Window (this);
        }
    }
}