var AddCategoryId = 0;
$(document).ready(function () {
    showAddCategory();
    $("#btnsave").click(function () {
        InsertUpdateAddCategory();        
        return false;
    })
});
function InsertUpdateAddCategory() {
    try {
        $.post("/Master/InsertUpdateAddCategory",
            {
                AddCategoryId: AddCategoryId,
                CategoryName: $("#txtCategoryName").val(),
                IsActive: $("#txtchecked").is(":checked")
            },
            function (data) {
                if (data.Message != "") {
                    alert(data.Message);
                 
                }
                if (data.Status == "0") {

                }
         
                if (data.Focus != "") {
                    $("#" + data.Focus).Focus();
                }
                else {
                    ClearForm();
                    showAddCategory();
                }
            });
    }
    catch (e) {
        alert("error in InsertUpdateAddCategory :" + e.message);
    }
}
function showAddCategory() {
    try {
        $.post("/Master/showAddCategory", {}, function (data) {
            if (data.Message != "") {
                alert(data.Message);
            }
            if (data.Grid != "") {
                $("#Grid").html(data.Grid);
            }
        });
    }
    catch (e) {
        alert("error in showAddCategory: " + e.message);
    }
}
function Delete(AddCategoryId) {
    try {
        if (confirm("Really.. Do you want to Delete this record?")) {
            $.post("/Master/Delete", { AddCategoryId: AddCategoryId }, function (data) {
                if (data.Message != "") {
                    alert(data.Message);
                    showAddCategory();
                }
            });
        }
    } catch (e) {
        alert("error in Delete:" + e.message);
    }

}

function Edit(ID) {
    try {
        $.post("/Master/Edit", { AddCategoryId: ID }, function (data) {
            if (data.Message != "") {
                alert(data.Message);
            }
            else {
                AddCategoryId = ID,
                    $("#txtCategoryName").val(data.CategoryName);
                if (data.IsActive == "Active") {
                    $("#txtchecked").prop("checked", true);
                }
                else {
                    $("#txtchecked").prop("checked", false);
                }
                
            }

        });
    } catch (e) {
        alert("Error in Edit :" + e.message);
    }
}
function ClearForm() {
    AddCategoryId = 0;
    $("#txtCategoryName").val("");
    $("#txtchecked").prop("checked", false);
    showAddCategory();
}