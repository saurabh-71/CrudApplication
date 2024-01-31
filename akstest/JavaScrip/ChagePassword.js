
var AddSubCateId = 0;
$(document).ready(function () {
    $("#btnChange").click(function () {
        UpdatebtnChangePassword();
        return false;
    });
});


function UpdatebtnChangePassword(SubCateId) {
    try {
        $.post("/Master/UpdatebtnChangePassword", { SubCateId: AddSubCateId }, function (data) {
            if (data.Message != "") {
                alert(data.Message);
            }
            else {
                AddSubCateId = SubCateId;
                $("#ddlCategoryName").val(data.ddlCategoryName);
                $("#txtAddSubCategory").val(data.AddSubCategory);
                if (data.Active == "True") {
                    $("#txtchecked").prop("checked", true);
                }
                else {
                    $("#txtchecked").prop("checked", false);
                }
                $("#txtchecked").is("checked").val();
            }
        });
    } catch (e) {
        alert("error in EditAddSubProductCategory :" + e.message);
    }
}