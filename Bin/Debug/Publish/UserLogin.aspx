<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="UserLogin.aspx.cs" Inherits="UserLogin" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
    Users
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Users</h1>
        <div>
            <fieldset>
                <form id="Form1" runat="server">

                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>

                    <div>
                        <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server"
                            PopupControlID="Panel1"
                            TargetControlID="btnAddNew"
                            CancelControlID="btnCancel">
                        </asp:ModalPopupExtender>
                        <asp:Panel ID="Panel1" runat="server" CssClass="Panel">
                            <table>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label1" runat="server">Username:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtUserName" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server">Email Address:</asp:Label>

                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtEmailAddress" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server">Password:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtPassword" runat="server" />
                                    </td>
                                </tr>
                                <tr valign="middle">
                                    <td>
                                        <asp:Button ID="btnAddUser" OnClick="DoAdd" runat="server" Text="Add"
                                            ToolTip="Add User" ForeColor="ControlDarkDark"
                                            Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                            BackColor="White" Height="22px"></asp:Button>
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel"
                                            ToolTip="Cancel" ForeColor="ControlDarkDark"
                                            Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                            BackColor="White" Height="22px"></asp:Button>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <p>
                            <asp:Button ID="btnAddNew" runat="server" Text="Add New"
                                ToolTip="Add new" ForeColor="ControlDarkDark"
                                Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                BackColor="White" Height="22px"></asp:Button>
                        </p>
                    </div>

                    <asp:UpdatePanel runat="server" ID="btnSearchUpdate">
                        <ContentTemplate>
                            <div class="error" id="validation_results" runat="server" visible="False">
                                <asp:Label ID="lblError" runat="server" Visible="False" Text=""></asp:Label>
                            </div>
                            <p>
                                <asp:TextBox ID="txtUserSearch" runat="server"></asp:TextBox>
                                <asp:Button ID="btnUserSearch" OnClick="DoSearch" runat="server" Text="Search"
                                    ToolTip="Click to start the search" ForeColor="ControlDarkDark"
                                    Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                    BackColor="White" Height="22px"></asp:Button>
                                <asp:Button ID="btnReset" OnClick="DoSearch" runat="server" Text="Reset"
                                    ToolTip="Reset search" ForeColor="ControlDarkDark"
                                    Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                    BackColor="White" Height="22px"></asp:Button>
                            </p>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnUserSearch" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>


                    <asp:UpdatePanel runat="server" ID="GridviewUpdatePanel">
                        <ContentTemplate>
                            <asp:GridView ID="gvUser" runat="server" CaptionAlign="Top"
                                DataSourceID="UserDataSource" PageSize="10" UpdateMode="Always"
                                OnRowDeleting="gvUser_OnRowDeleting" OnRowDataBound="gvUser_OnRowDataBound"
                                OnRowUpdated="gvUser_OnRowUpdated"
                                AutoGenerateColumns="False" AllowPaging="True" GridLines="None"
                                CellPadding="3" EmptyDataText="Your search did not turn up any results" DataKeyNames="Id">
                                <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                <Columns>
                                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" Visible="False" />

                                    <asp:TemplateField HeaderText="Name">
                                        <HeaderStyle BackColor="LightGreen" />
                                        <EditItemTemplate>
                                            <asp:Label ID="txtUsername" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblUserName" runat="server" Text='<%# Bind("Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="EmailAddress">
                                        <HeaderStyle BackColor="LightGreen" />
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtEmail" runat="server" Text='<%# Bind("Email") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Password">
                                        <HeaderStyle BackColor="LightGreen" />
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtPassword" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblPassword" runat="server" Text='<%# Bind("Password") %>'></asp:Label>
                                        </ItemTemplate>
                                        </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="deleteButton" runat="server" CommandName="Delete" Text="Delete" ForeColor="ControlDarkDark" AlternateText="Delete"
                                                Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                                BackColor="White" Height="22px"
                                                OnClientClick="return confirm('Are you sure you want to delete this User?');" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                <HeaderStyle Font-Bold="True"></HeaderStyle>
                                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                            </asp:GridView>
                            <asp:LinqDataSource ID="UserDataSource" runat="server" ContextTypeName="VodacDataContext"
                                EnableDelete="True" EnableInsert="True" EnableUpdate="True" StoreOriginalValuesInViewState="False"
                                EntityTypeName="" Where="Name.Contains(@Search) || Name.Contains(@Search)"
                                TableName="Users" OrderBy="Id desc">
                                <WhereParameters>
                                    <asp:ControlParameter Name="Search" ControlID="txtUserSearch" ConvertEmptyStringToNull="False"
                                        Type="String" PropertyName="Text" />
                                </WhereParameters>
                            </asp:LinqDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </form>
            </fieldset>
        </div>
    </div>
</asp:Content>
