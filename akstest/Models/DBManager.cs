using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.SqlClient;
using System.Data;
using System.Configuration;

namespace AKS_Machin_Test.Models
{
    public class DBManager
    {
       public static DataTable ExecuteProcess(string procedure,string[,] param)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings.Get("DBConnection"));
            SqlCommand command = new SqlCommand(procedure,connection);
            command.CommandType = CommandType.StoredProcedure;
            for(int i=0;i<param.Length/2; i++)
            {
                command.Parameters.AddWithValue(param[i, 0], param[i, 1]);
            }
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            return dt;
        }

        public static DataTable ExecuteProcess(string procedure)
        {
            SqlConnection connection = new SqlConnection(ConfigurationManager.AppSettings.Get("DBConnection"));
            SqlCommand command = new SqlCommand(procedure, connection);
            command.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter adapter = new SqlDataAdapter(command);
            DataTable dt = new DataTable();
            adapter.Fill(dt);
            return dt;
        }
    }
}