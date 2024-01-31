var AddSubCateId = 0;
$(document).ready(function () {
    ShowAddSubProductCategory();
    $("#btnsave").click(function () {
        InsertUpdateAddSubCategory();
        return false;
    });
});


function InsertUpdateAddSubCategory() {
    try {
        $.post("/Master/InsertUpdateAddSubCategory",
            {
                AddSubCateId: AddSubCateId,
                ddlCategoryName: $("#ddlCategoryName").val(),
                AddSubCategory: $("#txtAddSubCategory").val(),
                Active: $("#txtchecked").is(":checked")
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
                    ShowAddSubProductCategory();
                }

            });
    }
    catch (e) {
        alert("error in InsertUpdateAddSubCategory :" + e.message);
    }
}
function ShowAddSubProductCategory() {
    try {
        $.post("/Master/ShowAddSubProductCategory", {}, function (data) {
            if (data.Message != "") {
                alert(data.Message);
            }
            if (data.Grid != "") {
                $("#Grid").html(data.Grid);
            }
        });
    }
    catch (e) {
        alert("error in ShowAddSubProductCategory: " + e.message);
    }
}
function DelAddSubProductCategory(AddSubCateId) {
    try {
        if (confirm("do you want to Delete?")) {
            $.post("/Master/DelAddSubProductCategory", { AddSubCateId: AddSubCateId }, function (data) {
                if (data.Message != "") {
                    alert(data.Message);
                    ShowAddSubProductCategory();
                }
            });
        }
    } catch (e) {
        alert("Error in DelAddSubProductCategory:" + e.message);
    }
}
function EditAddSubProductCategory(SubCateId) {
    try {
        $.post("/Master/EditAddSubProductCategory", { AddSubCateId: SubCateId }, function (data) {
            if (data.Message != "") {
                alert(data.Message);
            }
            else {
                AddSubCateId = SubCateId;
                $("#ddlCategoryName").val(data.ddlCategoryName);
                $("#txtAddSubCategory").val(data.AddSubCategory);
                if (data.Active == "Active") {
                    $("#txtchecked").prop("checked", true);
                }
                else {
                    $("#txtchecked").prop("checked", false);
                }
              
            }
        });
    } catch (e) {
        alert("error in EditAddSubProductCategory :" + e.message);
    }
}
function ClearForm() {
    AddSubCateId = 0;
    $("#ddlCategoryName").val("");
    $("#txtAddSubCategory").val("");
    $("#txtchecked").prop("checked", false);
    ShowAddSubProductCategory();
}