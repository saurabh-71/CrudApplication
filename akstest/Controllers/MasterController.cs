using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Data;
using System.Text;
using AKS_Machin_Test.Models;

namespace AKS_Machin_Test.Controllers
{
    public class MasterController : Controller
    {
        // GET: Master
        public ActionResult Index()
        {
            return View();
        }

        #region LoginPage
        public ActionResult LoginPage()
        {
            return View();
        }

        public JsonResult InsertLoginPage(string EmailId, string Password)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            dic["Status"] = "0";
            dic["Focus"] = "";

            try
            {
                if (string.IsNullOrWhiteSpace(EmailId))
                {
                    dic["Message"] = "Please Enter EmailId";
                    dic["Focus"] = "txtEmailId";
                }
                else if (string.IsNullOrWhiteSpace(Password))
                {
                    dic["Message"] = "Please Enter password";
                    dic["Focus"] = "txtPassword";
                }
                else
                {
                    string[,] param = new string[,]
                    {
                        {"@EmailId",EmailId},
                        {"@Password",Password}
                    };
                    DataTable dt = DBManager.ExecuteProcess("USP_ProductLogin", param);
                    if (dt.Rows.Count > 0)
                    {
                        dic["Message"] = dt.Rows[0]["Msg"].ToString();
                        dic["Status"] = dt.Rows[0]["Status"].ToString();
                        dic["Focus"] = dt.Rows[0]["Focus"].ToString();
                        if (dt.Rows[0]["Status"].ToString() == "1")
                        {
                            Session["Id"] = dt.Rows[0]["Id"].ToString();
                            Session["Email"] = dt.Rows[0]["Email"].ToString();
                        }
                    }
                }
            }
            catch (Exception e)
            {
                dic["Message"] = e.Message;
            }
            return Json(dic);
        }
        #endregion  LoginPage

        #region Deshboard
        public ActionResult Deshboard()
        {
            if (Session["id"] ==null)
            {
                return RedirectToAction("Loginpage");
            }
            else
            {
                return View();
            }
        }
        #endregion Deshboard

