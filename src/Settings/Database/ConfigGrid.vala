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
  public Gtk.Button test_button;
  public Gtk.Button save_button;
  public GLib.Settings settings;
  LibreInventory.SecretManagement.DatabaseData database_data;
  public signal void stored_password (bool res);

  public ConfigGrid (string tgt) {
    target = tgt;
    database_data = new LibreInventory.SecretManagement.DatabaseData (target, target == "primary" ? 1 : 2);
    set_margin_top (12);
    set_margin_start (12);
    set_margin_end (12);
    set_margin_bottom (12);
    set_column_homogeneous (true);
    set_column_spacing (12);
    set_row_spacing (12);

    settings = new GLib.Settings ("com.otonielreyes.LibreInventory");

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

    test_button = new Gtk.Button.with_label ("Test Connection");
    save_button = new Gtk.Button.with_label ("Save");

    test_button.clicked.connect (() => { test_database_connection(); });
    save_button.clicked.connect (() => { save_database_info(); });

    if (target == "primary") {
      attach (new Gtk.Label ("Primary Database"), 1, 1, 4);
    } else {
      attach (new Gtk.Label ("Secondary Database"), 1, 1, 4);
    }

    attach (engine_selector, 1, 2, 4);
    attach (new Gtk.Label ("Database Path:") { halign = Gtk.Align.END }, 1, 3);
    attach (path_entry, 2, 3, 3);
    attach (new Gtk.Label ("Host:") { halign = Gtk.Align.END }, 1, 4);
    attach (host_entry, 2, 4, 3);
    attach (new Gtk.Label ("Port:") { halign = Gtk.Align.END }, 1, 5);
    attach (port_entry, 2, 5, 3);
    attach (new Gtk.Label ("User:") { halign = Gtk.Align.END }, 1, 6);
    attach (user_entry, 2, 6, 3);
    attach (new Gtk.Label ("Password:") { halign = Gtk.Align.END }, 1, 7);
    attach (password_entry, 2, 7, 3);
    attach (new Gtk.Label ("Database Name:") { halign = Gtk.Align.END }, 1, 8);
    attach (database_name_entry, 2, 8, 3);
    attach (test_button, 3, 9);
    attach (save_button, 4, 9);

    load_stored_data ();
  }

  public void load_stored_data () {
    string fields_prefix = target == "primary" ? "primary-database-%s" : "secondary-database-%s";
    string engine = settings.get_string (fields_prefix.printf ("engine"));
    if (engine == "sqlite3") {
      sqlite_check_button.set_active (true);
    } else if (engine == "mysql") {
      mysql_check_button.set_active (true);
      database_data.get_password ();
      database_data.found_password.connect ((psw) => {
        stdout.printf ("Found Password: \"%s\"\n", psw);
        password_entry.set_text (psw);
      });
    } else {
      postgresql_check_button.set_active (true);
      database_data.get_password ();
      database_data.found_password.connect ((psw) => {
        stdout.printf ("Found Password: \"%s\"\n", psw);
        password_entry.set_text (psw);
      });
    }
    path_entry.set_text (settings.get_string (fields_prefix.printf ("path")));
    host_entry.set_text (settings.get_string (fields_prefix.printf ("host")));
    port_entry.set_text (settings.get_string (fields_prefix.printf ("port")));
    user_entry.set_text (settings.get_string (fields_prefix.printf ("user")));
    database_name_entry.set_text (settings.get_string (fields_prefix.printf ("database-name")));
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

  public void save_database_info () {
    string fields_prefix = target == "primary" ? "primary-database-%s" : "secondary-database-%s";
    if (sqlite_check_button.get_active ()) {
      string path = path_entry.get_text ();
      settings.set_string (fields_prefix.printf ("engine"), "sqlite3");
      settings.set_string (fields_prefix.printf ("path"), path);
      string database_name = database_name_entry.get_text ();
      settings.set_string (fields_prefix.printf ("database-name"), database_name);
    } else {
      if (mysql_check_button.get_active ()) {
        settings.set_string (fields_prefix.printf ("engine"), "mysql");
      } else {
        settings.set_string (fields_prefix.printf ("engine"), "postgresql");
      }
      string host = host_entry.get_text ();
      settings.set_string (fields_prefix.printf ("host"), host);
      string port = port_entry.get_text ();
      settings.set_string (fields_prefix.printf ("port"), port);
      string user = user_entry.get_text ();
      settings.set_string (fields_prefix.printf ("user"), user);
      string password = password_entry.get_text ();
      database_data.save_password (password);
      string database_name = database_name_entry.get_text ();
      settings.set_string (fields_prefix.printf ("database-name"), database_name);
    }

    var dialog = new Gtk.Dialog ();
    dialog.set_default_size (300, 0);
    dialog.set_title ("Success");
    dialog.set_modal (true);
    dialog.add_button ("Ok", 1);
    dialog.get_widget_for_response (1).set_margin_start (12);
    dialog.get_widget_for_response (1).set_margin_end (12);
    dialog.get_widget_for_response (1).set_margin_bottom (12);
    dialog.get_content_area ().set_margin_top (12);
    dialog.get_content_area ().set_margin_start (12);
    dialog.get_content_area ().set_margin_end (12);
    dialog.get_content_area ().set_margin_bottom (12);
    dialog.get_content_area ().append (new Gtk.Label ("Successful Save!"));
    dialog.response.connect (() => { dialog.destroy(); });
    dialog.present ();

    settings.set_boolean ("first-launch", false);
  }

  public void test_database_connection () {}
}
