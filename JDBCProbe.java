import java.sql.*;
public class JDBCProbe {
    public static void main(String[] args) throws Exception {
        Class.forName("com.mysql.cj.jdbc.Driver");
        try (Connection c = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/campus_snackbar_db?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC",
                "root",
                "bianca.1865")) {
            System.out.println("CONNECTION_OK");
            System.out.println(c.getCatalog());
        }
    }
}
