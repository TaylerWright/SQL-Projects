// Define an event handler
public void myHandler(object sender, SQLServerInfoMessageEventArgs e)
{
// Display any warnings
Console.WriteLine ("Warning Returned: " + e.Message);
}
Add the following code to a method and call it:
SQLServerConnection Conn;
Conn = new SQLServerConnection("host=nc-star;port=4100;User ID=test01;
Password=test01;Database Name=Test");
SQLServerCommand DBCmd = new SQLServerCommand
("print 'This is a Warning.'",Conn);
SQLServerDataReader myDataReader;
try
{
Conn.InfoMessage += new SQLServerInfoMessageEventHandler(myHandler);
Conn.Open();
myDataReader = DBCmd.ExecuteReader();
// This will throw a SQLServerInfoMessageEvent as the print
// statement generates a warning.
}
catch (Exception ex)
{
// Display any exceptions in a messagebox
MessageBox.Show (ex.Message);
}
// Close the connection
Conn.Close();
