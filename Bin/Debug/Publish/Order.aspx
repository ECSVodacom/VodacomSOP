<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Order.aspx.cs" Inherits="Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    Orders
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Orders</h1>
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
                        &nbsp;<asp:UpdatePanel runat="server" ID="GridviewUpdatePanel">
                            <ContentTemplate>
                                <asp:GridView ID="gvOrders" runat="server" PageSize="10"
                                    AutoGenerateColumns="False" DataSourceID="OrdersDataSource" GridLines="None"
                                    EmptyDataText="Your search did not turn up any results" UpdateMode="Always" AllowPaging="True">
                                    <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                    <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="OrderNumber" HeaderText="Order Number" ReadOnly="True" Visible="True" SortExpression="OrderNumber">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="OrderDate" HeaderText="Order Date" ReadOnly="True" Visible="True" SortExpression="OrderDate" />
                                        <asp:BoundField DataField="StoreCode" HeaderText="Store Code" ReadOnly="True" Visible="True" SortExpression="StoreCode">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LAccount" HeaderText="LAccount" ReadOnly="True" Visible="True" SortExpression="LAccount">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="RetailerEan" HeaderText="Retailer Ean" ReadOnly="True" Visible="True" SortExpression="RetailerEan" />
                                        <asp:TemplateField HeaderText="Retailer">
                                            <ItemTemplate>
                                                <asp:Label ID="lblRetailerName" runat="server" Text='<%# Bind("RetailerName") %>'></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                <asp:LinqDataSource ID="OrdersDataSource" runat="server" ContextTypeName="VodacDataContext" OrderBy="Id desc"
                                    Where="OrderNumber.Contains(@Search) || LAccount.Contains(@Search) || StoreCode.Contains(@Search)" EnableViewState="False" EntityTypeName="" Select="new (OrderNumber, OrderDate, StoreCode, LAccount, RetailerEan, Retailer.Name As RetailerName)" TableName="OrderHistories" OnSelecting="OrdersDataSource_Selecting">
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
