$(document).ready(function () {
    $(btnsave).click(function () {
        LoginPage();
    });
});

function LoginPage() {
    try {
        $.post("InsertLoginPage",
            {
                EmailId: $("#txtEmailId").val(),
                Password: $("#txtPassword").val(),
            },
            function (data) {
                if (data.Status == "1") {
                    alert(data.Message);
                    window.location.href = "/Master/Deshboard";
                }
                else {
                    alert(data.Message);
                    
                }

                if (data.Focus != "") {
                    $("#" + data.Focus).focus();
                }
            }
        )
    }
    catch (e) {
        alert("error in LogiPage", + e.Message);
    }
}

function ClearForm() {
    $("#txtEmailId").val("");
    $("#txtPassword").val("");
}
