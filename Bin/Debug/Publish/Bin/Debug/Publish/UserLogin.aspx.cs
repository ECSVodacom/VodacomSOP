using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class UserLogin : Page
{
    public enum Action
    {
        Add = 1,
        Delete,
        Update
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Page.IsPostBack) return;
        var user = Session["Users"] as User;
        if (user == null)
        {
            Server.Transfer("Login.aspx");
        }
    }

    private void ClearErrorMessage()
    {
        txtUserName.Text = String.Empty;
        txtEmailAddress.Text = String.Empty;
        txtPassword.Text = String.Empty;
        lblError.Text = String.Empty;
        lblError.Visible = false;
        validation_results.Visible = false;
    }

    public bool IsUserDuplicate(User checkUser, int occurance)
    {
        if (checkUser.Name == String.Empty || checkUser.Name == String.Empty)
        {
            lblError.Text = "Please enter valid Username";
            lblError.Visible = true;
            validation_results.Visible = true;

            return true;
        }

        using (var db = new VodacDataContext())
        {
            var userName = db.Users.Where(b => b.Name == checkUser.Name);
            var errorMessage = String.Empty;


            if (userName.Count() > occurance)
            {
                errorMessage = String.Format("<b>{3}</b> - UserName already exist");
            }

            if (!String.IsNullOrEmpty(errorMessage))
            {
                lblError.Text = errorMessage;
                lblError.Visible = true;
                validation_results.Visible = true;

                return true;
            }
            else
            {
                ClearErrorMessage();

                return false;
            }
        }
    }


    protected void gvUser_OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string id = e.Keys["Id"].ToString();
        using (var db = new VodacDataContext())
        {
            User user = (db.Users.Where(b => b.Id.ToString() == id)).FirstOrDefault();

            db.Users.DeleteOnSubmit(user);
            db.SubmitChanges();

            lblError.Text = String.Format("<b>{3}</b> - User has been deleted");
            lblError.Visible = true;
            validation_results.Visible = true;
        }

        gvUser.EditIndex = -1;
    }

    protected void gvUser_OnRowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvUser.EditIndex = -1;
        gvUser.DataBind();
    }

    protected void DoSearch(object sender, EventArgs e)
    {
        var button = sender as Button;
        if (button != null && button.Text == "Reset")
        {
            txtUserName.Text = String.Empty;
            ClearErrorMessage();
        }
        else
            txtUserName.Text = txtUserName.Text.Trim();



        gvUser.DataBind();
    }

    protected void gvUser_OnRowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        int id = Convert.ToInt32(e.Keys["Id"].ToString());

        using (var db = new VodacDataContext())
        {
            User existingRecord = db.Users.SingleOrDefault(record => record.Id == id);

            if (existingRecord != null)
            {
                existingRecord.Name = e.NewValues["Name"].ToString().Trim();
                existingRecord.Email = e.NewValues["Email"].ToString().Trim();

                db.SubmitChanges();
            }
        }
    }


    protected void DoAdd(object sender, EventArgs e)
    {
        using (var db = new VodacDataContext())
        {
            var user = new User
                {
                    Name = txtUserName.Text.Trim().ToUpper(),
                    Email = txtEmailAddress.Text.Trim(),
                    Password = txtPassword.Text.Trim()
                };

                db.Users.InsertOnSubmit(user);
                db.SubmitChanges();

                gvUser.DataBind();

                lblError.Text = String.Format("New User has been created");
                lblError.Visible = true;
                validation_results.Visible = true;

            ClearErrorMessage();
        }
    }


    protected void gvUser_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.DataItem == null) return;
        var user = (User)e.Row.DataItem;

        using (var db = new VodacDataContext())
        {
            var u = from al in db.Users
                           orderby al.Id descending
                           select new
                           {
                               al.Id,
                               al.Name,
                               al.Email,
                               al.Password
                           };


            var gvUser = (GridView)e.Row.FindControl("gvUser");
            //gvUser.DataSource = u;
            //gvUser.DataBind();
        }
    }
}