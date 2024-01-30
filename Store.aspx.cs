using System;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;



public partial class Store : Page
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
        txtAddLAccount.Text = String.Empty;
        txtAddStoreCode.Text = String.Empty;
        lblError.Text = String.Empty;
        lblError.Visible = false;
        validation_results.Visible = false;
    }

    public bool IsBranchDuplicate(Branch checkBranch, int occurance)
    {
        if (checkBranch.LAccount == String.Empty || checkBranch.StoreCode == String.Empty)
        {
            lblError.Text = "Please enter valid store code and/or l account";
            lblError.Visible = true;
            validation_results.Visible = true;

            return true;
        }

        using (var db = new VodacDataContext())
        {
            var lAccountBranch = db.Branches.Where(b => b.LAccount == checkBranch.LAccount);
            var storeCodeBranch = db.Branches.Where(b => b.StoreCode == checkBranch.StoreCode);
            var errorMessage = String.Empty;


            if (lAccountBranch.Count() > occurance)
            {
                errorMessage = String.Format("<b>{3}</b> - L Account {0} already linked to store code {1} for retailer {2}", checkBranch.LAccount, lAccountBranch.FirstOrDefault().StoreCode, lAccountBranch.FirstOrDefault().Retailer.Name, DateTime.Now.ToString("HH:mm:ss"));
            }

            if (storeCodeBranch.Count() > occurance)
            {
                errorMessage = String.Format("<b>{3}</b> - Store code {0} already linked to l account {1} for retailer {2}<br />", checkBranch.StoreCode, storeCodeBranch.FirstOrDefault().LAccount, storeCodeBranch.FirstOrDefault().Retailer.Name, DateTime.Now.ToString("HH:mm:ss"));
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


    protected void gvStore_OnRowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        string id = e.Keys["Id"].ToString();
        using (var db = new VodacDataContext())
        {
            Branch branch = (db.Branches.Where(b => b.Id.ToString() == id)).FirstOrDefault();


            if (branch != null)
            {
                var auditLog = new AuditLog
                    {
                        BranchId = branch.Id,
                        ActionId = (int)Action.Delete,
                        LAccount = branch.LAccount,
                        CreatedAt = DateTime.Now,
                        StoreCode = branch.StoreCode,
                        RetailerId = branch.RetailerId,
                        UserId = ((User)Session["Users"]).Id
                    };

                db.AuditLogs.InsertOnSubmit(auditLog);
                db.Branches.DeleteOnSubmit(branch);
            }

            db.SubmitChanges();


            lblError.Text = String.Format("<b>{3}</b> - Store code {0} with l account {1} for retailer {2} deleted", branch.StoreCode, branch.LAccount, branch.Retailer.Name, DateTime.Now.ToString("HH:mm:ss"));
            lblError.Visible = true;
            validation_results.Visible = true;
        }

        gvStore.EditIndex = -1;
    }

    protected void gvStore_OnRowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        gvStore.EditIndex = -1;
        gvStore.DataBind();
    }

    protected void DoSearch(object sender, EventArgs e)
    {
        var button = sender as Button;
        if (button != null && button.Text == "Reset")
        {
            txtStoreSearch.Text = String.Empty;
            ClearErrorMessage();
        }
        else
            txtStoreSearch.Text = txtStoreSearch.Text.Trim();



        gvStore.DataBind();
    }

    protected void gvStore_OnRowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        string id = e.Keys["Id"].ToString();

        using (var db = new VodacDataContext())
        {
            Branch branch = (db.Branches.Where(b => b.Id.ToString() == id)).FirstOrDefault();

            if (branch == null) return;
            var auditLog = new AuditLog
                {
                    BranchId = branch.Id,
                    ActionId = (int)Action.Update,
                    StoreCode = e.NewValues["StoreCode"].ToString().Trim(),
                    LAccount = e.NewValues["LAccount"].ToString().Trim(),
                    PreviousStoreCode = e.OldValues["StoreCode"].ToString().Trim(),
                    PreviousLAccount = e.OldValues["LAccount"].ToString().Trim(),
                    CreatedAt = DateTime.Now,
                    RetailerId = branch.RetailerId,
                    UserId = ((User)Session["Users"]).Id,
                };

            int newRetailerId = Convert.ToInt32(e.NewValues["Retailer.Id"].ToString());
            branch.RetailerId = newRetailerId;
            branch.StoreCode = e.NewValues["StoreCode"].ToString().Trim();
            branch.LAccount = e.NewValues["LAccount"].ToString().Trim();

            e.ExceptionHandled = true;

            if (!IsBranchDuplicate(branch, 1))
            {
                db.AuditLogs.InsertOnSubmit(auditLog);
                db.SubmitChanges();


                lblError.Text = String.Format("<b>{3}</b> - Store code {0} with l account {1} for retailer {2} updated", branch.StoreCode, branch.LAccount, branch.Retailer.Name, DateTime.Now.ToString("HH:mm:ss"));
                lblError.Visible = true;
                validation_results.Visible = true;
            }



        }
    }


    protected void DoAdd(object sender, EventArgs e)
    {


        using (var db = new VodacDataContext())
        {
            var branch = new Branch
                {
                    LAccount = txtAddLAccount.Text.Trim().ToUpper(),
                    StoreCode = txtAddStoreCode.Text.Trim(),
                    RetailerId = Convert.ToInt32(ddlAddDAcccount.SelectedValue)
                };

            if (!IsBranchDuplicate(branch, 0))
            {
                db.Branches.InsertOnSubmit(branch);
                db.SubmitChanges();

                var auditLog = new AuditLog
                    {
                        BranchId = branch.Id,
                        ActionId = (int)Action.Add,
                        StoreCode = branch.StoreCode,
                        LAccount = branch.LAccount.ToUpper(),
                        CreatedAt = DateTime.Now,
                        RetailerId = branch.RetailerId,
                        UserId = ((User)Session["Users"]).Id,
                    };
                db.AuditLogs.InsertOnSubmit(auditLog);
                db.SubmitChanges();

                gvStore.DataBind();


                lblError.Text = String.Format("<b>{3}</b> - New store code {0} with l account {1} for retailer {2} added", branch.StoreCode, branch.LAccount, branch.Retailer.Name, DateTime.Now.ToString("HH:mm:ss"));
                lblError.Visible = true;
                validation_results.Visible = true;
            }
        }
    }


    protected void gvStore_OnRowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.DataItem == null) return;
        var branch = (Branch)e.Row.DataItem;

        using (var db = new VodacDataContext())
        {
            var auditLog = from al in db.AuditLogs
                           join u in db.Users on al.UserId equals u.Id
                           join a in db.Actions on al.ActionId equals a.Id
                           where al.BranchId == branch.Id
                           orderby al.Id descending
                           select new
                               {
                                   al.CreatedAt,
                                   al.PreviousLAccount,
                                   al.PreviousStoreCode,
                                   a.Value,
                                   u.Name
                               };


            var gvAuditLog = (GridView)e.Row.FindControl("gvAuditLog");
            gvAuditLog.DataSource = auditLog;
            gvAuditLog.DataBind();
        }
    }
}