using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Default : Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack) return;
        if (CreateSession())
        {
            
            Server.Transfer("Store.aspx");
        }
        LoginError();
    }

    private void LoginError()
    {
        
        lblError.Text = "Invalid username and password combination";
        lblError.Visible = true;
        validation_results.Visible = true;
        
    }

    protected bool CreateSession(string userName = "", string password = "")
    {
        HttpCookie retrieveCookie = Request.Cookies["portal"];
        using (var db = new VodacDataContext())
        {
            if (retrieveCookie == null)
            {
                IQueryable<User> users = db.Users.Where(u => u.Name == userName && u.Password == password);

                if (users.Any())
                {
                    var userId = users.FirstOrDefault().Id.ToString();
                    var createCookie = new HttpCookie("portal");
                    createCookie.Values.Add("UserId", userId);
                    createCookie.Expires = DateTime.Now.AddDays(30);
                    Response.Cookies.Add(createCookie);

                    Session["Users"] = users.FirstOrDefault();

                    return true;
                }
            }
            else
            {
                if (!String.IsNullOrEmpty(retrieveCookie.Values["userid"]))
                {
                    int userId = Convert.ToInt32(retrieveCookie.Values["userid"]);
                    IQueryable<User> users = db.Users.Where(u => u.Id == userId);

                    Session["Users"] = users.FirstOrDefault();

                    return true;
                }
            }
        }


        return false;
    }

    protected void Login_OnAuthenticate(object sender, AuthenticateEventArgs e)
    {
        string username = Server.HtmlEncode(Login.UserName);
        string password = Server.HtmlEncode(Login.Password);

        if (CreateSession(username, password))
        {
            Server.Transfer("Store.aspx");
        }
        LoginError();
    }
}