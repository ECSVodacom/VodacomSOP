<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="Store.aspx.cs" Inherits="Store" EnableEventValidation="false" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
    Stores
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Stores</h1>
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
                                        <asp:Label ID="Label1" runat="server">Store Code:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddStoreCode" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label2" runat="server">L Account:</asp:Label>

                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtAddLAccount" runat="server" />
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Label ID="Label3" runat="server">D Account:</asp:Label>
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlAddDAcccount" runat="server" DataSourceID="RetailerDataSource" DataTextField="DAccountName" DataValueField="Id" />
                                    </td>
                                </tr>
                                <tr valign="middle">
                                    <td>
                                        <asp:Button ID="btnAddStore" OnClick="DoAdd" runat="server" Text="Add"
                                            ToolTip="Add store" ForeColor="ControlDarkDark"
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
                                <asp:TextBox ID="txtStoreSearch" runat="server"></asp:TextBox>
                                <asp:Button ID="btnStoreSearch" OnClick="DoSearch" runat="server" Text="Search"
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
                            <asp:AsyncPostBackTrigger ControlID="btnStoreSearch" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>


                    <asp:UpdatePanel runat="server" ID="GridviewUpdatePanel">
                        <ContentTemplate>
                            <asp:GridView ID="gvStore" runat="server" CaptionAlign="Top"
                                DataSourceID="BranchDataSource" PageSize="10" UpdateMode="Always"
                                OnRowDeleting="gvStore_OnRowDeleting" OnRowDataBound="gvStore_OnRowDataBound"
                                OnRowUpdated="gvStore_OnRowUpdated"
                                AutoGenerateColumns="False" AllowPaging="True" GridLines="None"
                                CellPadding="3" EmptyDataText="Your search did not turn up any results" DataKeyNames="Id">
                                <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                <Columns>
                                    <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" Visible="False" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <img alt="" style="cursor: pointer" src="images/plus.png" width="16" height="16" />
                                            <asp:Panel ID="pnlAuditLog" runat="server" Style="display: none">
                                                <asp:GridView ID="gvAuditLog" runat="server" GridLines="None" AutoGenerateColumns="false" EmptyDataText="No changes found">
                                                    <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center"></RowStyle>
                                                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                                    <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                                                    <Columns>
                                                        <asp:BoundField DataField="Name" HeaderText="User" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                        <asp:BoundField DataField="Value" HeaderText="Action" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                        <asp:BoundField DataField="CreatedAt" HeaderText="Time" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                        <asp:BoundField DataField="PreviousStoreCode" HeaderText="Previous Store Code" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                        <asp:BoundField DataField="PreviousLAccount" HeaderText="Previous LAccount" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                    </Columns>
                                                </asp:GridView>
                                            </asp:Panel>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="StoreCode">
                                        <HeaderStyle BackColor="LightGreen" />
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtStoreCode" runat="server" Text='<%# Bind("StoreCode") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblStoreCode" runat="server" Text='<%# Bind("StoreCode") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="LAccount">
                                        <HeaderStyle BackColor="LightGreen" />
                                        <EditItemTemplate>
                                            <asp:TextBox ID="txtLAccount" runat="server" Text='<%# Bind("LAccount") %>'></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblLAccount" runat="server" Text='<%# Bind("LAccount") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="DAccount">
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlDAcccount" runat="server" DataSourceID="RetailerDataSource" DataTextField="DAccount" DataValueField="Id" SelectedValue='<%# Bind("Retailer.Id") %>' />
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Label ID="lblAddDAccount" runat="server" Text='<%# Bind("Retailer.DAccount") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Retailer">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRetailerName" runat="server" Text='<%# Bind("Retailer.Name") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowEditButton="True" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:Button ID="deleteButton" runat="server" CommandName="Delete" Text="Delete" ForeColor="ControlDarkDark" AlternateText="Delete"
                                                Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                                BackColor="White" Height="22px"
                                                OnClientClick="return confirm('Are you sure you want to delete this store?');" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                <HeaderStyle Font-Bold="True"></HeaderStyle>
                                <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                            </asp:GridView>
                            <asp:LinqDataSource ID="BranchDataSource" runat="server" ContextTypeName="VodacDataContext"
                                EnableDelete="True" EnableInsert="True" EnableUpdate="True" StoreOriginalValuesInViewState="False"
                                EntityTypeName="" Where="StoreCode.Contains(@Search) || LAccount.Contains(@Search)"
                                TableName="Branches" OrderBy="Id desc">
                                <WhereParameters>
                                    <asp:ControlParameter Name="Search" ControlID="txtStoreSearch" ConvertEmptyStringToNull="False"
                                        Type="String" PropertyName="Text" />
                                </WhereParameters>
                            </asp:LinqDataSource>
                            <asp:LinqDataSource ID="RetailerDataSource" runat="server" ContextTypeName="VodacDataContext" EntityTypeName="" Select="new (Id, DAccount, Name, DAccount + ' ' + Name AS DAccountName)" TableName="Retailers" OrderBy="DAccount">
                            </asp:LinqDataSource>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </form>
            </fieldset>
        </div>
    </div>
</asp:Content>
