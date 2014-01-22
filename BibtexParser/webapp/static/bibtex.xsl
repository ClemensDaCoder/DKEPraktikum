<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/bibtex">
<html>
<head>
	
</head>
 
<body>
		<h3>Bibtex</h3>
			<br></br>
      <form action="upload" method="POST" enctype="multipart/form-data">
  <input type="file" name="files"  multiple="multiple"/>
  <input type="submit"/>
		</form>


				<br></br>
				
				
</body>
</html>
</xsl:template>
</xsl:stylesheet>
	