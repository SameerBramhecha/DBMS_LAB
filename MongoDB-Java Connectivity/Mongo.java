import com.mongodb.*;
import org.bson.Document;

import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;

import java.util.*;

public class Mongo{
	
	public static MongoClient mongo;
	public static MongoCredential credential;
	public static MongoDatabase database;
	public static MongoCollection<Document> collection;
	public static FindIterable<Document> ft;
	public static Iterator it;
	
	public static void main(String[] args) {
		mongo = new MongoClient("localhost",27017);
		credential = MongoCredential.createCredential("root","db","password".toCharArray());
		 System.out.println("Connected to the database successfully");  
	      
	      // Accessing the database 
	      database = mongo.getDatabase("myDb"); 
	      System.out.println("Credentials ::"+ credential);     
		
	      
	      //Creating a collection
	      database.createCollection("ipl");
	      System.out.println("Connected to db successfully");
	      
	      //Retrieving a collection
	      collection = database.getCollection("ipl");
	      System.out.println("Collection ipl selected successfully");
	      
	    //Listing All Collections
	      System.out.println("Collection is myDb are: ");
	      for(String name : database.listCollectionNames()) {
	    	  System.out.println(name);
	      }
	      
	      //Inserting a Document
	      Document d1 = new Document("_id","1")
	    		  .append("TeamName","MI")
	    		  .append("TitlesWon", "5")
	    		  .append("Captain","Rohit Sharma");
	      collection.insertOne(d1);
	      System.out.println("Document Inserted Successfully");
	      
	      //Inserting Multiple Documents;
	      Document d2 = new Document("_id","2")
	    		  .append("TeamName","CSK")
	    		  .append("TitlesWon", "4")
	    		  .append("Captain","M S Dhoni");
	      
	      Document d3 = new Document("_id","3")
	    		  .append("TeamName","KKR")
	    		  .append("TitlesWon", "2")
	    		  .append("Captain","Shreyas Iyer");
	      
	      Document d4 = new Document("_id","4")
	    		  .append("TeamName","RR")
	    		  .append("TitlesWon", "1")
	    		  .append("Captain","Sanju Samson");
	      
	      Document d5 = new Document("_id","5")
	    		  .append("TeamName","SRH")
	    		  .append("TitlesWon", "1")
	    		  .append("Captain","Kane Williamson");
	      
	      Document d6 = new Document("_id","6")
	    		  .append("TeamName","GT")
	    		  .append("TitlesWon", "1")
	    		  .append("Captain","Hardik Pandya");
	      
	      Document d7 = new Document("_id","7")
	    		  .append("TeamName","RCB")
	    		  .append("TitlesWon", "0")
	    		  .append("Captain","Virat Kohli");
	      
	      Document d8 = new Document("_id","8")
	    		  .append("TeamName","PBKS")
	    		  .append("TitlesWon", "0")
	    		  .append("Captain","Mayank Agarwal");
	      
	      Document d9 = new Document("_id","9")
	    		  .append("TeamName","DC")
	    		  .append("TitlesWon", "0")
	    		  .append("Captain","Rishabh Pant");
	      
	      Document d10 = new Document("_id","10")
	    		  .append("TeamName","LSG")
	    		  .append("TitlesWon", "0")
	    		  .append("Captain","K L Rahul");
	      
	      List<Document> list = new ArrayList<>();
	      list.add(d2);
	      list.add(d3);
	      list.add(d4);
	      list.add(d5);
	      list.add(d6);
	      list.add(d7);
	      list.add(d8);
	      list.add(d9);
	      list.add(d10);
	      
	      collection.insertMany(list);
	      System.out.println("Documents Inserted Successfully");
	      
	      
	      //Retrieving all Documents
	      
	      
	      ft = collection.find();
	      
	      int i = 1;
	      it= ft.iterator();
	      
	      while(it.hasNext()) {
	    	  System.out.println(it.next());
	    	  i++;
	      }
	      
	      
	     //Updating One Document
	      
	      collection.updateOne(Filters.eq("TeamName", "PBKS"), Updates.set("Captain", "Shikhar Dhawan"));
	      System.out.println("Record Updated Successfully\nAfter Update Records");
	      ft = collection.find();
	      i = 1;
	      it= ft.iterator();
	      
	      while(it.hasNext()) {
	    	  System.out.println(it.next());
	    	  i++;
	      }
	      
	      //Updating Multiple Document
	      
	      collection.updateMany(Filters.eq("TitlesWon", "0"), Updates.set("TitlesWon", "-1"));
	      System.out.println("Record Updated Successfully\nAfter Update Records");
	      ft = collection.find();
	      i = 1;
	      it= ft.iterator();
	      
	      while(it.hasNext()) {
	    	  System.out.println(it.next());
	    	  i++;
	      }
	      
	      
	      //Deleting a Document
	      
	      collection.deleteOne(Filters.eq("TitlesWon","-1"));
	      
	      System.out.println("Record Deleted Successfully\nAfter Delete Records:");
	      ft = collection.find();
	      i = 1;
	      it= ft.iterator();
	      
	      while(it.hasNext()) {
	    	  System.out.println(it.next());
	    	  i++;
	      }
	      
	      //Deleting Multiple Documents
	      collection.deleteMany(Filters.eq("TitlesWon","-1"));
	      
	      System.out.println("Record Deleted Successfully\nAfter Delete Records:");
	      ft = collection.find();
	      i = 1;
	      it= ft.iterator();
	      
	      while(it.hasNext()) {
	    	  System.out.println(it.next());
	    	  i++;
	      }
	      
	      //Dropping a Collection
	      
	      collection.drop();
	      System.out.println("Collection Dropped Sucessfully");
	      
	}
}