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
        form{
            margin: 5% 0 0 8%;

            width: 81vw;

        }
        table {

            width: 80vw;
            height: 60vh;
            font-size: 2.5rem;
        }

        td {
            text-align: center;

        }
        input[type="submit"]{
            height: 70%;
            width: 60%;
            font-size: 70%;
            border-radius: 1rem;
        }
        #selected{
            width: 80%;
            text-align: center;
            font-size: 80%;
        }
        input[type="text"]{
            width: 80%;
            height: 50%;
            font-size: 90%;
        }
        input[type="number"]{
            width: 80%;
            height: 50%;
            font-size: 90%;
        }
        textarea{
            width: 80%;
            height:60%;
            font-size: 90%;
        }
    </style>

    <body>
        <form action="delete.jsp">

            <input type="hidden" name="hide" id="hide">
            <table>

                <tr>
                    <th colspan="5">
                        Remove  Your UnWanted Item's Here.....
                    </th>
                </tr>
                <tr>
                    <th colspan="1">
                        Select Item's Id 
                    </th>
                    <th colspan="2">
                        <input type="submit" value="Click To Remove Selected Row">

                    </th>
                </tr>
                <tr>
                    <td colspan="1">
                        <select id="selected" onchange="fill()">
                            <option>--Select Id--</option>
                            <%
                                String id = "";
                                Statement st;
                                Connection con;
                                Class.forName("com.mysql.cj.jdbc.Driver");
                                con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"
                                        + "dbemp?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "root");
                                st = con.createStatement();
                                id = request.getParameter("hide");
                                if (id != null) {
                                    st.execute("Delete from erp_ac where s_id='" + id + "'    ");
                                }
                                ResultSet rs = st.executeQuery("select * from erp_ac");
                                while (rs.next()) {

                            %>
                            <option value="<%=rs.getString(1)%>/<%=rs.getString(2)%>/<%=rs.getString(3)%>/<%=rs.getString(4)%>/<%=rs.getString(5)%>"><%=rs.getString(1)%></option>
                            <%
                                }

                                st.close();
                                con.close();
                            %> 
                        </select>
                    </td>
                    <td>
                        Item Name :
                    </td>
                    <td>
                        <input type="text" size="30" id="t1">
                    </td>
                </tr>
                 <tr>
                    <td></td>
                    <td>
                        Item Price :
                    </td>
                    <td>
                        <input type="number" size="10" id="t4">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        Item Quantity :
                    </td>
                    <td>
                        <input type="number" size="10" id="t2">
                    </td>
                </tr>
                <tr>
                    <td></td>
                    <td>
                        Item Description:
                    </td>
                    <td>
                        <textarea name="t3" id="t3" cols="25" rows="2"></textarea>
                    </td>
                </tr>
            </table>

        </form>

        <script>
            let MyReturn;
            MyReturn = document.getElementById("selected");
            let tt1 = document.getElementById("t1");
            let tt2 = document.getElementById("t2");
            let tt3 = document.getElementById("t3");
            let tt4 = document.getElementById("t4");
            let myhide = document.getElementById("hide");

            function fill() {
                let a = MyReturn.value.split("/");
                myhide.value = a[0];
                tt1.value = a[1];
                tt2.value = a[2];
                tt3.value = a[3];
                tt4.value = a[4];

            }
        </script>


    </body>

</html>


