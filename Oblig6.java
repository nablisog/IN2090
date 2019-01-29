import java.sql.*;
import java.util.*;

public class TimelisteDb {
    private Connection connection;

    public TimelisteDb(Connection connection) {
        this.connection = connection;
    }
    public void printTimelister() throws SQLException {
      try{

        Statement stm = connection.createStatement();
        String spør = "SELECT timelistenr,status,beskrivelse FROM tliste";
        ResultSet r = stm.executeQuery(spør);
        while(r.next()){
          System.out.println(r.getInt("timelistenr") +" "+ r.getString("status") +" "+ r.getString("beskrivelse"));
        }
      }
      catch(SQLException e){
        e.printStackTrace();
      }
    }


    public void printTimelistelinjer(int timelisteNr) throws SQLException {

      String s = " SELECT * FROM tlistelinje  WHERE timelistenr = ? " ;
      try{
        PreparedStatement stm = connection.prepareStatement(s);
        stm.setInt(1, timelisteNr);
        ResultSet rs = stm.executeQuery();
        while(rs.next()){
          int linjeNr = rs.getInt("linjenr");
          int timeantall = rs.getInt("timeantall");
          String  beskrivelse = rs.getString("beskrivelse");
          int kumulativt_timeantall = rs.getInt("kumulativt_timeantall");
          System.out.println(linjeNr + "  " + timeantall+"   "+beskrivelse+" "+ kumulativt_timeantall);

        }
      }
      catch(SQLException e){
        e.printStackTrace();
      }
    }


    public double medianTimeantall(int timelisteNr) throws SQLException {
      String s = "SELECT timeantall FROM tlistelinje WHERE timelistenr = ? ORDER BY timeantall";
      try{

        PreparedStatement stm = connection.prepareStatement(s);
        stm.setInt(1, timelisteNr);
        ResultSet rs = stm.executeQuery();
        ArrayList<Integer> list = new ArrayList<>();
        while(rs.next()){
          int timeantall = rs.getInt("timeantall");
          list.add(timeantall);

        }
        return(median(list));

      }
      catch(SQLException e){
        e.printStackTrace();
      }

        return 0;
    }

    public void settInnTimelistelinje(int timelisteNr, int antallTimer, String beskrivelse) throws SQLException {

      try{
        String spør = " INSERT into tlistelinje "
                      + " (timelistenr, linjenr, timeantall, beskrivelse,)"
                      + " VALUES (?,(SELECT MAX(linjenr)+1 FROM tlistelinje WHERE timelistenr = ?), ?, ?)";

        PreparedStatement stm = connection.prepareStatement(spør);
        stm.setInt(1, timelisteNr);
        stm.setInt(2, antallTimer);
        stm.setString(3, beskrivelse);
        stm.UpdaQuery();
      }
      catch(SQLException e){
        e.printStackTrace();
      }

    }

    public void regnUtKumulativtTimeantall(int timelisteNr) throws SQLException {

      String s = "SELECT linjenr, timeantall FROM tlistelinje  WHERE timelistenr = ?  ORDER BY linjenr";
      try{
        PreparedStatement stm = connection.prepareStatement(s);
        stm.setInt(1, timelisteNr);
        ResultSet rs = stm.executeQuery();
        int sum = 0;
        String sql = " UPDATE tlistelinje "
                     + " SET kumulativt_timeantall = ? "
                     + " WHERE timelistenr = ? AND linjenr = ? ";

        PreparedStatement ss = connection.prepareStatement(sql);
        while(rs.next()){
          sum = sum + rs.getInt("timeantall");
          int c = rs.getInt("linjenr");
          ss.setInt(1, sum);
          ss.setInt(2, timelisteNr);
          ss.setInt(3, c);
          ss.executeUpdate();

        }
      }
      catch(SQLException e){
        e.printStackTrace();
      }

    }

    
    private double median(List<Integer> list) {
        int length = list.size();
        if (length % 2 == 0) {
            return (list.get(length / 2) + list.get(length / 2 - 1)) / 2.0;
        } else {
            return list.get((length - 1) / 2);
        }}

}
