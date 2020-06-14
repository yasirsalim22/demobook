using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace LibraryApp
{
    public partial class _Default : Page
    {
        DataTable bookTable;

        #region constants/messages

        const string msgAddFailure = "There was an error while adding record";
        const string msgUpdateFailure = "There was an error while updating record";
        const string msgDeleteFailure = "There was an error while deleting record";
        const string msgAddSuccess = "Record added successfully";
        const string msgUpdateSuccess = "Record updated successfully";
        const string msgDeleteSuccess = "Record deleted successfully";
        #endregion


        #region Events

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Books"] == null)
            {
                SetGridData();
            }

            if (!IsPostBack)
            {
                FillGrid();
            }

        }

        protected void gvBookList_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                bookTable = new DataTable("Books");
                bookTable = (DataTable)Session["Books"];
                TextBox txtName = (TextBox)gvBookList.Rows[e.RowIndex].FindControl("txtName");
                TextBox txtPrice = (TextBox)gvBookList.Rows[e.RowIndex].FindControl("txtPrice");
                bookTable.Rows[e.RowIndex]["Name"] = string.IsNullOrEmpty(txtName.Text) == true ? string.Empty : txtName.Text.Trim();
                bookTable.Rows[e.RowIndex]["Price"] = string.IsNullOrEmpty(txtPrice.Text) == true ? string.Empty : txtPrice.Text.Trim();
                Session["Book"] = bookTable;
                gvBookList.EditIndex = -1;
                FillGrid();
                lblSuccessMessage.Text = msgUpdateSuccess;

            }
            catch (Exception ex)
            {
                lblErrorMessage.Text = msgUpdateFailure;
            }

        }

        protected void gvBookList_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvBookList.EditIndex = e.NewEditIndex;
            FillGrid();
        }

        protected void gvBookList_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                bookTable = new DataTable("Books");
                bookTable = (DataTable)Session["Books"];
                bookTable.Rows[e.RowIndex].Delete();
                Session["Book"] = bookTable;
                FillGrid();
                lblSuccessMessage.Text = msgDeleteSuccess;
            }
            catch (Exception ex)
            {
                // log exception
                lblErrorMessage.Text = msgDeleteFailure;
            }
        }

        protected void gvBookList_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            
        
        }

        protected void gvBookList_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvBookList.EditIndex = -1;
            FillGrid();
        }
        #endregion

        #region methods

        /// <summary>
        /// Fills the Grid and bind 
        /// </summary>
        private void FillGrid()
        {
            bookTable = new DataTable("Books");
            bookTable = (DataTable)Session["Books"];
            gvBookList.DataSource = bookTable;
            gvBookList.DataBind();
        }
        /// <summary>
        /// Set initial Grid Data
        /// </summary>
        private void SetGridData()
        {
            bookTable = new DataTable("Books");
            DataColumn bookCol = bookTable.Columns.Add("Id", typeof(Int32));
            bookCol.AllowDBNull = false;
            bookCol.Unique = true;

            bookTable.Columns.Add("Name", typeof(String));
            bookTable.Columns.Add("Price", typeof(Double));
            bookTable.Rows.Add(new Object[] { 1, "The Great Gatsby", 6.5 });
            bookTable.Rows.Add(new Object[] { 2, "Harry Potter", 7 });
            bookTable.Rows.Add(new Object[] { 3, "The Hobbit", 8 });

            Session["Books"] = bookTable;
            Session["bookId"] = 4;
        }
        #endregion

        protected void Insert(object sender, EventArgs e)
        {
            var bookName = string.IsNullOrEmpty(txtName.Text) == true ? string.Empty : txtName.Text.Trim();
            var bookPrice = string.IsNullOrEmpty(txtPrice.Text) == true ? 0 : Convert.ToDouble(txtPrice.Text.Trim());
            int bookId = (int)Session["bookId"];

            bookTable = new DataTable("Books");
            bookTable = (DataTable)Session["Books"];
            bookTable.Rows.Add(new Object[] { bookId, bookName, Math.Round(bookPrice, 2) });
            Session["Books"] = bookTable;
            Session["bookId"] = bookId + 1;

            gvBookList.EditIndex = -1;
            FillGrid();

            lblSuccessMessage.Text = msgAddSuccess;
        }
    }
}