
<%@page contentType="text/html" pageEncoding="UTF-8"%> 
<%@page import="java.io.*"%>
<%@page import="java.sql.*"%> 
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
    </head>
    <style>
        * {
            margin: 0;
            padding: 0;
        }

        html {
            font-size: 62.5%;
        }

        html,
        body {
            width: 100vw;
            height: 100vh;

        }

        form {
            position: relative;
            top: 8%;
            left: 15%;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 2rem;
            text-align: center;
            width: 80%;
            height: 70%;

        }

        textarea {
            height: 60%;
            font-size: 90%;
        }


        input {
            height: 60%;
            font-size: 90%;

        }


        input[type="submit"] {
            width: 80%;
            height: 80%;
            font-size:100%;
            border-radius: 1rem;

        }

        input[type="reset"] {

            width: 45%;
            height: 83%;
            font-size:100%;
            border-radius: 1rem;
        }

        #h3{
            visibility: hidden;
            color: green;

        }
        td {
            text-align: right;
            font-size: 100%;

        }

        table {
            width: 90%;
            height: 100%;
        }

        .in {
            text-align: left;
        }
    </style>

    <body>

        <form action="add.jsp" method="get">
            <table>
                <tr>
                    <th colspan="2">

                        <h3 id="h3"> Item's Added In Stock SuccessFully....</h3>

                    </th>
                </tr>
                <tr>
                    <th colspan="2">
                        Fill The Stock Detail Here.....
                    </th>
                </tr>
                <tr>
                    <td>Enter Id :</td>
                    <td class="in"><input type="text" name="id" id="main" size="30" onkeyup="oncall()" ></td>
                </tr>
                <tr>
                    <td> Enter Item_Name :</td>
                    <td class="in"><input type="text" name="name" class="txt" size="30"></td>
                </tr>
                <tr>
                    <td> Enter Item_Price :</td>
                    <td class="in"><input type="text" name="rate"  class="txt"size="30"></td>
                </tr>
                <tr>
                    <td> Enter Quantity :</td>
                    <td class="in"><input type="text" name="quan" class="txt" size="30"></td>
                </tr>
                <tr>
                    <td>Add Description :</td>
                    <td class="in"> <textarea name="des" class="txt" cols="25" rows="2"     ></textarea></td>
                </tr>
                <tr>
                    <td><input type="submit" value="Click To Add Stock"></td>
                    <td class="in"> <input type="reset" value="Reset All Item's"></td>
                </tr>



            </table>
        </form>

        <%
            String id, name, quan, des1, price;
            id = request.getParameter("id");
            name = request.getParameter("name");
            quan = request.getParameter("quan");
            des1 = request.getParameter("des");
            price = request.getParameter("rate");
            Statement st;
            Connection con;
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/"
                    + "mydb1?zeroDateTimeBehavior=CONVERT_TO_NULL", "root", "root1234");
            st = con.createStatement();
            String col = "", row = "";

            ResultSet rs = st.executeQuery("SELECT count(*) AS myno FROM information_schema.columns where table_name='erp_ac'; ");
            while (rs.next()) {
                col = rs.getString(1); //it giv column
            }
            ResultSet rs1 = st.executeQuery("SELECT count(*)  from erp_ac; ");
            while (rs1.next()) {
                row = rs1.getString(1); //its give rows
            }

            ResultSet rs3 = st.executeQuery("select * from erp_ac");
            int r, c;
            c = Integer.parseInt(col);
            r = Integer.parseInt(row);
            String str[][];
            str = new String[r][c];
            int k = 0;
            while (rs3.next()) {
                for (int j = 0; j < c; j++) {
                    str[k][j] = rs3.getString(j + 1);

                }
                k++;
            }

            String vis = "visible";
            if (id != null || name != null || quan != null || des1 != null || price != null) {
                    boolean b1 = st.execute("insert into erp_ac values('" + id + "','" + name + "'," + price + "," + quan + ",'" + des1 + "')");
                if (b1 == false) {
        %>

        <Script>
            let x = document.getElementById("h3");
            x.style.visibility = "visible";
            setTimeout(hide, 3000);
            function hide() {
                x.style.visibility = "hidden";
            }



        </Script>

        <%
                } else {
                    out.print("<h2>Item not added</h2>");
                }
            }
            st.close();
            con.close();
        %>





    </body>
    <script>

        let a;
        let data = [];
        let data2 = [];
        let row1 = "<%=row%>";
        let col1 = "<%=col%>";
        let r = parseInt(row1);
        let c = parseInt(col1);




        a = "<%
            for (int i = 0; i < str.length; i++) {

                for (int j = 0; j < str[i].length; j++) {
                    out.print(str[i][j] + "/");
                }

            }
        %>";



        data2 = a.split("/");
        
        let inc = 0;
        for (let i = 0; i < r; i++) {
            data[i] = [];
            for (let j = 0; j < c; j++) {
                data[i][j] = data2[inc];
                inc++;
            }          
        }

        
        console.log(data)
        let main = document.getElementById("main");
        let txt = document.getElementsByClassName("txt");

        function  oncall() {

            for (let i = 0; i < r; i++) {
                if (main.value == data[i][0]) {
                    for (let j = 0; j < c - 1; j++) {
                        txt[j].value = data[i][j + 1];
                    }
                }//if 
                else {
                    if (i == 0) {
                        for (let j = 0; j < c - 1; j++) {
                            txt[j].value = " ";
                        }
                    }//flag
                }//else

            }//big for
        }
    </script>      
</html>