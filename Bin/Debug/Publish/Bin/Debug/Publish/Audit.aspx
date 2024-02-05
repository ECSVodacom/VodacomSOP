<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Audit.aspx.cs" Inherits="Audit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    Audit Log
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div>
        <h1>Audit Log</h1>
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
                                <asp:GridView ID="gvAuditLog" runat="server" PageSize="10"
                                    AutoGenerateColumns="False" DataSourceID="AuditLogDataSource" GridLines="None"
                                    EmptyDataText="Your search did not turn up any results" UpdateMode="Always" AllowPaging="True">
                                    <EmptyDataRowStyle ForeColor="White" BorderWidth="1px"></EmptyDataRowStyle>
                                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Left"></RowStyle>
                                    <SelectedRowStyle BackColor="#D1DDF1" ForeColor="#333333" Font-Bold="True"></SelectedRowStyle>
                                    <PagerStyle Font-Bold="True" HorizontalAlign="Center"></PagerStyle>
                                    <HeaderStyle Font-Bold="True"></HeaderStyle>
                                    <AlternatingRowStyle BackColor="White"></AlternatingRowStyle>
                                    <Columns>
                                        <asp:BoundField DataField="Name" HeaderText="User" ReadOnly="True" InsertVisible="False" Visible="True" />
                                        <asp:BoundField DataField="Value" HeaderText="Action" ReadOnly="True" InsertVisible="False" Visible="True" />
                                        <asp:BoundField DataField="CreatedAt" HeaderText="Time" ReadOnly="True" InsertVisible="False" Visible="True" />
                                        <asp:BoundField DataField="StoreCode" HeaderText="Store Code" ReadOnly="True" InsertVisible="False" Visible="True">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="LAccount" HeaderText="LAccount" ReadOnly="True" InsertVisible="False" Visible="True">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PreviousStoreCode" HeaderText="Previous Store Code" ReadOnly="True" InsertVisible="False" Visible="True">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                        <asp:BoundField DataField="PreviousLAccount" HeaderText="Previous LAccount" ReadOnly="True" InsertVisible="False" Visible="True">
                                            <HeaderStyle BackColor="LightGreen" />
                                        </asp:BoundField>
                                    </Columns>
                                </asp:GridView>
                                <asp:LinqDataSource ID="AuditLogDataSource" runat="server" ContextTypeName="VodacDataContext"
                                    Where="StoreCode.Contains(@Search) || LAccount.Contains(@Search) || PreviousStoreCode.Contains(@Search) || PreviousLAccount.Contains(@Search) "
                                    TableName="AuditLogs" OrderBy="Id desc" Select="new (User.Name, Action.Value, CreatedAt, StoreCode, LAccount, PreviousStoreCode, PreviousLAccount)">
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
