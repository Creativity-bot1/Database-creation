package sql; 
import java.sql.*;
import java.util.Scanner;
import java.util.ArrayList;


public class JavaApp1 {
    private static final Scanner S = new Scanner(System.in);

    private static Connection c = null;
    private static ResultSet rs= null;
    
    private static ArrayList<Course> courses = null;

    public static void main(String[] args) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            c = DriverManager.getConnection("jdbc:derby:/Localhost:3306/coursework","root","root"); // ToDo : Specify Parameters ! IE

            String choice = "";

            do {
                System.out.println("-- MAIN MENU --");
                System.out.println("1 - Browse ResultSet");
                System.out.println("2 - Invoke Procedure");
                System.out.println("Q - Quit");
                System.out.print("Pick : ");

                choice = S.next().toUpperCase();

                switch (choice) {
                    case "1" : {
                        browseResultSet();
                        break;
                    }
                    case "2" : {
                        invokeProcedure();
                        break;
                    }
                }
            } while (!choice.equals("Q"));

            c.close();

            System.out.println("Bye Bye :)");
        }
        catch (Exception e) {
            System.err.println(e.getMessage());
        }
    }

    private static void browseResultSet() throws Exception {
        Statement s = c.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);

        ResultSet rs = s.executeQuery("Select * from app.course"); // ToDo : Specify Query !
        
        while (rs.next()) {
        	System.out.println("--NAVIGATE RESULT --");
        	System.out.println("p - previous N-Next Q-Quit");
        	
        	displayResultSet();
        	
        	String choice = "";
        			
        do {
        	System.out.print("choice : ");
        	
        	choice = S.next().toUpperCase();
        	
        	switch (choice ) {
        	case "p" : {
        		if(rs.previous()) {
        			displayResultSet();
        		}
        		
        		break;
        		
        	}
        	case "N" : {
        		if(rs.next()) {
        			displayResultSet();
        		}
        		break;
        	}
        	
        	}
        	
      } while (!choice.equals("Q"));
        
    }
         {
        	System.out.println("--NO DATA--");
        	
        }
    }
           
     private static void displayResultSet() throws Exception  { 	
        	System.out.println(String.format("row : %s  Code : %s  Name : %s  Date : %s", rs.getRow(),rs.getString("Code"),rs.getString("Name"),rs.getDate("Date")));
     }
        	

        // ToDo : Check ResultSet Contains Rows !
            // ToDo : Display ResultSet Rows !

    private static void invokeProcedure() throws Exception {     
    	courses = new ArrayList<>();
    	
    	rs.beforeFirst();
    	
    	while(rs.next()) {
    		courses.add(new Course(rs.getString("code"),rs.getString("Name"),rs.getDate("Date")));
    	}
    	
    	System.out.println("Courses FOUND :" + courses.size());
    	
    	for (Course course : courses) {
    		System.out.println(course.toString());
    	}
        
    }
    // ToDo : Receive Course Code & Course Date !
    // ToDo : Specify CallableStatement !
}
