using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace AKS_Machin_Test.Models
{
    public class ChagePassword
    {
        [Required,DataType(DataType.Password),Display(Name = "Please Enter CurrentPassword")]
        public string CurrentPassword { get; set; }
        [Required, DataType(DataType.Password), Display(Name = "Please Enter NewPassword")]
        public string NewPassword { get; set; }
        [Required, DataType(DataType.Password), Display(Name = "Please Enter CurrentPassword")]
        [Compare("NewPassword",ErrorMessage = "Confirm New Password does Not Match")]
        public string ConfirmPassword { get; set; }
    }
}