package models;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminServlet", urlPatterns = {"/admin/*"})
public class AdminServlet extends HttpServlet {
    private AdminFileManager fileManager;
    private PropertyFileManager propertyFileManager;
    private UserFileManager userFileManager;

    @Override
    public void init() throws ServletException {
        fileManager = new AdminFileManager();
        propertyFileManager = new PropertyFileManager();
        userFileManager = new UserFileManager();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo() != null ? req.getPathInfo() : "/dashboard";
        try {
            if (path.equals("/dashboard")) {
                List<AdminUser> admins = fileManager.getAllAdmins();
                req.setAttribute("admins", admins);
                req.getRequestDispatcher("/WEB-INF/admin-dashboard.jsp").forward(req, resp);
            } else if (path.equals("/add")) {
                req.getRequestDispatcher("/WEB-INF/admin-add.jsp").forward(req, resp);
            } else if (path.startsWith("/update")) {
                String id = req.getParameter("id");
                AdminUser admin = fileManager.findAdmin(id);
                req.setAttribute("admin", admin);
                req.getRequestDispatcher("/WEB-INF/admin-update.jsp").forward(req, resp);
            } else if (path.equals("/search")) {
                String searchTerm = req.getParameter("searchTerm");
                AdminUser admin = fileManager.findAdmin(searchTerm);
                req.setAttribute("admin", admin);
                req.getRequestDispatcher("/WEB-INF/admin-search.jsp").forward(req, resp);
            } else if (path.equals("/activity-logs")) {
                List<AdminFileManager.LogEntry> logs = fileManager.getAllLogs();
                req.setAttribute("logs", logs);
                req.getRequestDispatcher("/WEB-INF/activity-logs.jsp").forward(req, resp);
            } else if (path.equals("/manage-properties")) {
                List<Property> properties = propertyFileManager.getAllProperties();
                req.setAttribute("properties", properties);
                req.getRequestDispatcher("/WEB-INF/manage-properties.jsp").forward(req, resp);
            } else if (path.startsWith("/property/edit")) {
                String id = req.getParameter("id");
                List<Property> properties = propertyFileManager.getAllProperties();
                Property property = properties.stream().filter(p -> p.getId().equals(id)).findFirst().orElse(null);
                req.setAttribute("property", property);
                req.getRequestDispatcher("/WEB-INF/property-edit.jsp").forward(req, resp);
            } else if (path.equals("/manage-users")) {
                List<ClientUser> users = userFileManager.getAllUsers();
                req.setAttribute("users", users);
                req.getRequestDispatcher("/WEB-INF/manage-users.jsp").forward(req, resp);
            } else if (path.startsWith("/user/edit")) {
                String id = req.getParameter("id");
                List<ClientUser> users = userFileManager.getAllUsers();
                ClientUser user = users.stream().filter(u -> u.getId().equals(id)).findFirst().orElse(null);
                req.setAttribute("user", user);
                req.getRequestDispatcher("/WEB-INF/user-edit.jsp").forward(req, resp);
            } else {
                req.setAttribute("error", "Page not found.");
                req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req, resp);
            }
        } catch (IOException e) {
            req.setAttribute("error", "Error: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req, resp);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        try {
            if (path.equals("/add")) {
                String id = req.getParameter("id");
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String privileges = req.getParameter("privileges");
                AdminUser admin = new AdminUser(id, username, password, privileges);
                fileManager.saveAdmin(admin);
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else if (path.equals("/update")) {
                String id = req.getParameter("id");
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String privileges = req.getParameter("privileges");
                AdminUser admin = new AdminUser(id, username, password, privileges);
                fileManager.updateAdmin(admin);
                resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            } else if (path.equals("/delete")) {
                String id = req.getParameter("id");
                if (id != null && !id.isEmpty()) {
                    fileManager.deleteAdmin(id);
                    resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
                } else {
                    req.setAttribute("error", "No admin ID provided for deletion.");
                    req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req, resp);
                }
            } else if (path.equals("/property/approve")) {
                String id = req.getParameter("id");
                List<Property> properties = propertyFileManager.getAllProperties();
                Property property = properties.stream().filter(p -> p.getId().equals(id)).findFirst().orElse(null);
                if (property != null) {
                    String oldStatus = property.getStatus();
                    property.setStatus("approved");
                    propertyFileManager.updateProperty(property);
                    fileManager.logAction("SYSTEM", "Approved property: ID=" + id + ", Status changed from " + oldStatus + " to approved");
                }
                resp.sendRedirect(req.getContextPath() + "/admin/manage-properties");
            } else if (path.equals("/property/edit")) {
                String id = req.getParameter("id");
                String title = req.getParameter("title");
                String description = req.getParameter("description");
                double price = Double.parseDouble(req.getParameter("price"));
                String status = req.getParameter("status");

                List<Property> properties = propertyFileManager.getAllProperties();
                Property oldProperty = properties.stream().filter(p -> p.getId().equals(id)).findFirst().orElse(null);
                if (oldProperty != null) {
                    StringBuilder changes = new StringBuilder("Edited property: ID=" + id);
                    boolean hasChanges = false;
                    if (!oldProperty.getTitle().equals(title)) {
                        changes.append(", Title changed from ").append(oldProperty.getTitle()).append(" to ").append(title);
                        hasChanges = true;
                    }
                    if (!oldProperty.getDescription().equals(description)) {
                        changes.append(hasChanges ? ", " : ", ");
                        changes.append("Description changed from ").append(oldProperty.getDescription()).append(" to ").append(description);
                        hasChanges = true;
                    }
                    if (oldProperty.getPrice() != price) {
                        changes.append(hasChanges ? ", " : ", ");
                        changes.append("Price changed from ").append(oldProperty.getPrice()).append(" to ").append(price);
                        hasChanges = true;
                    }
                    if (!oldProperty.getStatus().equals(status)) {
                        changes.append(hasChanges ? ", " : ", ");
                        changes.append("Status changed from ").append(oldProperty.getStatus()).append(" to ").append(status);
                        hasChanges = true;
                    }

                    Property updatedProperty = new Property(id, title, description, price, status);
                    propertyFileManager.updateProperty(updatedProperty);
                    fileManager.logAction("SYSTEM", hasChanges ? changes.toString() : "Edited property: ID=" + id + " (no changes made)");
                }
                resp.sendRedirect(req.getContextPath() + "/admin/manage-properties");
            } else if (path.equals("/property/delete")) {
                String id = req.getParameter("id");
                propertyFileManager.deleteProperty(id);
                fileManager.logAction("SYSTEM", "Deleted property: ID=" + id);
                resp.sendRedirect(req.getContextPath() + "/admin/manage-properties");
            } else if (path.equals("/user/edit")) {
                String id = req.getParameter("id");
                String username = req.getParameter("username");
                String password = req.getParameter("password");
                String name = req.getParameter("name");
                String contact = req.getParameter("contact");

                List<ClientUser> users = userFileManager.getAllUsers();
                ClientUser oldUser = users.stream().filter(u -> u.getId().equals(id)).findFirst().orElse(null);
                if (oldUser != null) {
                    StringBuilder changes = new StringBuilder("Edited user: ID=" + id);
                    boolean hasChanges = false;
                    if (!oldUser.getUsername().equals(username)) {
                        changes.append(", Username changed from ").append(oldUser.getUsername()).append(" to ").append(username);
                        hasChanges = true;
                    }
                    if (!oldUser.getPassword().equals(password)) {
                        changes.append(hasChanges ? ", " : ", ");
                        changes.append("Password changed from ").append(oldUser.getPassword()).append(" to ").append(password);
                        hasChanges = true;
                    }
                    if (!oldUser.getName().equals(name)) {
                        changes.append(hasChanges ? ", " : ", ");
                        changes.append("Name changed from ").append(oldUser.getName()).append(" to ").append(name);
                        hasChanges = true;
                    }
                    if (!oldUser.getContact().equals(contact)) {
                        changes.append(hasChanges ? ", " : ", ");
                        changes.append("Contact changed from ").append(oldUser.getContact()).append(" to ").append(contact);
                        hasChanges = true;
                    }

                    ClientUser updatedUser = new ClientUser(id, username, password, name, contact);
                    userFileManager.updateUser(updatedUser);
                    fileManager.logAction("SYSTEM", hasChanges ? changes.toString() : "Edited user: ID=" + id + " (no changes made)");
                }
                resp.sendRedirect(req.getContextPath() + "/admin/manage-users");
            } else if (path.equals("/user/delete")) {
                String id = req.getParameter("id");
                userFileManager.deleteUser(id);
                fileManager.logAction("SYSTEM", "Deleted user: ID=" + id);
                resp.sendRedirect(req.getContextPath() + "/admin/manage-users");
            }
        } catch (IOException e) {
            req.setAttribute("error", "Error during operation: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/error.jsp").forward(req, resp);
        }
    }
}