package sql;

public class Course {
  String code,name;
  java.sql.Date Date;
  
   public Course() {
	   
   }

	public Course(String code,String name, java.sql.Date date) {
    this.code = code;
    this.name = name;
    this.Date = date;
    
}

	public String toString() {
		return String.format("%s%s%s",
				("code : " + code + " "),
				("Name : " + name + " "),
				("date : " + Date + " ")
		);
	}

}