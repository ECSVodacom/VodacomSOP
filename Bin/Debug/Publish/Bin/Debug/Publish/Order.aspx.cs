using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Order : Page
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

        gvOrders.DataBind();
    }

    protected void OrdersDataSource_Selecting(object sender, LinqDataSourceSelectEventArgs e)
    {
        var db = new VodacDataContext();
        e.Result = (from oh in db.OrderHistories
                    orderby oh.Id descending
                    select oh).Take(50);
    }
}