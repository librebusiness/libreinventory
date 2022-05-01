public class LibreInventory.Settings.Database.Window : Gtk.ApplicationWindow {
  public Gtk.HeaderBar header_bar;

  public Window (Gtk.Application app) {
    Object(
      application: app
    );

    set_title("Database Settings");
  }
}
