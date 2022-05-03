public class LibreInventory.SecretManagement.DatabaseData : Object {
  public Secret.Schema schema;
  public HashTable<string, string> attributes;
  public string database;
  public signal void saved (bool res);
  public signal void found_password (string password);
  public signal void removed (bool res);

  public DatabaseData (string db, int id) {
    schema = new Secret.Schema ("com.otonielreyes.LibreInventory", Secret.SchemaFlags.NONE,
      "database", Secret.SchemaAttributeType.STRING,
      "id", Secret.SchemaAttributeType.INTEGER,
      "status", Secret.SchemaAttributeType.BOOLEAN);

    database = db;
    attributes = new HashTable<string, string> (str_hash, str_equal);

    attributes.insert ("database", database);
    attributes.insert ("id", "%d".printf (id));
    attributes.insert ("status", "true");
  }

  public void get_password () {
    Secret.password_lookupv.begin (schema, attributes, null, (obj, async_res) => {
      try {
        string password = Secret.password_lookup.end (async_res);
        found_password (password);
      } catch (Error err) {
        stdout.printf ("Error while trying to lookup password in default keyring: %s\n", err.message);
        found_password ("");
      }
    });
  }

  public void save_password (string password) {
    string label = database == "primary" ? "Main Free Business Database" : "Backup Free Business Database";

    Secret.password_storev.begin (schema, attributes, Secret.COLLECTION_DEFAULT, label, password, null, (obj, async_res) => {
      try {
        bool res = Secret.password_store.end (async_res);
        saved (res);
      } catch (Error err) {
        stdout.printf ("Error while trying to store password in default keyring: %s\n", err.message);
        saved (false);
      }
    });
  }

  public void remove_password () {
    Secret.password_clearv.begin (schema, attributes, null, (obj, async_res) => {
      try {
	      bool result = Secret.password_clearv.end (async_res);
	      removed (result);
      } catch (Error err) {
        stdout.printf ("Error while trying to remove password in default keyring: %s\n", err.message);
        removed (false);
      }
    });
  }
}
