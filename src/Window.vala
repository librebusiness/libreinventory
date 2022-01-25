namespace LibreInventory {
    public class Window : Gtk.ApplicationWindow {
        Gtk.Stack stack;
        Gtk.HeaderBar header_bar;
        Gtk.StackSwitcher stack_switcher;
        LibreInventory.ProductsPage products_page;
        LibreInventory.DashboardPage dashboard_page;

        public Window(Gtk.Application app) {
            Object (
                application: app
            );

            stack = new Gtk.Stack ();

            stack_switcher = new Gtk.StackSwitcher();
            stack_switcher.set_stack (stack);

            setup_stack ();

            header_bar = new Gtk.HeaderBar () {
                show_close_button = true
            };

            header_bar.set_custom_title (stack_switcher);
            set_titlebar (header_bar);

            set_default_size (800, 600);

            show_all ();
        }

        public void setup_stack () {
            dashboard_page = new LibreInventory.DashboardPage ();
            stack.add_titled (dashboard_page, "Dashboard", "Dashboard");

            products_page = new LibreInventory.ProductsPage ();
            stack.add_titled (products_page, "Products", "Products");

            add (stack);
        }
    }
}