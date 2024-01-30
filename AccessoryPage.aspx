<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="AccessoryPage.aspx.cs" Inherits="AccessoryPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    Accessories
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Accessories</h1>
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
                                <asp:GridView ID="gvAccessories" runat="server" CaptionAlign="Top"
                                    DataSourceID="AccessoryDataSource" PageSize="10" UpdateMode="Always"
                                    AutoGenerateColumns="False" AllowPaging="True" GridLines="None"
                                    CellPadding="3" EmptyDataText="Your search did not turn up any results" DataKeyNames="Id">
                                    <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="Id" HeaderText="Id" ReadOnly="True" InsertVisible="False" Visible="False" />
                                        <asp:BoundField DataField="ProductCode" HeaderText="Product Code" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="Description" HeaderText="Description" ReadOnly="True" InsertVisible="False">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LastUpdate" HeaderText="Last Update" ReadOnly="True" InsertVisible="False" />
                                    </Columns>
                                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                    <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                                </asp:GridView>
                                <asp:LinqDataSource ID="AccessoryDataSource" runat="server" ContextTypeName="VodacDataContext"
                                    Where="ProductCode.Contains(@Search) || Description.Contains(@Search)"
                                    TableName="Accessories" OrderBy="Id desc">
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
