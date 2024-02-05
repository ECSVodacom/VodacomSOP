using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ProductPage : Page
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

        gvProduct.DataBind();
    }

    protected void gvProduct_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.DataItem == null) return;
        var product = (Product) e.Row.DataItem;

        using (var db = new VodacDataContext())
        {
            var accessories = from lmp in db.Link_Product_Accessories
                              join r in db.Retailers on lmp.RetailerId equals r.Id
                              join a in db.Accessories on lmp.AccessoryId equals a.Id
                              where lmp.ProductId == product.Id
                              select new {r.Name, r.DAccount, a.ProductCode, a.Description};

            var gvAccessories = (GridView) e.Row.FindControl("gvAccessories");
            gvAccessories.DataSource = accessories;
            gvAccessories.DataBind();
        }
    }
}