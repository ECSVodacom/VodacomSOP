<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="ForgotPassword.aspx.cs" Inherits="ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    Forgot password
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Forgot password</h1>
    <p>
        To retrieve your password please enter your email address.
    </p>
    <div class="error" id="validation_results" runat="server" visible="False">
        <asp:Label ID="lblError" runat="server" Visible="False"></asp:Label>
    </div>
    <div>
        <fieldset>
            <form id="form1" runat="server">
                <div class="element_group">
                    <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail" Text="Email:"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                    <asp:Label ID="lblSendComplete" runat="server" Text=""></asp:Label>
                </div>
                <div class="action_items">
                    <p>
                        <asp:Button ID="Submit" runat="server" CommandName="Submit" Text="Submit" OnClick="SendEmail"
                            ValidationGroup="Login" ForeColor="ControlDarkDark"
                            Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                            BackColor="White" Height="22px" />
                        <a href="Login.aspx">Cancel</a>
                    </p>
                </div>
            </form>
        </fieldset>
    </div>
</asp:Content>

