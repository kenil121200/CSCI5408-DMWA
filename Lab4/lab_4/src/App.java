import java.sql.*;
import java.util.Scanner;

public class App {
    
    private static final String LOCAL_DB_URL = "jdbc:mysql://127.0.0.1:3306/lab_4";
    private static final String LOCAL_DB_USER = "root";
    private static final String LOCAL_DB_PASSWORD = "admin123";

    private static final String REMOTE_DB_URL = "jdbc:mysql://34.134.47.238:3306/lab_4";
    private static final String REMOTE_DB_USER = "root";
    private static final String REMOTE_DB_PASSWORD = "admin123";

    public static void main(String[] args) {
        Connection remoteConnect = null;
        Connection localConnect = null;

        try {

            Scanner scanner = new Scanner(System.in);
            System.out.print("Enter user ID: ");
            int userId = scanner.nextInt();
            System.out.print("Enter item name: ");
            scanner.nextLine();
            String itemName = scanner.nextLine();
            System.out.print("Enter quantity: ");
            int quantity = scanner.nextInt();

            long startTimeLocal = System.currentTimeMillis();
            localConnect = DriverManager.getConnection(LOCAL_DB_URL, LOCAL_DB_USER, LOCAL_DB_PASSWORD);
            int orderId = createOrderLocalDB(localConnect, userId, itemName, quantity); // Assuming user John has id 1
            long executionTimeLocal = System.currentTimeMillis() - startTimeLocal;
            System.out.println("Execution Time with local database: " + executionTimeLocal + " ms");
            System.out.println("Order created with ID: " + orderId);
            
            long startTimeRemote = System.currentTimeMillis();
            remoteConnect = DriverManager.getConnection(REMOTE_DB_URL, REMOTE_DB_USER, REMOTE_DB_PASSWORD);
            updateQuantityRemoteDB(remoteConnect, itemName, quantity);
            long executionTimeStep3 = System.currentTimeMillis() - startTimeRemote;
            System.out.println("Execution Time with remote database: " + executionTimeStep3 + " ms");
            scanner.close();

        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            // Close connections
            try {
                if (remoteConnect != null)
                    remoteConnect.close();
                if (localConnect != null)
                    localConnect.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private static int createOrderLocalDB(Connection connection, int userId, String itemName, int quantity) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "INSERT INTO Order_info (user_id, item_name, quantity, order_date) VALUES (?, ?, ?, ?)",
                Statement.RETURN_GENERATED_KEYS);

        preparedStatement.setInt(1, userId);
        preparedStatement.setString(2, itemName);
        preparedStatement.setInt(3, quantity);
        preparedStatement.setDate(4, new Date(System.currentTimeMillis())); // Assuming the current date

        int affectedRows = preparedStatement.executeUpdate();
        int orderId = -1;

        if (affectedRows > 0) {
            ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }
        }

        return orderId;
    }

    private static void updateQuantityRemoteDB(Connection connection, String itemName, int quantity) throws SQLException {
        PreparedStatement preparedStatement = connection.prepareStatement(
                "UPDATE Inventory SET available_quantity = available_quantity - ? WHERE item_name = ?");

        preparedStatement.setInt(1, quantity);
        preparedStatement.setString(2, itemName);

        preparedStatement.executeUpdate();
    }
}