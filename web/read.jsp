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
            margin: 0 0 0 0;
            width: 99vw;
            height: 80vh;

        }

        th {
            height: 3rem;
            font-size: 3rem;
            border: 0.2rem solid red;
            background-color: yellow;
        }

        td {
            height: 2rem;
            border: 0.2rem solid blueviolet;
            background-color: greenyellow;
        }

        input {
            text-align: center;
            width: 100%;
            height: 100%;
            font-size: 3rem;
            background-color: transparent;
            border: none;
        }

        textarea {
            position: relative;
            top: 0.3rem;
            border: none;
            background-color: transparent;
            width: 99%;
            height: 99%;
            font-size: 3rem;

        }

        .t1 {
            width: 1rem;
        }

        .t2 {
            width: 15%;
        }

        .t3 {
            width: 10%;
        }

        .t4 {
            width: 31%;
        }
    </style>

    <body>
        <form action="read.jsp"id="f1" >
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
                    Connection cn;
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    cn = DriverManager.getConnection("jdbc:mysql://localhost:3306/"
                            + "mydb1?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "root1234");
                    st = cn.createStatement();
                    String id, name, quan, rate, des;
                    id = request.getParameter("1");
                    name = request.getParameter("2");
                    rate = request.getParameter("3");
                    quan = request.getParameter("4");
                    des = request.getParameter("5");

                    String data = "update erp_ac set s_name='" + name + "',s_quantity=" + quan + ","
                            + "s_description='" + des + "',s_rate=" + rate + "  where s_id='" + id + "'   ";

                    if (id != null || name != null || rate != null || quan != null || des != null) {
                        try {
                            st.execute(data);
                        } catch (Exception e) {
                            out.print(e);
                        }

                    }
                    String col = "";
                    ResultSet rs1 = st.executeQuery("SELECT count(*) AS myno FROM information_schema.columns where table_name='erp_ac'; ");
                    while (rs1.next()) {
                        col = rs1.getString(1); //it giv column
                    }

                    int zr = 1;
                    ResultSet rs = st.executeQuery("select * from erp_ac");
                    while (rs.next()) {

                %>
                <tr onkeyup="RowFind(this, event)">
                    <td class="t3"><input type="text" class="<%=zr%>"value="<%=rs.getString(1)%>" ></td>
                    <td class="t4"><input type="text"     class="<%=zr%>" value="<%=rs.getString(2)%>" ></td>
                    <td class="t2"><input type="number"    class="<%=zr%>"value="<%=rs.getString(3)%>" ></td>
                    <td class="t1"><input type="number"  class="<%=zr%>"value="<%=rs.getString(4)%>" ></td>
                    <td><textarea class="<%=zr%>"><%=rs.getString(5)%></textarea></td>
                </tr>
                <%

                        zr++;
                    }
                    int gcol = Integer.parseInt(col);
                    for (int co = 1; co <= gcol; co++) {
                %>
                <input type="hidden" name="<%=co%>" class="hid">
                <%
                    }

                    st.close();
                    cn.close();
                %>
            </table>
        </form>
        <script>
            let hid = document.getElementsByClassName("hid");


            function RowFind(rowno, event) {
                let x = event.key;

                if (x == "Enter") {
                    let no = rowno.rowIndex;
                    let rstr = document.getElementsByClassName("" + no + "");
                    for (let i = 0; i < hid.length; i++) {
                        hid[i].value = rstr[i].value;
                    }
                    document.forms.f1.submit();
                   
                }
            }


        </script>
    </body>

</html>