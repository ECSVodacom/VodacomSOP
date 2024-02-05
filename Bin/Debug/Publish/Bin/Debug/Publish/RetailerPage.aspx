<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="RetailerPage.aspx.cs" Inherits="RetailerPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    Retailers
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Retailers</h1>
        <div>
            <fieldset>
                <form id="Form1" runat="server">
                    <asp:ScriptManager ID="ScriptManager1" runat="server">
                    </asp:ScriptManager>
                    <asp:UpdatePanel runat="server" ID="btnSearchUpdate">
                        <ContentTemplate>
                            <asp:TextBox ID="txtSeach" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSearch" OnClick="DoSearch" runat="server" Text="Search"
                                ToolTip="Click to start the search" ForeColor="ControlDarkDark"
                                Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                BackColor="White" Height="22px"></asp:Button>
                            <asp:Button ID="btnReset" OnClick="DoSearch" runat="server" Text="Reset"
                                ToolTip="Click to start the search" ForeColor="ControlDarkDark"
                                Font-Names="Verdana" BorderWidth="1px" BorderStyle="Solid" BorderColor="ControlDarkDark"
                                BackColor="White" Height="22px"></asp:Button>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnSearch" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnReset" EventName="Click" />
                        </Triggers>
                    </asp:UpdatePanel>
                    <p>
                        <asp:UpdatePanel runat="server" ID="GridviewUpdatePanel">
                            <ContentTemplate>
                                <asp:GridView ID="gvRetailers" runat="server" CaptionAlign="Top"
                                    DataSourceID="RetailerDataSource" PageSize="10" UpdateMode="Always"
                                    AutoGenerateColumns="False" AllowPaging="True" GridLines="None"
                                    CellPadding="3" EmptyDataText="Your search did not turn up any results" DataKeyNames="Id">
                                    <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" Visible="False" />
                                        <asp:BoundField DataField="Name" HeaderText="Retailer" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="DAccount" HeaderText="D Account" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Ean" HeaderText="Ean" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="SendsBundles" HeaderText="Sends Bundles" ReadOnly="True" InsertVisible="False" />
                                    </Columns>
                                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                    <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                                </asp:GridView>
                                <asp:LinqDataSource ID="RetailerDataSource" runat="server" ContextTypeName="VodacDataContext"
                                    Where="Name.Contains(@Search) || DAccount.Contains(@Search) || Ean.Contains(@Search)"
                                    TableName="Retailers" OrderBy="Id desc">
                                    <WhereParameters>
                                        <asp:ControlParameter Name="Search" ControlID="txtSeach" ConvertEmptyStringToNull="False"
                                            Type="String" PropertyName="Text" />
                                    </WhereParameters>
                                </asp:LinqDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </p>
                </form>
            </fieldset>
        </div>
    </div>
</asp:Content>