        #region AddProductCategory
        public ActionResult AddCategor()
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("Loginpage");
            }
            else
            {
                return View();
            }
        }
        public JsonResult InsertUpdateAddCategory(string AddCategoryId, string CategoryName, bool IsActive)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                if (string.IsNullOrWhiteSpace(CategoryName))
                {
                    dic["Message"] = "Please Enter CategoryName";
                    dic["Focus"] = "txtCategoryName";
                }
                else
                {
                    string[,] Param = new string[,] {
                        { "@AddCategoryId", AddCategoryId },
                        { "@CategoryName", CategoryName },
                        { "@IsActive", IsActive ? "1" : "0" }
                    };
                    DataTable dt = DBManager.ExecuteProcess("USP_InsertUpdateAddProductCategory", Param);
                    if (dt.Rows.Count > 0)
                    {
                        dic["Message"] = dt.Rows[0]["Msg"].ToString();
                        dic["Status"] = dt.Rows[0]["Status"].ToString();
                        dic["Focus"] = dt.Rows[0]["Focus"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }

        public JsonResult showAddCategory()
        {
            StringBuilder sb = new StringBuilder();
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            dic["Grid"] = "";
            try
            {
                DataTable dt = DBManager.ExecuteProcess("USP_ShowAddProductcategory");
                if (dt.Rows.Count > 0)
                {
                    //sb.Append("<table class='table table-responsibe'><tr style='background:#484747;color:white;'>");
                    //sb.Append("<th>Sr. No.</th>");
                    //sb.Append("<th>Category Name</th>");
                    //sb.Append("<th>Status</th>");
                    //sb.Append("<th>Delete</th>");
                    //sb.Append("<th>Edit</th></tr>");
                    //for (int i = 0; i < dt.Rows.Count; i++)
                    //{
                    //    sb.Append("<tr><td>" + dt.Rows[i]["AddCategory Id"].ToString() + "</td>");
                    //    sb.Append("<td>" + dt.Rows[i]["CategoryName"].ToString() + "</td>");
                    //    sb.Append("<td>" + dt.Rows[i]["IsActive"].ToString() + "</td>");
                    //    sb.Append("<td><button type='button' class='btn btn-danger' onclick='Delete(" + dt.Rows[i]["AddCategoryId"].ToString() + ")'><i class='fa fa-trash'aria-hidden='true'></i></td>");
                    //    sb.Append("<td><button type='button' class='btn btn-success' onclick='Edit(" + dt.Rows[i]["AddCategoryId"].ToString() + ")'><i class='fa fa-edit'></i></td></tr>");
                    //}
                    //sb.Append("</table>");
                    StringBuilder b= DBManager.GridView(dt, "AddCategoryId", "AddCategoryId", true,true);
                    dic["Grid"] = b.ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }

        public JsonResult Delete(string AddCategoryId)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@AddCategoryId", AddCategoryId } };
                DataTable dt = DBManager.ExecuteProcess("USP_DeleteAddProdutCategory", param);
                if (dt.Rows.Count > 0)
                {
                    dic["Message"] = dt.Rows[0]["Msg"].ToString();
                    dic["Status"] = dt.Rows[0]["Status"].ToString();
                    dic["Focus"] = dt.Rows[0]["Focus"].ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }

        public JsonResult Edit(string AddCategoryId)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@AddCategoryId", AddCategoryId } };
                DataTable dt = DBManager.ExecuteProcess("USP_ShowAddProductcategory", param);
                if (dt.Rows.Count > 0)
                {
                    dic["CategoryName"] = dt.Rows[0]["CategoryName"].ToString();
                    dic["IsActive"] = dt.Rows[0]["IsActive"].ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }


        public JsonResult DeleteDescription(string id)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@id", id } };
                DataTable dt = DBManager.ExecuteProcess("USP_DeleteDesc", param);
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        public JsonResult DeletePdf(string id)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@id", id } };
                DataTable dt = DBManager.ExecuteProcess("USP_DeletePdf", param);
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        #endregion  AddProductCategory

        #region AddSubProductCategory
        public ActionResult AddSubCategory()
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("Loginpage");
            }
            else
            {
                DataTable dt = DBManager.ExecuteProcess("USP_BindProductCategory");
                return View(dt);
            }

        }
        public JsonResult InsertUpdateAddSubCategory(string AddSubCateId, string ddlCategoryName, string AddSubCategory, bool Active)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                if (string.IsNullOrWhiteSpace(ddlCategoryName))
                {
                    dic["Message"] = "Please Select ddlCategoryName";
                    dic["Focus"] = "ddlCategoryName";
                }
                else if (string.IsNullOrWhiteSpace(AddSubCategory))
                {
                    dic["Message"] = "Please Enter AddSubCategory";
                    dic["Focus"] = "txtAddSubCategory";
                }
                else
                {
                    string[,] Param = new string[,] { { "@AddSubCateId", AddSubCateId }, { "@ddlCategoryName", ddlCategoryName }, { "@AddSubCategory", AddSubCategory }, { "@Active", Active ? "1" : "0" } };
                    DataTable dt = DBManager.ExecuteProcess("USP_InsertUpdateAddSubProductCategory", Param);
                    if (dt.Rows.Count > 0)
                    {
                        dic["Message"] = dt.Rows[0]["Msg"].ToString();
                        dic["Status"] = dt.Rows[0]["Status"].ToString();
                        dic["Focus"] = dt.Rows[0]["Focus"].ToString();
                    }
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        public JsonResult ShowAddSubProductCategory()
        {
            StringBuilder sb = new StringBuilder();
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                DataTable dt = DBManager.ExecuteProcess("USP_ShowAddSubProductcategory");
                if (dt.Rows.Count > 0)
                {
                    sb.Append("<table class='table table-responsibe'><tr style='background:#484747;color:white;'>");
                    sb.Append("<th>Sr. No.</th>");
                    sb.Append("<th>Category</th>");
                    sb.Append("<th>Add Sub Category</th>");
                    sb.Append("<th>Status</th>");
                    sb.Append("<th>Delete</th>");
                    sb.Append("<th>Edit</th></tr>");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.Append("<tr><td>" + dt.Rows[i]["AddSubCate Id"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["ddlCategoryName"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["AddSubCategory"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["Active"].ToString() + "</td>");
                        sb.Append("<td><button type='button' class='btn btn-danger' onclick='DelAddSubProductCategory(" + dt.Rows[i]["AddSubCateId"].ToString() + ")'><i class='fa fa-trash'aria-hidden='true'></i></td>");
                        sb.Append("<td><button type='button' class='btn btn-success' onclick='EditAddSubProductCategory(" + dt.Rows[i]["AddSubCateId"].ToString() + ")'><i class='fa fa-edit'></i></td></tr>");
                    }
                    sb.Append("</table>");
                    dic["Grid"] = sb.ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        public JsonResult DelAddSubProductCategory(string AddSubCateId)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@AddSubCateId", AddSubCateId } };
                DataTable dt = DBManager.ExecuteProcess("USP_DeleteAddSubProductCategory", param);
                if (dt.Rows.Count > 0)
                {
                    dic["Message"] = dt.Rows[0]["Msg"].ToString();
                    dic["Status"] = dt.Rows[0]["Status"].ToString();
                    dic["Focus"] = dt.Rows[0]["Focus"].ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        public JsonResult EditAddSubProductCategory(string AddSubCateId)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@AddSubCateId", AddSubCateId } };
                DataTable dt = DBManager.ExecuteProcess("USP_ShowAddSubProductcategory", param);
                if (dt.Rows.Count > 0)
                {
                    dic["ddlCategoryName"] = dt.Rows[0]["ddlCategoryName"].ToString();
                    dic["AddSubCategory"] = dt.Rows[0]["AddSubCategory"].ToString();
                    dic["Active"] = dt.Rows[0]["Active"].ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        #endregion  AddSubProductCategory

        #region AddProduct 
        public ActionResult AddProduct()
        {

            //string[,] Param = new string[,] { { "@AddCategoryId", "0" } };
            //DataTable dt = DBManager.ExecuteProcess("USP_BindProductCategory", Param);
            //ViewBag.Data = dt;
            //string[,] param = new string[,] {
            //    { "@AddSubCateId", "0" },
            //    { "@ddlCategoryName", ddlCategoryName } };
            //DataTable dt1 = DBManager.ExecuteProcess("USP_BindProductSubCategory", param);
            if (Session["id"] == null)
            {
                return RedirectToAction("Loginpage");
            }
            else
            {
                return View();
            }
        }

        public JsonResult ddlSubCategoryName(string ddlCategoryName)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Result"] = "";
            dic["Focus"] = "";
            dic["Status"] = "0";
            try
            {
                if (ddlCategoryName.Trim() != "")
                {
                    string[,] Param = new string[,]
                {
                    {"@ddlCategoryName", ddlCategoryName } ,
                };
                    DataTable dt = DBManager.ExecuteProcess("USP_BindProductSubCategory", Param);
                    dic["Result"] = "<option value=''>--Select--</option>";
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            dic["Result"] += "<option value='" + dt.Rows[i]["AddSubCategory"] + "'>" + dt.Rows[i]["AddSubCategory"] + "</option>";
                        }

                    }
                    dic["Focus"] = "dic";
                    dic["Status"] = "1";
                }
                else
                {
                    dic["Result"] = "<option value=''>--Select--</option>";
                    dic["Focus"] = "ddlCategoryName";
                    dic["Status"] = "0";
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        public JsonResult ddlCategoryName()
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Result"] = "";
            try
            {
                DataTable dt = DBManager.ExecuteProcess("USP_BindProductCategory");
                dic["Result"] = "<option value=''>--Select--</option>";
                if (dt.Rows.Count > 0)
                {
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        dic["Result"] += "<option value='" + dt.Rows[i]["CategoryName"] + "'>" + dt.Rows[i]["CategoryName"] + "</option>";
                    }

                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        [HttpPost]
        public JsonResult InsertUpdateAddProduct(string ProductID, string ddlCategoryName, string ddlSubCategoryName, 
            string ProductName, string shortDescription, string ProductImage,string Content, bool Active,
            List<string> id_title_heading_description,List<string> id_fileheading_image)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            dic["Status"] = "0";
            var title = "";
            var heading = "";
            var description = "";
            var fileheadin = "";
            var image = "";
            var productid = "0";
            for (int i = 0; i < id_title_heading_description.Count; i++)
            {
                var a1=id_title_heading_description[i].Split('#')[0];
                var a2=id_title_heading_description[i].Split('#')[1];
                var a3=id_title_heading_description[i].Split('#')[2];
                var a4=id_title_heading_description[i].Split('#')[3];
                if (a2 == "")
                {
                    title = "txttitle" + Convert.ToInt32(i + 1) ;
                }
                else if (a3 == "")
                {
                    heading = "txtHeading" + Convert.ToInt32(i + 1) ;
                }
                else if (a4=="")
                {
                    description = "txtDescription" + Convert.ToInt32(i + 1);
                }
            }
            for (int i = 0; i < id_fileheading_image.Count; i++)
            {
                var b1=id_fileheading_image[i].Split('#')[0];
                var b2=id_fileheading_image[i].Split('#')[1];
                var b3=id_fileheading_image[i].Split('#')[2];
                if (b2 == "")
                {
                    fileheadin = "txtPdfHeading" + Convert.ToInt32(i+1);
                }
                else if(b3 == "" || b3== "undefined")
                {
                    image= "filePdfHeading" + Convert.ToInt32(i + 1);
                }
            }
            try
            {
                if (string.IsNullOrWhiteSpace(ddlCategoryName))
                {
                    dic["Message"] = "Please Enter ddlCategoryName";
                    dic["Focus"] = "ddlCategoryName";
                }
                else if (string.IsNullOrWhiteSpace(ddlSubCategoryName))
                {
                    dic["Message"] = "Please Enter ddlSubCategoryName";
                    dic["Focus"] = "ddlSubCategoryName";
                }
                else if (string.IsNullOrWhiteSpace(ProductName))
                {
                    dic["Message"] = "Please Enter ProductName";
                    dic["Focus"] = "txtProductName";
                }
                else if (title!="")
                {
                    dic["Message"] = "Please Enter title";
                    dic["Focus"] = title;
                }
                else if (heading != "")
                {
                    dic["Message"] = "Please Enter heading";
                    dic["Focus"] = heading;
                }
                else if (description != "")
                {
                    dic["Message"] = "Please Enter description";
                    dic["Focus"] = description;
                }
                else if (fileheadin != "")
                {
                    dic["Message"] = "Please Enter fileheadin";
                    dic["Focus"] = fileheadin;
                }
                else if (image!="")
                {
                    dic["Message"] = "Please Select pdf";
                    dic["Focus"] = image;
                }
                else
                {
                    string[,] Param = new string[,]
                    {
                    {"@ProductID", ProductID } ,
                    {"@Category",ddlCategoryName},
                    {"@SubCategory",ddlSubCategoryName },
                    {"@ProductName",ProductName },
                    {"@Image",ProductImage },
                    {"@Content",Content},
                    {"@shortDescription",shortDescription},
                    {"@Active",Active?"1":"0" }
                    };
                    DataTable dt = DBManager.ExecuteProcess("USP_InsertUpAddProduct", Param);
                    if (dt.Rows.Count > 0)
                    {
                        dic["Message"] = dt.Rows[0]["Msg"].ToString();
                        dic["Status"] = dt.Rows[0]["Status"].ToString();
                        productid= dt.Rows[0]["id"].ToString();

                    }
                    if (dic["Status"] != "0")
                    {
                        for (int i = 0; i < id_title_heading_description.Count; i++)
                        {
                            var a1 = id_title_heading_description[i].Split('#')[0];
                            var a2 = id_title_heading_description[i].Split('#')[1];
                            var a3 = id_title_heading_description[i].Split('#')[2];
                            var a4 = id_title_heading_description[i].Split('#')[3];
                            string[,] Param1 = new string[,]
                            {
                                {"@id", a1 } ,
                                {"@title",a2.Trim()},
                                {"@heading",a3.Trim() },
                                {"@description",a4.Trim() },
                                {"@productid",productid},
                            };
                            DataTable dt1 = DBManager.ExecuteProcess("USP_Product_id_title_heading_description", Param1);
                        }
                        for (int i = 0; i < id_fileheading_image.Count; i++)
                        {
                            var b1 = id_fileheading_image[i].Split('#')[0];
                            var b2 = id_fileheading_image[i].Split('#')[1];
                            var b3 = id_fileheading_image[i].Split('#')[2];
                            string[,] Param2 = new string[,]
                            {
                                {"@id", b1 } ,
                                {"@fileheading",b2.Trim()},
                                {"@image",b3.Trim() },
                                {"@productid",productid },
                            };
                            DataTable dt2 = DBManager.ExecuteProcess("USP_Product_id_fileheading_image", Param2);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        public JsonResult ShowAddProduct()
        {
            StringBuilder sb = new StringBuilder();
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] Param = new string[,]
                 {
                    {"@ProductID", "0" }
                 };
                DataTable dt = DBManager.ExecuteProcess("USP_ShowAddProduct");

                if (dt.Rows.Count > 0)
                {
                    sb.Append("<table class='table table-responsibe'><tr style='background:#484747;color:white;'>");
                    sb.Append("<th>Sr. No.</th>");
                    sb.Append("<th>Category Name</th>");
                    sb.Append("<th>Sub Category Name</th>");
                    sb.Append("<th>Product Name</th>");
                    //sb.Append("<th>Image</th>");
                    //sb.Append("<th>Image Type</th>");
                    //sb.Append("<th>Image Name</th>"); 
                    //sb.Append("<th>FullDescription</th>");
                    sb.Append("<th>Content</th>");
                    sb.Append("<th>short Description</th>");
                    sb.Append("<th>Status</th>");
                    sb.Append("<th>Delete</th>");
                    sb.Append("<th>Edit</th></tr>");
                    for (int i = 0; i < dt.Rows.Count; i++)
                    {
                        sb.Append("<tr><td>" + dt.Rows[i]["Product ID"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["Category"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["SubCategory"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["ProductName"].ToString() + "</td>");
                        //sb.Append("<td><img src='data:Image/jpeg;base64," + dt.Rows[i]["Image"].ToString() + "'width='60px',height='50px'/></td>");
                        //sb.Append("<td>" + dt.Rows[i]["FullDescription"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["Content"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["shortDescription"].ToString() + "</td>");
                        sb.Append("<td>" + dt.Rows[i]["Active"].ToString() + "</td>");
                        sb.Append("<td><button type='button' class='btn btn-danger' onclick='DelAddProduct(" + dt.Rows[i]["ProductID"].ToString() + ")'><i class='fa fa-trash'aria-hidden='true'></i></td>");
                        sb.Append("<td><button type='button' class='btn btn-success' onclick='EditAddProduct(" + dt.Rows[i]["ProductID"].ToString() + ")'><i class='fa fa-edit'></i></td></tr>");
                    }
                    sb.Append("</table>");
                    dic["Grid"] = sb.ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }
        public JsonResult DelAddProduct(string ProductID)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@ProductID", ProductID } };
                DataTable dt = DBManager.ExecuteProcess("USP_DeleteAddProduct", param);
                if (dt.Rows.Count > 0)
                {
                    dic["Message"] = dt.Rows[0]["Msg"].ToString();
                    dic["Status"] = dt.Rows[0]["Status"].ToString();
                    dic["Focus"] = dt.Rows[0]["Focus"].ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }

        public JsonResult EditAddProduct(string ProductID)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            try
            {
                string[,] param = new string[,] { { "@ProductID", ProductID } };
                DataTable dt = DBManager.ExecuteProcess("USP_ShowAddProduct", param);
                if (dt.Rows.Count > 0)
                {
                    dic["ddlCategoryName"] = dt.Rows[0]["Category"].ToString();
                    dic["ddlSubCategoryName"] = dt.Rows[0]["SubCategory"].ToString();
                    dic["ProductName"] = dt.Rows[0]["ProductName"].ToString();
                    dic["ProductImage"] = dt.Rows[0]["Image"].ToString();
                    dic["shortDescription"] = dt.Rows[0]["shortDescription"].ToString();
                    dic["Content"] = dt.Rows[0]["Content"].ToString();
                    dic["Active"] = dt.Rows[0]["Active"].ToString();
                    dic["descid"] = dt.Rows[0]["descid"].ToString();
                    dic["title"] = dt.Rows[0]["title"].ToString();
                    dic["heading"] = dt.Rows[0]["heading"].ToString();
                    dic["description"] = dt.Rows[0]["description"].ToString();
                    dic["imageid"] = dt.Rows[0]["imageid"].ToString();
                    dic["fileheading"] = dt.Rows[0]["fileheading"].ToString();
                    dic["image"] = dt.Rows[0]["images"].ToString();
                }
            }
            catch (Exception ex)
            {
                dic["Message"] = ex.Message;
            }
            return Json(dic);
        }

        #endregion  AddProduct

        #region chagePssword
        public ActionResult chagePssword()
        {
            if (Session["id"] == null)
            {
                return RedirectToAction("Loginpage");
            }
            else
            {
                return View();
            }
        }
 
        public JsonResult UpdatebtnChangePassword(string CurrentPassword, string NewPassword)
        {
            Dictionary<string, string> dic = new Dictionary<string, string>();
            dic["Message"] = "";
            dic["Status"] = "0";
            dic["Focus"] = "";

            try
            {
                string[,] param = new string[,]
                {
                    {"@NewPassword",NewPassword},
                    {"@Password",CurrentPassword}
                };
                DataTable dt = DBManager.ExecuteProcess("USP_UpdateChangePassword", param);
                if (dt.Rows.Count > 0)
                {
                    dic["Message"] = dt.Rows[0]["Msg"].ToString();
                    dic["Status"] = dt.Rows[0]["Status"].ToString();
                    dic["Focus"] = dt.Rows[0]["Focus"].ToString();
                }

            }
            catch (Exception e)
            {
                dic["Message"] = e.Message;
            }
            return Json(dic);
        }

        #endregion  chagePssword
    }

}