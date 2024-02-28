var ProductID = 0;
var base64String = "";
$(document).ready(function () {
    ClearForm();
    ddlCategoryName();
    $("#ddlCategoryName").change(function () {
        ddlSubCategoryName();
    })


    $("#btnsave").click(function () {
        InsertUpdateAddProduct();
        return false;
    });


    $("#txtProductImage").change(function () {
        var arr = [files = document.getElementById('txtProductImage').files];
        for (var i = 0; i < arr.length; i++) {
            if (arr.length > 0) {
                var reader = new FileReader()
                reader.readAsDataURL(files[i]),
                    reader.onload = function () {
                        base64String = reader.result.toString();
                     /*   base64String = base64String.split(',')[1]*/
                    }
            };
            reader.onerror = function (error) {
                alert('Error: ', error);
            };
        }
    });

});
var base64Image11 = [];
function base64Image1(object) {
  /*  alert(object.id);*/
    var file = $(object).get(0).files[0];
    if (file) {
        var reader = new FileReader();
        reader.onload = function (e) {
            base64Image11.push(e.target.result);
        };
        reader.readAsDataURL(file);
    }
}
function ddlSubCategoryName() {
    try {
        $.post("/Master/ddlSubCategoryName", {
            ddlCategoryName: $("#ddlCategoryName").val()
        }, function (data) {
            if (data.Status == "0") {
                alert("PLZ Select Cuntry")
            }
            $("#ddlSubCategoryName").html(data.Result);
            var stringValue = $("#txthidden").val();
            var selectedValues = stringValue.split(',').filter(function (value) {
                return value.trim() !== ""; 
            });
            $("#ddlSubCategoryName").val(selectedValues);
            $("#" + data.Focus).focus();
        });
    }
    catch (e) {
        alert("error in ddlSubCategoryName:" + e.message);
    }
}
function ddlCategoryName() {
    try {
        $.post("/Master/ddlCategoryName", {}, function (data) {
            if (data.Result != "") {
                $("#ddlCategoryName").html(data.Result);
            }
        });
    }
    catch (e) {
        alert("error in ddlCategoryName: " + e.message);
    }
}
function InsertUpdateAddProduct() {
    try {
        console.log(base64Image11);
        
        if ($("#txtProductImage").val() == "") {
            base64String = $("#imgShow").attr("src");
        }
        var id_title_heading_description = [];
        for (var i = 1; i <= $('#wrapper > div.row').length; i++) {
            let id = $("#1id" + i).val();
            let title = $("#txttitle" + i).val();
            let heading = $("#txtHeading" + i).val();
            let description = $("#txtDescription" + i).val();
            id_title_heading_description.push(id + "#" + title + "#" + heading + "#" + description);
        }
        var id_fileheading_image = [];
        var increment = 0;
        for (var i = 1; i <= $('#dynamic_field > div.row').length; i++) {
            let tempvar = "";
            let id = $("#txtPdfId" + i).val();
            let PdfHeading = $("#txtPdfHeading" + i).val();
            let filePdfHeading = $("#filePdfHeading" + i).val();
            let imgPdfHeading = $("#imgPdfHeading" + i).attr('src');
            if (filePdfHeading != "" && filePdfHeading != undefined)
            {
                tempvar = base64Image11[increment];
                increment++;
            }
            else if (imgPdfHeading != "") {
                tempvar = $("#imgPdfHeading" + i).attr('src');
            }
            else
            {
                tempvar = "";
            }
            id_fileheading_image.push(id + "#" + PdfHeading + "#" + tempvar);
        }

        $.ajax({
            type: "POST",
            url: "/Master/InsertUpdateAddProduct",
            contentType: "application/json; charset=utf-8",
            //processData: true,  // tell jQuery not to process the data
            //contentType: true,
            data: JSON.stringify({
                ProductID: ProductID,
                ddlCategoryName: $("#ddlCategoryName").val(),
                ddlSubCategoryName: $("#ddlSubCategoryName").val().join(','),
                ProductName: $("#txtProductName").val(),
                ProductImage: base64String,
                shortDescription: $("#txtShortDescription").val(),
                Content: CKEDITOR.instances.txtContent.getData(),
                Active: $("#txtchecked").is(":checked"),
                id_title_heading_description: id_title_heading_description,
                id_fileheading_image: id_fileheading_image
            }),
            success: function (data) {
                if (data.Status == "0") {
                    alert(data.Message);
                }
                else 
                {
                    alert(data.Message);
                    ClearForm();
                    ShowAddProduct();
                }
                
                setTimeout(function () {
                    if (data.Focus != "") {
                        $("#" + data.Focus).focus();
                    }
                }, 200);
            },
            error: function (xhr, textStatus, errorThrown) {
                // Handle error if needed
                console.error("Error:", errorThrown);
            }
        });

    }
    catch (e) {
        alert("error in InsertUpdateAddProduct:" + e.message);
    }
}
function ShowAddProduct() {
    try {
        $.post("/Master/ShowAddProduct", {}, function (data) {
            if (data.Message != "") {
                alert(data.Message);
            }
            if (data.Grid != "") {
                $("#Grid").html(data.Grid);
            }
        });
    }
    catch (e) {
        alert("error in ShowAddProduct: " + e.message);
    }
}
function DelAddProduct(ProductID) {
    try {
        if (confirm("do you want to Delete?")) {
            $.post("/Master/DelAddProduct", { ProductID: ProductID }, function (data) {
                if (data.Message != "") {
                    alert(data.Message);
                    ShowAddProduct();
                }
            });
        }
    } catch (e) {
        alert("Error in DelAddProduct:" + e.message);
    }
}
function EditAddProduct(PID) {
    $("#imgShow").css("display", "block");
    try {
        $.post("/Master/EditAddProduct", {ProductID:PID}, function (data) {
            if (data.Message != "") {
                alert(data.Message);
            }
            else {
                ProductID = PID;
                $("#ddlCategoryName").val(data.ddlCategoryName);
                setTimeout(function () {
                    ddlSubCategoryName();
                    $("#txthidden").val(data.ddlSubCategoryName);
                },500)
                $("#txtProductName").val(data.ProductName);
                $("#txttitlle").val(data.Tittle);
                $("#txtHeading").val(data.Heading);
                $("#txtDescription").val(data.FullDescription);
                CKEDITOR.instances['txtContent'].setData(data.Content);
                $("#txtShortDescription").val(data.shortDescription);
                if (data.ProductImage != "") {
                    $("#imgShow").attr("src",data.ProductImage);
                }
                if (data.Active == "Active") {
                    $("#txtchecked").prop("checked", true);
                }
                else {
                    $("#txtchecked").prop("checked", false);
                }
                addProductRows({
                    descid: data.descid,
                    title: data.title,
                    heading: data.heading,
                    description: data.description
                });
                addPdfRows({
                    imageid: data.imageid,
                    fileheading: data.fileheading,
                    image: data.image,
                });
            }
        });
    } catch (e) {
        alert("error in EditAddProduct :" + e.message);
    }
}
function ClearForm() {
    ProductID = 0;
    $("#ddlCategoryName").val("");
    $("#ddlSubCategoryName").val("");
    $("#txtProductName").val("");
    $("#imgShow").css("display", "none");
    $("#txtProductImage").val("");
    $("#txttitlle").val(""),
    $("#txtHeading").val(""),
    $("#txtDescription").val(""),
    $("#txtShortDescription").val("");
    CKEDITOR.instances['txtContent'].setData("");
    $("#txtchecked").prop("checked", false);
    $("#1id1").val("0");
    $("#txttitle1").val("");
    $("#txtHeading1").val("");
    $("#txtDescription1").val("");
    $('#wrapper >.row:not(:first)').remove();
    $("#txtPdfId1").val("");
    $("#txtPdfHeading1").val("");
    $("#filePdfHeading1").val("");
    $("#imgPdfHeading1").attr('src', "").css("display", "none");
    $('#dynamic_field >.row:not(:first)').remove();
    ShowAddProduct();
}
// not i
function removeRow(element) {
    var id = $(element).closest('.row').clone().find('.d-none').attr('id');
    var value = $("#" + id).val();
    if (value != "0") {
        /*alert(value);*/
        $.post("/Master/DeleteDescription", { id: value }, function (data) {
        });
    };
    $(element).closest('.row').remove();
    updateIDs();
}
function addMore() {
    var mainCount = $('#wrapper > div.row').length + 1;
    var subCount = $('#wrapper > div.row:last .row').length + 1;
    var newRow = '<div class="row" data-count="' + mainCount + '">' +
        '<div class="col-sm-12">' +
        '<input type="text" class="form-control d-none" id="1id' + mainCount + '" placeholder="Title" value="0"/>' +
        '<input type="text" class="form-control" id="txttitle' + mainCount + '" placeholder="Title" />' +
        '<div class="row" data-subcount="' + subCount + '">' +
        '<div class="col-sm-6">' +
        '<input type="text" class="form-control" id="txtHeading' + mainCount + '" placeholder="Heading" />' +
        '</div>' +
        '<div class="col-sm-6">' +
        '<input type="text" class="form-control" id="txtDescription' + mainCount + '" placeholder="Description" />' +
        '</div>' +
        '</div>' +
        '<a class="remove text-decoration-none btn btn-danger" style="cursor:pointer;" onclick="removeRow(this)">Remove</a>' +
        '</div>' +
        '</div>';
    $('#wrapper').append(newRow);
}
function updateIDs() {
    $('#wrapper > div.row').each(function (mainIndex) {
        var mainCount = mainIndex + 1;
        $(this).data('count', mainCount);
        $(this).find('input[id^="txttitle"]').attr('id', 'txttitle' + mainCount);
        $(this).find('input[id^="1id"]').attr('id', '1id' + mainCount);
        $(this).find('.row').each(function (subIndex) {
            var subCount = subIndex + 1;
            $(this).data('subcount', subCount);
            $(this).find('input[id^="txtHeading"]').attr('id', 'txtHeading' + mainCount);
            $(this).find('input[id^="txtDescription"]').attr('id', 'txtDescription' + mainCount);
        });
    });
}
//jhuj
function addFieldElement() {
    var count = $('#dynamic_field > div.row').length + 1;

    var newField = '<div class="row" data-count="' + count + '">' +
        '<div class="col-sm-10">' +
        '<div class="row">' +
        '<div class="col-sm-5">' +
        '<input type="text"class="form-control d-none" value="0" id="txtPdfId' + count + '" placeholder="PdfHeading" />' +
        '<input type="text" class="form-control" id="txtPdfHeading' + count + '" placeholder="PdfHeading" />' +
        '</div>' +
        '<div class="col-sm-5">' +
        '<input type="file" accept="application/pdf" class="form-control" onchange="base64Image1(this)" id="filePdfHeading' + count + '" />' +
        '</div>' +
        '<div class="col-sm-2">' +
        //'<img id="imgPdfHeading' + count +'" class="img-thumbnail" alt="Image Preview" style="max-width: 100px; max-height: 100px;display:none;">' +
        '<iframe src="" id="imgPdfHeading' + count +'" style="max-width: 100px; max-height: 100px;display:none;"> </iframe> ' +
        '</div>' +
        '</div>' +
        '<a class="remove btn btn-danger" onclick="removeFieldElement(this)">Remove</a>' +
        '</div>' +
        '</div>';

    $('#dynamic_field').append(newField);
}
function removeFieldElement(element) {
    var id = $(element).closest('.row').clone().find('.d-none').attr('id');
    var value = $("#" + id).val();
    if (value != "0") {
        /*alert(value);*/
        $.post("/Master/DeletePdf", { id: value }, function (data) {
        });
    }
    $(element).closest('.row').remove();
    updateFieldElementIDs();
}
function updateFieldElementIDs() {
    $('#dynamic_field > div.row').each(function (index) {
        var count = index + 1;
        $(this).data('count', count);
        $(this).find('input[id^="txtPdfHeading"]').attr('id', 'txtPdfHeading' + count);
        $(this).find('input[id^="filePdfHeading"]').attr('id', 'filePdfHeading' + count);
        $(this).find('input[id^="imgPdfHeading"]').attr('id', 'imgPdfHeading' + count);
    });
}
//jkkkkkkkkkk
function addProductRows(data) {
    var descid = data.descid.split('#');
    var title = data.title.split('#');
    var heading = data.heading.split('#');
    var description = data.description.split('#');

    var existingRowCount = $('#wrapper > div.row').length;
        $("#1id1").val(descid[0]);
        $("#txtHeading1").val(heading[0]);
        $("#txttitle1").val(title[0]);
        $("#txtDescription1").val(description[0]);
    for (var i = 0; i < descid.length-1; i++) {
      
        {
        var mainCount = existingRowCount + i + 1;

        var newRow = $('#wrapper > div.row:first').clone();
        newRow.attr('data-count', mainCount);

        
            newRow.find('.form-control#1id1').attr('id', '1id' + mainCount).val(descid[i+1]);
            newRow.find('.form-control#txtHeading1').attr('id', 'txtHeading' + mainCount).val(heading[i+1]);
            newRow.find('.form-control#txttitle1').attr('id', 'txttitle' + mainCount).val(title[i+1]);
            newRow.find('.form-control#txtDescription1').attr('id', 'txtDescription' + mainCount).val(description[i+1]);

            newRow.find('.remove').attr('onclick', 'removeRow(this)');
            $('#wrapper').append(newRow);
        }
    }
}
function addPdfRows(data) {
    var imageid = data.imageid.split('#');
    var fileheading = data.fileheading.split('#');
    var image = data.image.split('#');

    var existingRowCount = $('#dynamic_field > div.row').length;

    // Set values for the first row outside the loop
    $("#txtPdfId1").val(imageid[0]);
    $("#txtPdfHeading1").val(fileheading[0]);
    $("#imgPdfHeading1").attr('src', image[0]).css("display", "block");

    // Add rows for the remaining data
    for (var i = 0; i < imageid.length - 1; i++) {
        var mainCount = existingRowCount + i + 1;

        var newRow = $('#dynamic_field > div.row:first').clone();
        newRow.attr('data-count', mainCount);

        newRow.find('.form-control#txtPdfId1').attr('id', 'txtPdfId' + mainCount).val(imageid[i + 1]);
        newRow.find('.form-control#txtPdfHeading1').attr('id', 'txtPdfHeading' + mainCount).val(fileheading[i + 1]);
        newRow.find('.form-control#filePdfHeading1').attr('id', 'filePdfHeading' + mainCount).val("");
        newRow.find('#imgPdfHeading1').attr('id', 'imgPdfHeading' + mainCount).attr('src', image[i + 1]).css("display", "block");

        newRow.find('.remove').attr('onclick', 'removeFieldElement(this)');
        $('#dynamic_field').append(newRow);
    }
}   

