using System;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class AccessoryPage : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var user = Session["Users"] as User;
        if (user == null)
        {
            Server.Transfer("Login.aspx");
        }
    }

    protected void DoSearch(object sender, EventArgs e)
    {
        var button = sender as Button;
        if (button != null && button.Text == "Reset")
            txtSeach.Text = String.Empty;
        else
            txtSeach.Text = txtSeach.Text.Trim();

        gvAccessories.DataBind();
    }
}