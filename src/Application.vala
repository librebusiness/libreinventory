namespace LibreInventory {
    public class Application : Gtk.Application {
        public Application() {
            Object (
                application_id: "com.github.librepos.libreinventory",
                flags: ApplicationFlags.FLAGS_NONE
            );
        }

        protected override void activate () {
            var window = new LibreInventory.Window (this);
        }
    }
}