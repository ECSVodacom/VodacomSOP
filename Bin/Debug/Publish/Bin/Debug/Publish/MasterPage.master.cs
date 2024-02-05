using System;
using System.Web;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void LogOff(object sender, EventArgs e)
    {
        HttpCookie retrieveCookie = Request.Cookies["portal"];
        if (retrieveCookie != null)
        {
            retrieveCookie.Expires = DateTime.Now.AddDays(-1d);
            Response.SetCookie(retrieveCookie);
        }
        Session.Remove("Users");
        Session.Clear();
        Server.Transfer("Login.aspx");
    }
}