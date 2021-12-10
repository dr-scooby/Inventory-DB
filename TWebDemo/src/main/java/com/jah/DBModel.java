package com.jah;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.*;
import java.sql.Date;
import java.util.*;


public class DBModel {
	
	// Database info
	//private String dburl = "jdbc:mysql://localhost:3306/skyhawk";
	private String dburl = "jdbc:mysql://jfgapp1261:3306/inteldb";
	private String dbuser = "nurali";
	private String dbpass = "Java1973";

	private Connection conn; // connection to DB
	private Connection tempconn ; // a temp conn to be used as secondary
		
	public DBModel() {
		System.out.println("init DBModel");
	}

	
	public void connect() throws SQLException{
		System.out.println("\nconnect called...");
		
		try {
			//Class.forName("com.mysql.cj.jdbc.Driver"); // new mysql driver version
			Class.forName("com.mysql.jdbc.Driver"); // old mysql driver version
			conn = DriverManager.getConnection(dburl, dbuser, dbpass);
			tempconn = DriverManager.getConnection(dburl, dbuser, dbpass);
		}catch(ClassNotFoundException e) {
			System.err.println(e);
		}
	}
	
	
	// add Laptop to DB
	public boolean addLaptop(Laptop lap) {
		boolean ok = false;
		
		String sql = "insert into laptopinventory(Serial,model,manufacture) values(?,?,?,?,?);";
		
		
		try {
			connect();
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, lap.getSerial());
		ps.setString(2, lap.getModel());
		ps.setString(3, lap.getManufacture());
		ps.setString(4, lap.getNotes());
		ps.setString(5, lap.getAssigned());
				
		ok = ps.executeUpdate() > 0;
		
		String serialnumber = lap.getSerial() ;
		
		// add entry to the history table
				String historysql = "insert into history(action, serial, time) values(?,?,?)";
				ps = conn.prepareStatement(historysql); // prepare a statement
				ps.setString(1, "add laptop " + serialnumber);
				ps.setString(2, serialnumber);
				ps.setString(3, new java.util.Date().toString() );
				ps.executeUpdate(); // execute
				ps.close();
				conn.close();
		}catch(SQLException s) {
			System.err.println("error in addLaptop() \n" + s);	
		}
		
			
		
		
		
