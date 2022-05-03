public class LibreInventory.Settings.Database.ConfigGrid : Gtk.Grid {
  public string target;
  public Gtk.Box engine_selector;
  public Gtk.CheckButton sqlite_check_button;
  public Gtk.CheckButton mysql_check_button;
  public Gtk.CheckButton postgresql_check_button;
  public Gtk.Entry path_entry;
  public Gtk.Entry host_entry;
  public Gtk.Entry port_entry;
  public Gtk.Entry user_entry;
  public Gtk.Entry password_entry;
  public Gtk.Entry database_name_entry;

  public ConfigGrid (string tgt) {
    target = tgt;
    set_margin_top (12);
    set_margin_start (12);
    set_margin_end (12);
    set_margin_bottom (12);
    set_column_homogeneous (true);
    set_column_spacing (12);
    set_row_spacing (12);

    engine_selector = new Gtk.Box (Gtk.Orientation.HORIZONTAL, 12) {
      homogeneous = true,
    };
    engine_selector.append (new Gtk.Label ("Engine:"));

    sqlite_check_button = new Gtk.CheckButton.with_label ("SQLite3");
    sqlite_check_button.toggled.connect (() => {
      disable_sqlite_fields ();
    });
    mysql_check_button = new Gtk.CheckButton.with_label ("MySQL");
    mysql_check_button.toggled.connect (() => {
      disable_sqlite_fields ();
    });
    postgresql_check_button = new Gtk.CheckButton.with_label ("PostgreSQL");
    postgresql_check_button.toggled.connect (() => {
      disable_sqlite_fields ();
    });

    sqlite_check_button.set_group (mysql_check_button);
    postgresql_check_button.set_group (mysql_check_button);

    engine_selector.append (sqlite_check_button);
    engine_selector.append (mysql_check_button);
    engine_selector.append (postgresql_check_button);

    path_entry = new Gtk.Entry ();
    host_entry = new Gtk.Entry ();
    port_entry = new Gtk.Entry ();
    user_entry = new Gtk.Entry ();
    password_entry = new Gtk.Entry () {
      visibility = false,
      invisible_char = '*',
    };
    database_name_entry = new Gtk.Entry () {
      sensitive = false,
      text = "free_business_%s_data".printf(target),
    };

    if (target == "primary") {
      attach (new Gtk.Label ("Primary Database"), 1, 1, 4);
    } else {
      attach (new Gtk.Label ("Secondary Database"), 1, 1, 4);
    }

    attach (engine_selector, 1, 2, 4);
    attach (new Gtk.Label ("Database Path"), 1, 3);
    attach (path_entry, 2, 3, 3);
    attach (new Gtk.Label ("Host"), 1, 4);
    attach (host_entry, 2, 4, 3);
    attach (new Gtk.Label ("Port"), 1, 5);
    attach (port_entry, 2, 5, 3);
    attach (new Gtk.Label ("User"), 1, 6);
    attach (user_entry, 2, 6, 3);
    attach (new Gtk.Label ("Password"), 1, 7);
    attach (password_entry, 2, 7, 3);
    attach (new Gtk.Label ("Database Name"), 1, 8);
    attach (database_name_entry, 2, 8, 3);
  }

  public void disable_sqlite_fields () {
    if (sqlite_check_button.get_active ()) {
      path_entry.set_sensitive (true);

      host_entry.set_sensitive (false);
      port_entry.set_sensitive (false);
      user_entry.set_sensitive (false);
      password_entry.set_sensitive (false);
      // database_name_entry.set_sensitive (false);
    } else {
      path_entry.set_sensitive (false);

      host_entry.set_sensitive (true);
      port_entry.set_sensitive (true);
      user_entry.set_sensitive (true);
      password_entry.set_sensitive (true);
      // database_name_entry.set_sensitive (true);
    }
  }

  public bool save_database_info () {
    return true;
  }
}
