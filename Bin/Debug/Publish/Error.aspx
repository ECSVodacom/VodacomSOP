<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Error.aspx.cs" Inherits="Error" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="Server">
    Error      
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <h1>Error</h1>
    <div class="error" id="validation_results" runat="server" visible="True">
        <asp:Label ID="lblError" runat="server" Visible="True" Text="Error occured"></asp:Label>
    </div>
</asp:Content>

