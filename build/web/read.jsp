<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%> 
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Read Page</title>
    </head>
    <style>
        html {
            font-size: 62.5%;
        }

        table {
            text-align: center;
            margin: 3% 0 0 15%;
            font-size: 2.5vw;
            width: 70vw;

        }

        th {
            border: 0.2rem solid red;
            background-color: yellow;
        }

        td {
            border: 0.2rem solid blueviolet;
            background-color: greenyellow;
        }
    </style>

    <body>
        <table>
            <tr>
                <th>Item Id</th>
                <th>Item Name</th>
                <th>Item Price</th>
                <th>Item Quantity</th>
                <th>Item Description</th>
            </tr>

            <%

                Statement st;
                Connection con;
                Class.forName("com.mysql.cj.jdbc.Driver");
                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"
                        + "dbemp?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "root");
                st = con.createStatement();
                ResultSet rs = st.executeQuery("select * from erp_ac");
                while (rs.next()) {

            %>
            <tr>
                <td><%=rs.getString(1)%></td>
                <td><%=rs.getString(2)%></td>
                <td><%=rs.getString(5)%></td>
                <td><%=rs.getString(3)%></td>
                <td><%=rs.getString(4)%></td>

            </tr>
            <%
                }

                st.close();
                con.close();
            %>
        </table>
    </body>

</html>
