import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;
import org.bson.Document;
import com.mongodb.MongoClient;
import com.mongodb.MongoCredential;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.MongoDatabase;
import com.mongodb.client.model.Filters;
import com.mongodb.client.model.Updates;


public class MenuDrivenMongo{
	
	public static MongoClient mongo;
	public static MongoCredential credential;
	public static MongoDatabase database;
	public static MongoCollection<Document> collection;
	public static FindIterable<Document> ft;
	public static Iterator it;
	public static List<Document> list;
	
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
		mongo = new MongoClient("localhost",27017);
		credential = MongoCredential.createCredential("root","db","password".toCharArray());
		 System.out.println("Connected to the database successfully");  
	      
	      // Accessing the database 
	      database = mongo.getDatabase("myDb"); 
	      System.out.println("Credentials ::"+ credential);     
		
	      //Creating a collection
	      database.createCollection("ipl");
	      System.out.println("Connected to db successfully");
	    
	      //Listing All Collections
	      System.out.println("Collection in myDb are: ");
	      for(String name : database.listCollectionNames()) {
	    	  System.out.println(name);
	      }
	      
	      //Retrieving a collection
	      collection = database.getCollection("ipl");
	      System.out.println("Collection ipl selected successfully");
	      
	    
	      while(true) {
	    	  System.out.println("1. View All Document/s");
	    	  System.out.println("2. Insert Document/s");
		      System.out.println("3. Update Document");
		      System.out.println("4. Delete Document/s");
		      System.out.println("5. Exit");
		      System.out.println("Enter Choice: ");
		      int ch  = sc.nextInt();
		      switch(ch) {
		      case 1: 
		    	  retrieve(collection);
		    	  break;
		      case 2:
		    	  insert(collection,sc);
		    	  System.out.println("After Insert Records are:");
		    	  retrieve(collection);
		    	  break;
		    	  
		      case 3:
		    	  update(collection,sc);
		    	  System.out.println("After Update Records are:");
		    	  retrieve(collection);
		    	  break;
		      case 4:
		    	  delete(collection,sc);
		    	  System.out.println("After Delete Records are:");
		    	  retrieve(collection);
		    	  break;  
		      case 5:
		    	//Dropping a Collection
		    	  collection.drop();
			      System.out.println("Collection Dropped Sucessfully");
			      System.out.println("Tata-Tata Bye-Bye Get Lost\nNIKALO AAB YAHA SE");
			      sc.close();
		    	  System.exit(0);
		    	  
		      default:
		    	  System.out.println("Enter Correct Choice");
		    	  break;
		    		  
		      }
	      }
	}
	public static void retrieve(MongoCollection<Document> collection) {
		 ft = collection.find();
	      int i = 0;
	      it= ft.iterator();
	      
	      while(it.hasNext()) {
	    	  System.out.println(it.next());
	    	  i++;
	      }
	      System.out.println("Number of documents displayed is = " + i);
	}
	public static void insert(MongoCollection<Document> collection,Scanner sc) {
		System.out.println("Enter how many documents to insert: ");
		int n = sc.nextInt();
		String tname;
		String twon;
		String captain;
		if(n==0) {
			return;
		}
		else if(n==1) {
			System.out.println("Enter TeamName:");
			tname = sc.next();
			System.out.println("Enter TitlesWon:");
			twon = sc.next();
			sc.nextLine();
			System.out.println("Enter Captain:");
			captain = sc.nextLine();
			Document d = new Document("TeamName",tname)
		    		  .append("TitlesWon", twon)
		    		  .append("Captain",captain);
			
			collection.insertOne(d);
			System.out.println("Document Inserted Successfully");
		}
		else {
			list = new ArrayList<>();
			for(int i=0;i<n;i++) {
				System.out.println("Enter TeamName:");
				tname = sc.next();
				System.out.println("Enter TitlesWon:");
				twon = sc.next();
				sc.nextLine();
				System.out.println("Enter Captain:");
				captain = sc.nextLine();
				Document d = new Document("TeamName",tname)
			    		  .append("TitlesWon", twon)
			    		  .append("Captain",captain);
				list.add(d);
				
			}
			collection.insertMany(list);
			System.out.println("Documents Inserted Successfully");
		}
		
		
	}
	public static void update(MongoCollection<Document> collection,Scanner sc) {
			System.out.println("Enter TeamName to update TitlesWon: ");
			String tname = sc.next();
			System.out.println("Enter new value of TitlesWon: ");
			String twon = sc.next();
			System.out.println("1. UpdateOne");
			System.out.println("2. UpdateMany");
			System.out.println("Enter Choice:");
			int ch = sc.nextInt();
			if(ch==1) {
				collection.updateOne(Filters.eq("TeamName",tname),Updates.set("TitlesWon", twon));
				System.out.println("Document Updated Successfully");
			}
			else if(ch==2) {
				collection.updateMany(Filters.eq("TeamName",tname),Updates.set("TitlesWon", twon));
				System.out.println("Documents Updated Successfully");
			}
	}
	
	public static void delete(MongoCollection<Document> collection,Scanner sc) {
			System.out.println("Enter TeamName to Delete: ");
			String tname = sc.next();
			System.out.println("1. DeleteOne");
			System.out.println("2. DeleteMany");
			System.out.println("Enter Choice:");
			int ch = sc.nextInt();
			if(ch==1) {
				collection.deleteOne(Filters.eq("TeamName",tname));
			}
			else if(ch==2) {
				collection.deleteMany(Filters.eq("TeamName",tname));
			}
			System.out.println("Documents Deleted Successfully");
	}
	
	
}
