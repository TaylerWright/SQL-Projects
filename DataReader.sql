Open connection to SQL Server database
SQLServerConnection Conn;
try
{
Conn = new SQLServerConnection("host=nc-star;port=1433;
User ID=test01;Password=test01; Database Name=Test");
Conn.Open();
Console.WriteLine ("Connection successful!");
}
catch (Exception ex)
{
// Connection failed
Console.WriteLine(ex.Message);
return;
}
try
{
// Create a SQL command
string strSQL = "SELECT ename FROM emp WHERE sal>50000";
SQLServerCommand DBCmd = new SQLServerCommand(strSQL, Conn);
SQLServerDataReader myDataReader;
myDataReader = DBCmd.ExecuteReader();
while (myDataReader.Read())
{
Console.WriteLine("High salaries: " + myDataReader["ename"].ToString());
}
myDataReader.Close();
// Close the connection
Conn.Close();
}
catch (Exception ex)
{
Console.WriteLine(ex.Message);
return;
}
