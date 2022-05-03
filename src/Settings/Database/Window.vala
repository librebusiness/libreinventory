public class LibreInventory.Settings.Database.Window : Gtk.ApplicationWindow {
  public Gtk.HeaderBar header_bar;
  public Gtk.Button save_button;
  public Gtk.Stack database_stack;
  public Gtk.StackSwitcher database_switcher;
  public Gtk.Grid primary_database_grid;
  public Gtk.Grid secondary_database_grid;

  public Window (Gtk.Application app) {
    Object(
      application: app
    );

    /* Database Stack Switch */
    database_stack = new Gtk.Stack ();
    database_switcher = new Gtk.StackSwitcher () {
        stack = database_stack,
    };

    primary_database_grid = new ConfigGrid ("primary");
    secondary_database_grid = new ConfigGrid ("secondary");

    database_stack.add_titled (primary_database_grid, "primary-database", "Main Database");
    database_stack.add_titled (secondary_database_grid, "primary-database", "Backup Database");

    header_bar = new Gtk.HeaderBar() {
        show_title_buttons = true,
        title_widget = database_switcher,
    };

    save_button = new Gtk.Button.with_label ("Save");
    header_bar.pack_start (save_button);

    set_default_size (600, 400);
    set_titlebar (header_bar);
    set_child (database_stack);
  }
}
