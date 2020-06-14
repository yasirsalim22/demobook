<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LibraryApp._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">

        <p class="lead">Manage your favorite books for free </p>
                <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse">
            <tr>
                <td style="width: 150px">
                    Name:<br />
                    <asp:TextBox ID="txtName" runat="server" MaxLength="25" Width="140" />
                    <asp:RequiredFieldValidator ID="rfvTxtNameFooter" runat="server" ControlToValidate="txtName" ValidationGroup="AddForm" ForeColor="Red" ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                </td>
                <td style="width: 150px">
                    Price:<br />
                    <asp:TextBox ID="txtPrice" runat="server" Width="140" />
                        <asp:RequiredFieldValidator ID="rfvTxtPriceFooter" runat="server" ControlToValidate="txtPrice" ValidationGroup="AddForm" ForeColor="Red" ErrorMessage="Price is required"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="vldPriceFooter" ControlToValidate="txtPrice"
                            Display="Dynamic" ErrorMessage="Invalid price" ValidationExpression="^\d{0,8}(\.\d{1,4})?$" ValidationGroup="AddForm" runat="server" ForeColor="Red"/>
                </td>
                <td style="width: 150px">
                    <asp:Button ID="btnAdd" runat="server" Text="Add a book" OnClick="Insert" ValidationGroup="AddForm" />
                </td>
            </tr>
        </table>
        <br />
        <asp:GridView ID="gvBookList" runat="server" AutoGenerateColumns="False" ShowFooter="True" DataKeyNames="Id" CssClass="table table-responsive table-striped table-hover"
            ShowHeaderWhenEmpty="True" EmptyDataText="No records Found"
            OnRowCommand="gvBookList_RowCommand" OnRowEditing="gvBookList_RowEditing" OnRowCancelingEdit="gvBookList_RowCancelingEdit"
            OnRowUpdating="gvBookList_RowUpdating" OnRowDeleting="gvBookList_RowDeleting"
            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3">
            <%-- Theme Properties --%>
            <FooterStyle BackColor="White" ForeColor="#000066" />
            <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
            <RowStyle ForeColor="#000066" />
            <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
            <SortedAscendingCellStyle BackColor="#F1F1F1" />
            <SortedAscendingHeaderStyle BackColor="#007DBB" />
            <SortedDescendingCellStyle BackColor="#CAC9C9" />
            <SortedDescendingHeaderStyle BackColor="#00547E" />

            <Columns>
                <asp:TemplateField HeaderText=" Item #" ItemStyle-Width="100">
                    <ItemTemplate>
                        <asp:Label ID="lblRowNumber" Text='<%# Container.DataItemIndex + 1 %>' runat="server" />
                    </ItemTemplate>
                    <HeaderStyle BorderStyle="Solid" BorderWidth="2px" HorizontalAlign="Center" VerticalAlign="Middle" />

<ItemStyle Width="100px" HorizontalAlign="Center" VerticalAlign="Middle"></ItemStyle>
                </asp:TemplateField>
                <asp:TemplateField HeaderText=" Name">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("Name") %>' runat="server" Width="200"/>
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtName" MaxLength="25" Text='<%# Eval("Name") %>' runat="server" Width="140" />
                        <asp:RequiredFieldValidator ID="rfvTxtName" runat="server" ControlToValidate="txtName" ForeColor="Red" ErrorMessage="Name is required"></asp:RequiredFieldValidator>
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="Price">
                    <ItemTemplate>
                        <asp:Label Text='<%# Eval("Price") %>' runat="server" Width="100" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:TextBox ID="txtPrice" Text='<%# Eval("Price") %>' runat="server" />
                         <asp:RequiredFieldValidator ID="rfvTxtPrice" runat="server" ControlToValidate="txtPrice" ForeColor="Red" ErrorMessage="Price is required"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="vldNumber" ControlToValidate="txtPrice"
                            Display="Dynamic" ErrorMessage="Invalid price" ValidationExpression="^\d{0,8}(\.\d{1,4})?$" runat="server" ForeColor="Red"/>
                    </EditItemTemplate>
                </asp:TemplateField>

                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:ImageButton ImageUrl="~/Images/edit.png" runat="server" CommandName="Edit" ToolTip="Edit" Width="20px" Height="20px" />
                        <asp:ImageButton ImageUrl="~/Images/delete.png" runat="server" CommandName="Delete" ToolTip="Delete" Width="20px" Height="20px" />
                    </ItemTemplate>
                    <EditItemTemplate>
                        <asp:ImageButton ImageUrl="~/Images/save.png" runat="server" CommandName="Update" ToolTip="Update" Width="20px" Height="20px" />
                        <asp:ImageButton ImageUrl="~/Images/cancel.png" runat="server" CommandName="Cancel" ToolTip="Cancel" Width="20px" Height="20px" />
                    </EditItemTemplate>
               
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <br />
        <asp:Label ID="lblSuccessMessage" Text="" runat="server" ForeColor="Green" />
        <br />
        <asp:Label ID="lblErrorMessage" Text="" runat="server" ForeColor="Red" />

    </div>
    <div>
    </div>


</asp:Content>
