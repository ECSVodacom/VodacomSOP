<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="Default" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
    Login
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Log in to your account below.</h1>
        <p>
            Please enter your username and password below.
        </p>
        <div class="error" id="validation_results" runat="server" visible="False">
            <asp:Label ID="lblError" runat="server" Visible="False"></asp:Label>
        </div>
        <div>
            <fieldset>
                <form id="form1" runat="server">
                    <asp:Login ID="Login" runat="server" DisplayRememberMe="True" OnAuthenticate="Login_OnAuthenticate">
                        <LoginButtonStyle BackColor="White" BorderColor="#CCCCCC" BorderStyle="Solid" BorderWidth="1px"
                            Font-Names="Verdana" Font-Size="1.1em" ForeColor="#284775" />
                        
                        <LayoutTemplate>
                            <div class="element_group">
                                <asp:Label ID="lblUserName" runat="server" AssociatedControlID="UserName">Username:</asp:Label>
                                <asp:TextBox ID="UserName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    ErrorMessage="User Name is required." ToolTip="User Name is required." ValidationGroup="Login">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="element_group">
                                <asp:Label ID="lblPassword" runat="server" AssociatedControlID="Password">Password:</asp:Label>
                                <asp:TextBox ID="Password" runat="server" TextMode="Password"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                    ErrorMessage="Password is required." ToolTip="Password is required." ValidationGroup="Login">*</asp:RequiredFieldValidator>
                            </div>
                            <div class="action_items">
                                <asp:Button ID="LoginButton" runat="server" CommandName="Login" Text="Log In"
                                    ValidationGroup="Login" ForeColor="ControlDarkDark"
                                    Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                    BackColor="White" Height="22px" />
                                <a href="ForgotPassword.aspx">Forgot Password?</a>
                            </div>
                            
                        </LayoutTemplate>
                    </asp:Login>

                </form>
            </fieldset>
        </div>
    </div>
</asp:Content>
