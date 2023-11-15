// Open connection to SQL Server database
SQLServerConnection Conn;
Conn = new SQLServerConnection("host=nc-star;port=4100;User ID=test01;
Password=test01;Database Name=Test");
try
{
Conn.Open();
Console.WriteLine ("Connection successful!");
}
catch (Exception ex)
{
// Connection failed
Console.WriteLine(ex.Message);
return;
}
// Make a command object
SQLServerCommand salCmd = new SQLServerCommand("select count(sal) from emp
where sal>50000",Conn);
try
{
int count = (int)salCmd.ExecuteScalar();
Console.WriteLine("Count of Salaries >$50,000 : "
+ Convert.ToString(count));
}
catch (Exception ex)
{
// Display any exceptions
Console.WriteLine(ex.Message);
}
