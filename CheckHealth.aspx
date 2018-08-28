<%@ Page Language="C#" %>
<%--<%@ 
    Created:    27/08/2018
    Version:    1.0
    Author:     The Lego SCCM Guy

    Disclaimer:
This script is provided "AS IS" with no warranties, confers no rights and 
is not supported by the author.

Author - The Lego SCCM Guy
    Twitter: @LEGOSCCMGUY 
    Blog   : http://legosccmguy.wordpress.com 



Code to Be Added to web.config
Only add the relevant section as required to an existing web.config file.

<configuration>
  <system.web>
    <compilation debug="false" targetFramework="4.0">
      <assemblies>
        <add assembly="System.ServiceProcess, Version=4.0.0.0, Culture=neutral, PublicKeyToken=B03F5F7F11D50A3A"/>
      </assemblies>
    </compilation>
    <httpRuntime/>
  </system.web>
</configuration>
    
    
    %>--%>
<!DOCTYPE html>

<script runat="server">
    public int FailureCnt = 0;

    public void ServiceHealth(string ServiceName)
    {
        try
        {

            System.ServiceProcess.ServiceController sc = new System.ServiceProcess.ServiceController(ServiceName);
            Response.Write("<br>Checking Service Status: " + ServiceName);
            switch (sc.Status)
            {
                case System.ServiceProcess.ServiceControllerStatus.Running:
                    Response.Write(" - <font color='green'>Pass</font>" + Environment.NewLine);
                    break;
                default:
                    Response.Write(" - <font color='red'>FAIL</font>" + Environment.NewLine);
                    FailureCnt = FailureCnt + 1;
                    break;
            }
        }
        catch
        {
            Response.Write(" - <font color='red'>FAIL - Service Missing</font>" + Environment.NewLine);
            FailureCnt = FailureCnt + 1;
        }
    }
</script>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Service Health</title>
</head>
<body>
    <%
        //for Each Service you wish to test add another line below here and put the Display name of the service in the parameter.
        ServiceHealth("DNS Client");
        ServiceHealth("DNS Client2");
        ServiceHealth("DHCP Server");
        if (FailureCnt == 0 )
        {
            Response.Write("<font color='green'><br>Server OK!</font>");
        }
        else
        {
            Response.Status = "202 Accepted";
            Response.Write("<font color='red'><br>Server Error</font>");
        }
    %>
</body>
</html>
