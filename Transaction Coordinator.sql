using System;
using System.EnterpriseServices;
using System.Reflection;
using DDTek.SQLServer;
[assembly: ApplicationName("yourapplicationname")]
[assembly: AssemblyKeyFileAttribute(@"..\..\yourapplicationname.snk")]
namespace DistTransaction
{
/// <summary>
/// Summary description for Class1.
/// </summary>
public class Class1
{
/// <summary>
/// The main entry point for the application.
/// </summary>
[STAThread]
static void Main(string[] args)
{
SQLServerConnection Conn1;
Conn1 = new SQLServerConnection("host=nc-star;port=1433;
User ID=test01;Password=test01;
Database Name=Test;Enlist=true");
SQLServerConnection Conn2;
Conn2 = new SQLServerConnection("host=nc-star;port=1433;
User ID=test07;Password= test07;
Database Name=test;Enlist=true");
try
{
DistributedTran myDistributedTran = new DistributedTran();
myDistributedTran.TestDistributedTransaction(Conn1, Conn2);
Console.WriteLine("Success!!");
}
catch (Exception e)
{
System.Console.WriteLine("Error returned: " + e.Message);
}
}
}
/// <summary>
/// To use distributed transactions in .NET, we need a ServicedComponent
/// derived class with transaction attribute declared as "Required".
/// </summary>
[Transaction(TransactionOption.Required) ]
public class DistributedTran : ServicedComponent
{
/// <summary>
/// This method executes two SQL statements.
/// If both are successful, both are committed by DTC after the
/// method finishes. However, if an exception is thrown, both will be
/// rolled back by DTC.
/// </summary>
[AutoComplete]
public void TestDistributedTransaction(SQLServerConnection Conn1,
SQLServerConnection Conn2)
{
// The following Insert statement goes to the first server, orca.
// This Insert statement does not produce any errors.
string DBCmdSql1 = "Insert into emp VALUES
(16,'HAYES','ADMIN',6,'17-NOV-2002',18000,
NULL,4)";
string DBCmdSql2 = "Delete from emp WHERE sal > 100000";
try
{
Conn1.Open();
Conn2.Open();
Console.WriteLine ("Connection successful!");
}
catch (Exception ex)
{
// Connection failed
Console.WriteLine(ex.Message);
return;
}
SQLServerCommand DBCmd1 = new SQLServerCommand(DBCmdSql1, Conn1);
SQLServerCommand DBCmd2 = new SQLServerCommand(DBCmdSql2, Conn2);
DBCmd1.ExecuteNonQuery();
DBCmd2.ExecuteNonQuery();
Conn1.Close();
Conn2.Close();
Console.WriteLine("Success!! ");
}
}
}
