<%@ Application Language="C#" %>

<script RunAt="server">

    private void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
    }

    private void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown
    }

    private void Application_Error(object sender, EventArgs e)
    {
        //Server.GetLastError();
        //Response.Redirect("Error.aspx");
        //Server.ClearError();
    }

    private void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started
    }

    private void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.
    }

</script>