import java.sql.*;
import java.util.ArrayList;

public class Main {
    static Connection c;

    static ArrayList<ArrayList<String>> getSalles() {
        if (c == null) {
            return new ArrayList<ArrayList<String>>();
        }

        String sql = "SELECT * FROM Salle;";
        ArrayList<ArrayList<String>> res = new ArrayList<ArrayList<String>>();

        try {
            Statement s = c.createStatement();
            ResultSet r = s.executeQuery(sql);

            int cols = r.getMetaData().getColumnCount();

            while (r.next()) {
                ArrayList<String> z = new ArrayList<String>();

                for (int i = 1; i <= cols; i++) {
                    z.add(r.getString(i));
                }
                res.add(z);
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

        return res;
    }

    void deleteSalle(int s) {
        if (s < 0) { return; }
        if (c == null) { return; }

        String sql = "DELETE FROM Salle WHERE nomSalle = ?";
        try {
            PreparedStatement ps = c.prepareStatement(sql);
            ps.setString(1, "Salle " + s);
            int r = ps.executeUpdate();

            System.out.println('r');
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            c = DriverManager.getConnection("jdbc:mysql://localhost:3306/parc", "root", "10092004");

            ArrayList<ArrayList<String>> res = getSalles();

            System.out.println("getSalles:");
            res.forEach((arr) -> {
                System.out.println(arr);
            });

        } catch (ClassNotFoundException | SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
