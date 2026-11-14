Project name: CampusSnack Bar
What this project does: This is a Java web app built with Jakarta Servlet + JSP + MySQL. It allows users to:
•Register and login
•Browse snack items
•Place orders
•Check stock before ordering
•Prevent unauthorized access to order route

Core architecture:
•Controller layer: AuthServlet, MenuServlet, OrderServlet
•DAO layer: UserDAO, SnackDAO, OrderDAO
•Model layer: User, SnackItem, Order
•Database utility: DBConnection
•Filter layer: AuthFilter

Important notes for the practical:
•DB URL: jdbc:mysql://localhost:3306/campus_snackbar_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC
•DB user: root
•DB password: bianca.1865
•This project uses plain text password comparison for exam clarity. In real production, use BCrypt or PBKDF2 hashing.
•Orders are processed inside a transaction to avoid stock mismatch.
•The app checks stock and refuses invalid orders.
Key feature: login and registration Code snippet:     
@WebServlet(urlPatterns = {"/login", "/logout", "/register"})     public class AuthServlet extends HttpServlet {         private final UserDAO userDAO = new UserDAO();
        @Override        protected void doPost(HttpServletRequest request, HttpServletResponse response)                throws ServletException, IOException {            String action = request.getServletPath();
            if ("/login".equals(action)) {                String email = request.getParameter("email");                String password = request.getParameter("password");
                User user = userDAO.findByEmail(email);                if (user != null && user.getPassword().equals(password)) {                    HttpSession session = request.getSession();                    session.setAttribute("currentUser", user);                    response.sendRedirect(request.getContextPath() + "/menu");                } else {                    request.setAttribute("errorMessage", "Invalid email or password.");                    request.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(request, response);                }            }        }    }

Key feature: menu display Code snippet:     
@WebServlet("/menu")     public class MenuServlet extends HttpServlet {         private final SnackDAO snackDAO = new SnackDAO();
        @Override        protected void doGet(HttpServletRequest request, HttpServletResponse response)                throws ServletException, IOException {            List<SnackItem> snacks = snackDAO.getAllAvailableSnacks();            request.setAttribute("snackList", snacks);            request.getRequestDispatcher("/WEB-INF/views/menu.jsp").forward(request, response);        }    }

Key feature: secure order flow Code snippet:     
@WebFilter(urlPatterns = {"/order"})     public class AuthFilter implements Filter {         @Override         public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)                 throws IOException, ServletException {             HttpServletRequest httpRequest = (HttpServletRequest) request;             HttpServletResponse httpResponse = (HttpServletResponse) response;             HttpSession session = httpRequest.getSession(false);
            boolean isLoggedIn = (session != null && session.getAttribute("currentUser") != null);
            if (isLoggedIn) {                chain.doFilter(request, response);            } else {                httpResponse.sendRedirect(httpRequest.getContextPath() + "/login?error=unauthorized");            }        }    }

Key feature: safe order + stock update in transaction Code snippet:    
public boolean createOrder(Order order) {         String insertOrderSQL = "INSERT INTO orders (user_id, snack_id, quantity, total_price, status) VALUES (?, ?, ?, ?, ?)";         String updateStockSQL = "UPDATE snacks SET stock_quantity = stock_quantity - ? WHERE id = ? AND stock_quantity >= ?";
        Connection conn = null;        try {            conn = DBConnection.getConnection();            conn.setAutoCommit(false);
            try (PreparedStatement psStock = conn.prepareStatement(updateStockSQL)) {                psStock.setInt(1, order.getQuantity());                psStock.setLong(2, order.getSnackId());                psStock.setInt(3, order.getQuantity());
                int rowsAffected = psStock.executeUpdate();                if (rowsAffected == 0) {                    conn.rollback();                    return false;                }            }
            try (PreparedStatement psOrder = conn.prepareStatement(insertOrderSQL, Statement.RETURN_GENERATED_KEYS)) {                psOrder.setLong(1, order.getUserId());                psOrder.setLong(2, order.getSnackId());                psOrder.setInt(3, order.getQuantity());                psOrder.setDouble(4, order.getTotalPrice());                psOrder.setString(5, order.getStatus());
                int affectedRows = psOrder.executeUpdate();                if (affectedRows == 0) {                    conn.rollback();                    return false;                }            }
            conn.commit();            return true;
        } catch (SQLException e) {            if (conn != null) {                try { conn.rollback(); } catch (SQLException ex) { ex.printStackTrace(); }            }            e.printStackTrace();            return false;        }    }

Database SQL used by this app
Typical schema:     C
REATE TABLE users (         id BIGINT PRIMARY KEY AUTO_INCREMENT,         email VARCHAR(255) NOT NULL UNIQUE,         password VARCHAR(255) NOT NULL,         full_name VARCHAR(255) NOT NULL     );
    CREATE TABLE snacks (        id BIGINT PRIMARY KEY AUTO_INCREMENT,        name VARCHAR(255) NOT NULL,        category VARCHAR(100),        price DECIMAL(10,2) NOT NULL,        stock_quantity INT NOT NULL DEFAULT 0    );
    CREATE TABLE orders (        id BIGINT PRIMARY KEY AUTO_INCREMENT,        user_id BIGINT NOT NULL,        snack_id BIGINT NOT NULL,        quantity INT NOT NULL,        total_price DECIMAL(10,2) NOT NULL,        order_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,        status VARCHAR(50) DEFAULT 'PENDING',        FOREIGN KEY (user_id) REFERENCES users(id),        FOREIGN KEY (snack_id) REFERENCES snacks(id)    );

Queries used in code:
1.User lookup by email   
SELECT id, email, password, full_name     FROM users     WHERE email = ?;

2.Register new user  
INSERT INTO users (email, password, full_name)     VALUES (?, ?, ?);

3.Get all snacks with stock  
SELECT id, name, category, price, stock_quantity     FROM snacks     WHERE stock_quantity > 0;

4.Get snack by ID    
SELECT id, name, category, price, stock_quantity     FROM snacks     WHERE id = ?;

5.Update stock safely  
UPDATE snacks     SET stock_quantity = stock_quantity - ?     WHERE id = ?     AND stock_quantity >= ?;

6.Insert order    
INSERT INTO orders (user_id, snack_id, quantity, total_price, status)     VALUES (?, ?, ?, ?, ?);

7.Manual stock update   
UPDATE snacks     SET stock_quantity = ?     WHERE id = ?;

Quick project flow:
1.Open homepage
2.Login or register
3.Browse menu
4.Select quantity and click Order
5.AuthFilter ensures only logged-in users can order
6.OrderDAO checks stock and inserts order in one transaction
7.UI shows success page

This is a good AWD practical project to explain in interviews:
•MVC pattern in Java
•DAO + Servlet + JSP
•Session-based auth
•PreparedStatement usage
•Transaction handling
•Stock validation
•MySQL database integration
