using System;
using System.Configuration;
using System.Linq;
using System.Net.Mail;
using System.Web.Configuration;

public partial class ForgotPassword : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void SendEmail(object sender, EventArgs e)
    {
        using (var db = new VodacDataContext())
        {
            var user = (from u in db.Users
                        where u.Email == txtEmail.Text.Trim()
                        select u).FirstOrDefault();


            if (user == null || String.IsNullOrEmpty(user.Email))
            {
                lblError.Text = "Your email address could not be found";
                lblError.Visible = true;
                validation_results.Visible = true;
            }
            else
            {
                try
                {
                    var host = ConfigurationManager.AppSettings["emailhost"].ToString().Trim();
                    var from = ConfigurationManager.AppSettings["from"].ToString().Trim();
                    var to = user.Email;

                    var client = new SmtpClient(host, 25);
                    client.SendCompleted += client_SendCompleted;
                    var mailMessage = new MailMessage(from, to)
                    {
                        Subject = "SOP Password Reminder",
                        Body = String.Format("Thank you for using the Vodacom SOP password re-set utility\r\n\r\nYour username {0}, password is: {1}", user.Name, user.Password)
                    };
                    client.Send(mailMessage);

                    lblError.Text = String.Format("Your password have been mailed to {0}", txtEmail.Text);
                    lblError.Visible = true;
                    validation_results.Visible = true;
                }
                catch (Exception)
                {
                    lblError.Text = "Error occured sending the email";
                    lblError.Visible = true;
                    validation_results.Visible = true;
                }

            }
        }
    }

    void client_SendCompleted(object sender, System.ComponentModel.AsyncCompletedEventArgs e)
    {
        lblSendComplete.Text = String.Format("Your password have been mailed to {0}", txtEmail.Text);
    }
}