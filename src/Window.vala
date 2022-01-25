namespace LibreInventory {
    public class Window : Gtk.ApplicationWindow {
        Gtk.Stack stack;
        Gtk.HeaderBar header_bar;
        Gtk.StackSwitcher stack_switcher;
        LibreInventory.DashboardPage dashboard_page;
        LibreInventory.CustomersPage customers_page;
        LibreInventory.ProductsPage products_page;
        LibreInventory.VendorsPage vendors_page;
        //  LibreInventory.OrdersPage orders_page;
        //  LibreInventory.PurchasesPage purchases_page;
        //  LibreInventory.SettingsPage settings_page;

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

            customers_page = new LibreInventory.CustomersPage ();
            stack.add_titled (customers_page, "Customers", "Customers");

            products_page = new LibreInventory.ProductsPage ();
            stack.add_titled (products_page, "Products", "Products");

            vendors_page = new LibreInventory.VendorsPage ();
            stack.add_titled (vendors_page, "Vendors", "Vendors");

            add (stack);
        }
    }
}