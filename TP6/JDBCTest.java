import java.awt.*;
import java.awt.event.*;
import java.sql.*;

public class JDBCTest extends Panel
        implements ActionListener {
    TextField nomDriver;
    TextField urlConnection;
    TextField nomLogin;
    TextField motPasse;
    Button boutonConnection;
    TextField requeteSQL;
    List resultatRequete;
    Button boutonExecuter;

    Connection connection;

    public JDBCTest() {
        this.connection = null;

        Panel haut;
        Panel bas;

        haut = new Panel();
        bas = new Panel();

        boutonConnection = new Button("Connection");
        boutonConnection.addActionListener(this);

        boutonExecuter = new Button("Execution");
        boutonExecuter.addActionListener(this);

        Panel p1 = new Panel();
        p1.setLayout(new GridLayout(4, 2));
        p1.add(new Label("Driver :"));
        p1.add(nomDriver = new TextField(32));
        p1.add(new Label("URL jdbc :"));
        p1.add(urlConnection = new TextField(32));
        p1.add(new Label("login :"));
        p1.add(nomLogin = new TextField(32));
        p1.add(new Label("password :"));
        p1.add(motPasse = new TextField(32));

        haut.setLayout(new BorderLayout());
        haut.add(p1, BorderLayout.NORTH);
        haut.add(boutonConnection, BorderLayout.SOUTH);

        Panel p2 = new Panel();
        p2.setLayout(new BorderLayout());
        p2.add(new Label("requete"), BorderLayout.WEST);
        p2.add(requeteSQL = new TextField(32), BorderLayout.CENTER);
        Panel p3 = new Panel();
        p3.setLayout(new BorderLayout());
        p3.add(p2, BorderLayout.NORTH);
        p3.add(boutonExecuter, BorderLayout.SOUTH);

        bas.setLayout(new BorderLayout());
        bas.add(p3, BorderLayout.NORTH);
        bas.add(resultatRequete = new List(20));

        setLayout(new BorderLayout());
        add(haut, BorderLayout.NORTH);
        add(bas, BorderLayout.CENTER);
    }

    public void actionPerformed(ActionEvent evt) {
        // System.out.prinln("Not implemented !!");
        switch (evt.getActionCommand()) {
            case "Connection":
                handleConnection();
                break;

            case "Execution":
                handleExecution();
                break;
            default:
                break;
        }
    }

    private void handleConnection() {

        String driverName = this.nomDriver.getText();
        String url = this.urlConnection.getText();
        String login = this.nomLogin.getText();
        String pw = this.motPasse.getText();

        if (driverName.isEmpty()) {
            this.appendError("Missing Driver Name");
            return;
        } else if (url.isEmpty()) {
            this.appendError("Missing JDBC URL");
            return;
        } else if (login.isEmpty()) {
            this.appendError("Missing Login");
            return;
        } else if (pw.isEmpty()) {
            this.appendError("Missing Password");
            return;
        }

        try {
            Class.forName(driverName);
            this.connection = DriverManager.getConnection(url, login, pw);
            this.appendInfo("Connection successful.");
        } catch (ClassNotFoundException | SQLException e) {
            this.appendError(e.getLocalizedMessage());
        }
    }

    private void handleExecution() {
        if (this.connection == null) {
            this.appendError("No connection established.");
            return;
        }

        String sql = this.requeteSQL.getText();

        if (sql.isEmpty()) {
            this.appendError("Missing SQL Request");
            return;
        }

        Statement s;
        try {
            s = connection.createStatement();
            
            ResultSet r = s.executeQuery(sql);

            int cols = r.getMetaData().getColumnCount();
            String colNames = "";

            for (int i = 1; i <= cols; i++) {
                colNames += r.getMetaData().getColumnName(i) + "\t";
            }

            this.appendInfo(colNames);

            while (r.next()) {
                String row = "";

                for (int i = 1; i <= cols; i++) {
                    row += r.getString(i) + "\t";
                }

                this.appendInfo(row);
            }

            this.appendInfo("Complete");

        } catch (SQLException e) {
            this.appendError(e.getLocalizedMessage());
        }
    }

    private void appendError(String error) {
        resultatRequete.add("Error: " + error);
    }

    private void appendInfo(String info) {
        resultatRequete.add("Info: " + info);
    }

    public static void main(String[] arg) {
        JDBCTest test;

        Frame f = new Frame();
        f.setSize(500, 400);
        test = new JDBCTest();
        f.add(test, BorderLayout.CENTER);
        f.addWindowListener(new WindowAdapter() {
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        f.setVisible(true);
    }
}