<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
  <html>
<head>
    <script type='text/javascript'><![CDATA[
        function addFields(){
            var number = document.getElementById("member").value;
            // Container <div> where dynamic content will be placed
            var container = document.getElementById("container");
            // Clear previous contents of the container
            while (container.hasChildNodes()) {
                container.removeChild(container.lastChild);
            }
            for (i=0;i<number;i++){
                // Append a node with a random text
                container.appendChild(document.createTextNode("Member " + (i+1)));
                // Create an <input> element, set its type and name attributes
                var input = document.createElement("input");
                input.type = "text";
                input.name = "member" + i;
                container.appendChild(input);
                // Append a line break 
                container.appendChild(document.createElement("br"));
            }
        }
		]]>
    </script>
</head>
<body>
  <h2>Details</h2>
   <form method="post" id="member" action="new">
        <b>mdate: </b><input name="mdate" size="50"></input><br />
         <b>key: </b><input name="key" size="50"></input> darf keine '_' enthalten. <br />
         <b>author: </b><input name="author" size="50"></input><br />
         <b>title: </b><input name="title" size="50"></input><br />
        <input type="submit" />
     </form>
	<input type="text" id="member1" name="member" value="">Number of members: (max. 10)<br /> </input>
    <a href="#" id="filldetails" onclick="addFields()">Fill Details</a>
    <div id="container"/>
	<h3> test </h3>
</body>
</html>
</xsl:template>
</xsl:stylesheet>

<!--
 <body>
  <h2>Details</h2>
        <form method="post" action="new">
        <b>mdate: </b><input name="mdate" size="50"></input><br />
         <b>key: </b><input name="key" size="50"></input> darf keine '_' enthalten. <br />
         <b>author: </b><input name="author" size="50"></input><br />
         <b>title: </b><input name="title" size="50"></input><br />
        <input type="submit" />
      </form>
  </body> -->