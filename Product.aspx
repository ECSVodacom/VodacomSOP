<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="ProductPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    Products
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Products</h1>
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
                                <asp:GridView ID="gvProduct" runat="server" CaptionAlign="Top"
                                    DataSourceID="ProductDataSource" UpdateMode="Always"
                                    AutoGenerateColumns="False" AllowPaging="True" GridLines="None"
                                    OnRowDataBound="gvProduct_OnRowDataBound"
                                    CellPadding="3" EmptyDataText="Your search did not turn up any results" DataKeyNames="Id">
                                    <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <img alt="" style="cursor: pointer" src="images/plus.png" width="16" height="16" />
                                                <asp:Panel ID="pnlAccessories" runat="server" Style="display: none">
                                                    <asp:GridView ID="gvAccessories" runat="server" AutoGenerateColumns="false" EmptyDataText="No accessories linked" GridLines="None">
                                                        <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                                        <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                                                        <Columns>
                                                            <asp:BoundField DataField="Name" HeaderText="Retailer" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                            <asp:BoundField DataField="DAccount" HeaderText="DAccount" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                            <asp:BoundField DataField="ProductCode" HeaderText="ProductCode" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                            <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="True" InsertVisible="False" Visible="True" />
                                                        </Columns>
                                                    </asp:GridView>
                                                </asp:Panel>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" Visible="False" />
                                        <asp:BoundField DataField="ProductCode" HeaderText="Product Code" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Barcode" HeaderText="Barcode" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>

                                        <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>

                                        <asp:BoundField DataField="LastUpdate" HeaderText="Last Updated" ReadOnly="True" InsertVisible="False" />
                                    </Columns>
                                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                    <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                                </asp:GridView>
                                <asp:LinqDataSource ID="ProductDataSource" runat="server" ContextTypeName="VodacDataContext"
                                    Where="ProductCode.Contains(@Search) || Barcode.Contains(@Search) || Description.Contains(@Search)"
                                    TableName="Products" OrderBy="Id desc">
                                    <WhereParameters>
                                        <asp:ControlParameter Name="Search" ControlID="txtSeach" ConvertEmptyStringToNull="False"
                                            Type="String" PropertyName="Text" />
                                    </WhereParameters>
                                </asp:LinqDataSource>
                                <asp:LinqDataSource ID="RetailerDataSource" runat="server" ContextTypeName="VodacDataContext" EntityTypeName="" Select="new (Id, DAccount)" TableName="Retailers">
                                </asp:LinqDataSource>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </p>
                </form>
            </fieldset>
        </div>
    </div>
</asp:Content>