		return ok;
	}
	
	
	// add laptop with following parameters:
	public boolean addLaptop(String serial, String model, String manufacture)throws SQLException {
		boolean ok = false;
		
		String sql = "insert into laptopinventory(Serial,model,manufacture, notes, assigned) values(?,?,?,?,?);";
		// select statement to check if serial already exists in DB before adding
		String sql_select = "select count(*) from laptopinventory where Serial = ? ";
		
		connect();
		PreparedStatement ps1 = conn.prepareStatement(sql_select);
		ps1.setString(1, serial);
		ResultSet rs = ps1.executeQuery();
		rs.next();
		String counts = rs.getString(1);
		if(counts.equals("0")) {
			System.out.println("nothing found for " + serial);
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1, serial);
			ps.setString(2, model);
			ps.setString(3, manufacture);
			ps.setString(4,  "");
			ps.setString(5,  "no");
					
			ok = ps.executeUpdate() > 0;
			
			// add entry to the history table
			String historysql = "insert into history(action, serial, time) values(?,?,?)";
			ps = conn.prepareStatement(historysql); // prepare a statement
			ps.setString(1, "add laptop " + serial);
			ps.setString(2, serial);
			ps.setString(3, new java.util.Date().toString() );
			ps.executeUpdate(); // execute
			
			ps.close();
			ok = true;
			
		}else {
			System.out.println("Found : " + serial);
			ok = false; // exists, so can't add
			//ps.close();
		}
		
		
		
		
		
		conn.close();
		
		return ok;
	}
	
	// delete laptop from DB
	public boolean delete(String serialsearch)throws SQLException, Exception{
		boolean ok = false;
		
		String sql = "delete from laptopinventory where Serial=?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, serialsearch);
		ok = ps.executeUpdate() > 0;
		
		// add entry to the history table
		String historysql = "insert into history(action, serial, time) values(?,?,?)";
		ps = conn.prepareStatement(historysql); // prepare a statement
		ps.setString(1, "removed laptop " + serialsearch);
		ps.setString(2, serialsearch);
		ps.setString(3, new java.util.Date().toString() );
		ps.executeUpdate(); // execute
		
		ps.close();
		conn.close();
		
		return ok;
	}
	
	// list all laptops, get all listing
	public List<Laptop> listAll() throws SQLException, Exception{
		
		connect(); // connect to DB
		
		String sql = "select * from laptopinventory where assigned = 'no';" ; // sql select
		
		List<Laptop> laps = new ArrayList<>(); // create the ArrayList
		
		// create a Statement, and execute SQL, and get a ResultSet
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);
		while(rs.next()) {
			String serial = rs.getString("Serial");
			String model = rs.getString("Model");
			String manuf = rs.getString("Manufacture");
			String notes = rs.getString("notes");
			String assigned = rs.getString("assigned");
			Laptop la = new Laptop(serial, model, manuf, notes, assigned); // make a Laptop Object
			laps.add(la); // add Laptop Object to the ArrayList
		}
		
		rs.close();
		conn.close();
		
		// return ArrayList
		return laps;		
	}
	
	
	// get a listing of model types
	public List<LModel> listModels() throws SQLException, Exception {
		
		String sql = "select  Model, count(Model) as QTY from inteldb.laptopinventory where assigned = 'no' group by Model order by Model;";
		
		connect(); // connect to DB
		
		// create the ArrayList of LModel
		List<LModel> models = new ArrayList<>();
		
		// create a Statement, and execute SQL, and get a ResultSet
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);
		while(rs.next()) {
			String model = rs.getString(1); // first column
			int qty = rs.getInt(2); // second col
			LModel lmodel = new LModel(model, qty); // create the LModel object
			System.out.println(lmodel);
			models.add(lmodel); // add to our arraylist
		}
		
		return models;
		
	}
	
	//update the laptop
	public boolean update(Laptop l) throws SQLException {
		boolean ok = false;
		
		String sql = "update laptopinventory set Model=?, Manufacture=?, notes=? where Serial=?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, l.getModel());
		ps.setString(2, l.getManufacture());
		ps.setString(3, l.getNotes());
		ps.setString(4, l.getSerial());
		ok = ps.executeUpdate() > 0;
		
		ps.close();
		conn.close();
		
		return ok;
	}
	
	// assign a laptop to a user, need laptop and user name/wwid
	public boolean assignTo(Laptop l, String user) throws SQLException {
		boolean ok = false;
		
		// sql update the laptop assigned field to yes
		String sql_update = "update laptopinventory set assigned = ?, Model=?, Manufacture=?, notes=? where Serial = ?";
		
		// sql to insert the assigned laptop into the table assigned
		String sql_insert = "insert into assignedlaptop(laptopserial, username) values(?,?)";
		
		connect(); // connect to DB
		
		PreparedStatement ps = conn.prepareStatement(sql_update);
		ps.setString(1, "yes"); // set assigned to yes
		ps.setString(2, l.getModel());
		ps.setString(3, l.getManufacture());
		ps.setString(4, l.getNotes());		
		ps.setString(5, l.getSerial());
		ok = ps.executeUpdate() > 0;
		
		ps = conn.prepareStatement(sql_insert);
		ps.setString(1, l.getSerial());
		ps.setString(2, user);
		ok = ps.executeUpdate() > 0;
		
		// add entry to the history table
		String historysql = "insert into history(action, serial, time) values(?,?,?)";
		ps = conn.prepareStatement(historysql); // prepare a statement
		ps.setString(1, "assigned laptop " + l.getSerial() + " to user " + user);
		ps.setString(2, l.getSerial());
		ps.setString(3, new java.util.Date().toString() );
		ps.executeUpdate(); // execute
		
		ps.close();
		conn.close();
				
		return ok;
	}
	
	// un-assign the laptop from the user
	public boolean unAssign(Laptop l) throws SQLException {
		boolean ok = false;
		
		// update the laptop assigned field to no
		String unassign_sql = "update laptopinventory set assigned = ?, Model=?, Manufacture=?, notes=? where Serial= ?";
		
		// delete the laptop from the assignedlaptop table
		String delete_sql = "delete from assignedlaptop where assignedlaptop.laptopserial = ?";
		
		connect();
		// un-assign
		PreparedStatement ps = conn.prepareStatement(unassign_sql);
		ps.setString(1, "no");
		ps.setString(2, l.getModel());
		ps.setString(3, l.getManufacture());
		ps.setString(4, l.getNotes());		
		ps.setString(5, l.getSerial());
		ok = ps.executeUpdate() > 0;
		
		// delete from table
		ps = conn.prepareStatement(delete_sql);
		ps.setString(1, l.getSerial());
		ok = ps.executeUpdate() > 0;
		
		// add entry to the history table
		String historysql = "insert into history(action, serial, time) values(?,?,?)";
		ps = conn.prepareStatement(historysql); // prepare a statement
		ps.setString(1, "un-assigned laptop " + l.getSerial() + " to user " + l.getuser());
		ps.setString(2, l.getSerial());
		ps.setString(3, new java.util.Date().toString() );
		ps.executeUpdate(); // execute
		
		ps.close();
		conn.close();
		
		return ok;
	}
	
	// search for serial, but return only one result
	public Laptop searchSerialID(String searchserial)throws SQLException{
		Laptop lap = null;
		
		String sql = "select * from laptopinventory where Serial = ? ";
		
		connect();
		
		// use a prepared statement
		PreparedStatement ps = conn.prepareStatement(sql); // prepare with the SQL
		ps.setString(1, searchserial); // set it with searchserial
		// execute and get ResultSet		
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String serial = rs.getString("Serial");
			String model = rs.getString("Model");
			String manuf = rs.getString("Manufacture").toLowerCase();
			String notes = rs.getString("notes");
			String assigned = rs.getString("assigned");
			if(assigned.equals("yes")) {
				String sql2 = "select username from assignedlaptop where laptopserial = ?  ";
				
				PreparedStatement ps2 = tempconn.prepareStatement(sql2);
				ps2.setString(1, serial);
				ResultSet rs2 = ps2.executeQuery();
				rs2.next();
				String username = rs2.getString("username");
				lap = new Laptop(serial, model, manuf, notes, assigned, username);
			}else {
				lap = new Laptop(serial, model, manuf, notes, assigned); // make a Laptop Object
			}
		}
				
		ps.close();
		rs.close();
		conn.close();
		
		return lap;
	}
	
	// search for laptop using serial, return a listing, more than one search
	public List<Laptop> searchSerial(String searchserial)throws SQLException{
		List<Laptop> laps = new ArrayList<Laptop>();
		
		String sql = "select * from laptopinventory where Serial like ? order by assigned";
		
		// connect to DB
		connect();
		// using PreparedStatement to init the sql statement
		PreparedStatement ps = conn.prepareStatement(sql);
		// want to use the like with the %:
		ps.setString(1, "%" + searchserial + "%");
		// execute query
		ResultSet rs = ps.executeQuery(); 
		// now loop through
		while(rs.next()) {
			String serial = rs.getString("Serial");
			String model = rs.getString("Model");
			String manuf = rs.getString("Manufacture");
			String notes = rs.getString("notes");
			String assigned = rs.getString("assigned");
			if(assigned.equals("yes")) {
				System.out.println("\nlaptop assigned :> YES\n");
				String sql2 = "select username from assignedlaptop where laptopserial = ?  ";
				
				PreparedStatement ps2 = tempconn.prepareStatement(sql2);
				ps2.setString(1, serial);
				ResultSet rs2 = ps2.executeQuery();
				rs2.next();
				String username = rs2.getString("username");
				Laptop lap = new Laptop(serial, model, manuf, notes, assigned, username);
				laps.add(lap);
			}else {
				Laptop lap = new Laptop(serial, model, manuf, notes, assigned);
				laps.add(lap);
			}
		}
		
		ps.close();
		rs.close();
		conn.close();
		
		return laps;
	}
	
	// search by model only
	public List<Laptop> searchModel(String modelsearch) throws SQLException{
		List<Laptop> laps = new ArrayList<>();
		
		String sql = "select * from laptopinventory where model like ? and assigned='no'";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, "%" + modelsearch + "%");
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String serial = rs.getString("Serial");
			String model = rs.getString("model");
			String manufacture = rs.getString("manufacture");
			String notes = rs.getString("notes");
			String assigned = rs.getString("assigned");
			Laptop lap = new Laptop(serial, model, manufacture, notes, assigned);
			laps.add(lap);
		}
		ps.close();
		rs.close();
		conn.close();
		
		return laps;
	}
	
	// search by notes
	public List<Laptop> searchNotes(String searchnotes) throws SQLException{
		List<Laptop> laps = new ArrayList<>();
		
		String sql = "select * from laptopinventory where notes like ? ";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, "%" + searchnotes + "%");
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String serial = rs.getString("Serial");
			String model = rs.getString("model");
			String manufacture = rs.getString("manufacture");
			String notes = rs.getString("notes");
			String assigned = rs.getString("assigned");
			Laptop lap = new Laptop(serial, model, manufacture, notes, assigned);
			laps.add(lap);
		}
		ps.close();
		rs.close();
		conn.close();
		
		return laps;
	}
	
	// search for the user assigned to laptop
	public List<Laptop> searchUser(String user) throws SQLException {
		List<Laptop> laps = new ArrayList<>();
		
		String sql = "select * from assignedlaptop where username like ?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, "%" + user + "%");
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String lapserial = rs.getString("laptopserial");
			String username = rs.getString("username");
			
			String sql2 = "select * from laptopinventory where serial = ?";
			PreparedStatement ps2 = tempconn.prepareStatement(sql2);
			ps2.setString(1, lapserial);
			ResultSet rs2 = ps2.executeQuery();
			rs2.next();
			String model = rs2.getString("Model");
			String manuf = rs2.getString("Manufacture");
			String notes = rs2.getString("notes");
			// Laptop(String serial, String model , String manuf, String notes, String assigned, String userassigned)
			Laptop la = new Laptop(lapserial, model, manuf, notes, "yes", username);
			laps.add(la);
		}
		rs.close();
		ps.close();
		conn.close();
		
		return laps;
	}
	
	// need to know how many laptops are not assigned, what we have on hand
	public int getUnAssigned() throws SQLException {
		int size = 0;
		
		String sql = "select count(*) from laptopinventory where assigned = 'no';";
		connect();
		// create a Statement, and execute SQL, and get a ResultSet
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);
		while(rs.next()) {
			size = rs.getInt(1);
		}
		
		
		rs.close();
		conn.close();
		
		return size;
	}
	
	
	// check credentials on the database
	public boolean checkLogin(String searchuname, String searchpassword) throws SQLException {
		boolean ok = false;
		
		String sql = "select uname, pass from login where uname=? and pass=?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, searchuname);
		ps.setString(2, searchpassword);
		
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			ok = true;
			
			String sqlinsert = "insert into loginfo(uname, time, notes) values(?,?, ?)";
			try {
				java.util.Date date = new java.util.Date();
				
				PreparedStatement ps2 = conn.prepareStatement(sqlinsert);
				ps2.setString(1, searchuname);
				ps2.setString(2, date.toString());
				ps2.setString(3, "logged in");
				int x  = ps2.executeUpdate();
				if(x > 0) {
					System.out.println("\nSuccess adding login \n");
				}else {
					System.out.println("\n Error adding login");
				}
			}catch(SQLException s) {
				System.err.println(s.getMessage());
			}
		}
		
		ps.close();
		rs.close();
		conn.close();
		
		return ok;
		
	}
	
	// log out user
	public void logout(String uname) throws SQLException {
		connect();
		
		String sqlinsert = "insert into loginfo(uname, time, notes) values(?,?, ?)";
		try {
			java.util.Date date = new java.util.Date();
			
			PreparedStatement ps2 = conn.prepareStatement(sqlinsert);
			ps2.setString(1, uname);
			ps2.setString(2, date.toString());
			ps2.setString(3, "logged out");
			int x  = ps2.executeUpdate();
			if(x > 0) {
				System.out.println("\nSuccess adding login \n");
			}else {
				System.out.println("\n Error adding login");
			}
			
			ps2.close();
			conn.close();
						
		}catch(SQLException s) {
			System.err.println(s.getMessage());
		}	
		
	}// end logout
	
	
	//create a memo, need memoID & laptop serials as array
	public void createMemo(String memoid, String[] serials) throws SQLException {
		String sql_memo = "insert into memo(MemoID, Date, State) values(?,?,?)";
		String sql_memos = "insert into memos(memoID, serial) values(?,?)";
		String state = "packed, on hand";
		
		connect();
		
		java.util.Date date = new java.util.Date();
		
		PreparedStatement ps = conn.prepareStatement(sql_memo);
		ps.setString(1, memoid);
		ps.setString(2, date.toString());
		ps.setString(3, state);
		int x = ps.executeUpdate();
		if(x > 0) {
			System.out.println("success adding memoID");
			String serial = "";
			ps = conn.prepareStatement(sql_memos);
			
			// need to update the notes field, get the notes
			String sql_getNotes = "select notes from laptopinventory where Serial= ?";
			String sql_updateNotes = "update laptopinventory set notes=? where Serial=?";
			// loop through serials , and update the memo and notes fields
			for(int i =0; i < serials.length; i++) {
				
				String notes = "";
				PreparedStatement ps2 = tempconn.prepareStatement(sql_getNotes);
				
				serial = serials[i].trim();
				ps.setString(1, memoid);
				ps.setString(2, serial);
				ps.executeUpdate();
				
				ps2.setString(1, serial);
				ResultSet rs = ps2.executeQuery();
				rs.next();
				notes = rs.getString("notes");
				notes = notes + " :: added to Memo ID " + memoid;
				PreparedStatement ps3 = tempconn.prepareStatement(sql_updateNotes);
				ps3.setString(1, notes);
				ps3.setString(2, serial);
				int success = ps3.executeUpdate();
				if(success > 0) {
					System.out.println("success updating notes");
				}else
					System.out.println("failed to update notes");
					
			}
			ps.close();
			conn.close();
		}else
			System.out.println("error creating memoID");		
	}
	
	// get all memo listing
	public ArrayList getMemos() throws SQLException {
		ArrayList<Memo> listing = new ArrayList<Memo>();
		
		String sql = "select * from memo";
		
		connect();
		
		// create a statement, and execute SQL
		Statement st = conn.createStatement();
		ResultSet rs = st.executeQuery(sql);
		while(rs.next()) {
			String memoid = rs.getString("MemoID");
			String date = rs.getString("Date");
			String state = rs.getString("State");
			String fedex = rs.getString("FedEx");
			Memo mem = new Memo(memoid);
			mem.setDate(date);
			mem.setState(state);
			mem.setFedex(fedex);
			System.out.println("Memo: " + mem);
			
			listing.add(mem);
		}
		
		st.close();
		rs.close();
		conn.close();
		
		return listing;
	}
	
	// search the memo table for the serial#, get the memoID
	public String getMemoID(String serial) throws SQLException {
		String memoid = "";
		
		String sql = "select memoID, serial from memos where serial=?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, serial);
		ResultSet rs = ps.executeQuery();
		if(rs.next()) {
			memoid = rs.getString("memoID");
		}else {
			memoid = "nothing";
		}
		
		return memoid;
		
	}
	
	public void getMemoID(String[] serials) {
		
	}
	
	// check if memoID exists in DB
	public boolean isMemoIDExist(String memoid)throws SQLException{
		boolean ok = false;
		System.out.println("checking if memoID exists: " + memoid);
		
		String sql = "select MemoID from memo where MemoID = ?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, memoid);
		ResultSet rs = ps.executeQuery();
		// check if ResultSet is empty or not
		if( rs.next() == false) {
			System.out.println("resultset empty");
			// means the memoid doesn't exist
			ok = false;
		}else {
			System.out.println("resultset not empty");
			ok = true;
		}
			
		return ok;
	}
	
	
	// get a Memo Object
	public Memo getMemo(String memoid) throws SQLException {
		Memo mem = new Memo();
		
		String sql = "select * from memo where MemoID=?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, memoid);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String date = rs.getString("Date");
			String state = rs.getString("State");
			String fedex = rs.getString("FedEx");
			
			mem.setDate(date);
			mem.setState(state);
			mem.setFedex(fedex);
		}
		
		System.out.println("getMemo: " + mem);
		
		return mem;
	}
	
	// search for a memoID
	public ArrayList<Laptop> searchMemoID(String memoid) throws SQLException {
		ArrayList<Laptop> laps = new ArrayList<>();
		
		String sql = "select laptopinventory.Serial, laptopinventory.Model, laptopinventory.Manufacture, laptopinventory.notes, laptopinventory.assigned, memos.memoID from inteldb.laptopinventory, inteldb.memos where memos.serial = laptopinventory.Serial and memos.MemoID = ?";
		
		connect();
		String serial = "" ;
		String model = "";
		String manuf = "";
		String notes = "";
		String assig = "";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, memoid);
		ResultSet rs = ps.executeQuery();
		
		while(rs.next()) {
			serial = rs.getString("Serial");
			 model = rs.getString("Model");
			 manuf = rs.getString("Manufacture");
			 notes = rs.getString("notes");
			 assig = rs.getString("assigned");
			 Laptop la = new Laptop(serial, model, manuf, notes, assig);
			 laps.add(la);			 
		}
		
		if(laps.isEmpty()) {
			laps.clear();
			System.out.println("\nlaps is empty\n");
			String sql2 = "select serial from memos where memoID = ?";
			ps = conn.prepareStatement(sql2);
			ps.setString(1, memoid);
			rs = ps.executeQuery();
			while(rs.next()) {
				String aserial = rs.getString("serial");
				Laptop la = new Laptop(aserial);
				laps.add(la);
			}
		}
		
		rs.close();
		ps.close();
		conn.close();
		
		return laps;
		
	}
	
	// memo is Tranist. need a fedex# , remove the laptops in the memo from the laptop inventory
	// since those laptops are shipped out, and no longer on hand
	public boolean memoinTransit(String memoid, String fedex) throws Exception{
		boolean ok = false;
		
		String sql_update_memo = "update memo set State=?, FedEx=? where MemoID=?";
		String state = "in transit";
		
		connect();
		
		// first update the memo table with state and fedex tracking
		PreparedStatement ps = conn.prepareStatement(sql_update_memo);
		ps.setString(1, state);
		ps.setString(2, fedex);
		ps.setString(3, memoid);
		ok = ps.executeUpdate() > 0;
		
		// now get the serials listed in memos,
		String sql_getSerials = "select serial from memos where memoID=?";
		ps = conn.prepareStatement(sql_getSerials);
		ps.setString(1, memoid);
		ResultSet rs = ps.executeQuery();
		while(rs.next()) {
			String serial = rs.getString("serial");
			delete(serial); // call the delete to remove from inventory
		}
		
		ps.close();
		conn.close();
		
		return ok;
	}
	
	// update Memo with a FedEx#, maybe still on hand, haven't shipped out yet
	public boolean updateMemo(String memoid, String fedex)throws Exception{
		boolean ok = false;
		
		String sql_update_memo = "update memo set FedEx=? where MemoID=?";
		
		System.out.println("calling connect from updateMemo...");
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql_update_memo);
		ps.setString(1, fedex);
		ps.setString(2, memoid);
		ok = ps.executeUpdate() > 0;
		
		ps.close();
		conn.close();
		
		return ok;
	}
	
	// memo delivered
	public boolean memoDelivered(String memoid) throws SQLException {
		boolean ok = false;
		
		String sql = "update memo set State=? where MemoID=?";
		
		connect();
		
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setString(1, "Delivered");
		ps.setString(2, memoid);
		ok = ps.executeUpdate() > 0;
		
		ps.close();
		conn.close();
		
		return ok;
	}
	
	// change a memo state, info provided by client
	// State: in transit, delivered
	public boolean memoState(String memoid, String state) {
		boolean ok = false;
		
		String sql_update_memo = "update memo set State=? where MemoID=?";
		
		
		
		return ok;
	}
	
	// process a csv file
	public boolean processFile(File afile) {
		boolean ok = false;
		
		try {
			if( afile.canRead() )
				System.out.println("can read");
			String filename = afile.getName();
			System.out.println("file name: " + filename );
			System.out.println("dir: " + afile.getAbsolutePath());
			String ext = getExt(afile);
			if(ext.equals("csv")) {
				System.out.println("csv file");
				try {
					BufferedReader buff = new BufferedReader(new FileReader(afile)) ;
					String line = null;
					int linecount =0;
					int headerline = 0; // header line is the first line
					int headercols; // number of columns
					while( (line = buff.readLine()) != null ) {
						if(headerline == 0) {
							String[] headsplit = line.split("[,]");
							headercols = headsplit.length;
							System.out.println("number of columns: " + headercols);
							headerline ++;
						}else {
							String[] splitup = line.split("[,]"); // split line by , 
							String serial = splitup[0];
							String model = splitup[1];
							String manuf = splitup[2];
							System.out.println("serial: " + serial);
							System.out.println("model: " + model);
							System.out.println("Manufacture: " + manuf);
							
							if ( addLaptop(serial, model, manuf) == true)
								ok = true;
							
						}
					}
				}catch(Exception e) {
					System.err.println("error " + e.getMessage());
				}
			}else {
				System.out.println("not csv file");
			}
		}catch(Exception e) {
			System.err.println("error in Thread ProcessFile \n" + e.getMessage());
		}
		
		return ok;
	}
	
	private String getExt(File f) {
		String ext = "";
		
		char dot = '.';
		String filename = f.getName();
		int doti = filename.lastIndexOf(dot);
		ext = filename.substring(doti+1);
		
		return ext;
	}
	
}
