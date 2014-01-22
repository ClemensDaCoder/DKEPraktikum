<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/dblp">
<html>
<head>
	
</head>
<body>
			
			<h3>Article</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>AUTHOR</th>
					<th>TITLE</th>
          <th>JOURNAL</th>
          <th>YEAR</th> 
		  <th>Details</th>
					</tr>
					<xsl:for-each select="article">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="author"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="journal"/></td>
							<td><xsl:value-of select="year"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				
				<h3>Book</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>AUTHOR</th>
					<th>TITLE</th>
          <th>PUBLISHER</th>
          <th>YEAR</th> 
		  <th>Details</th>
					</tr>
					<xsl:for-each select="book">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="author"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="publisher"/></td>
							<td><xsl:value-of select="year"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				<h3>Incollection</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>AUTHOR</th>
					<th>TITLE</th>
          <th>Crossref</th>
          <th>YEAR</th> 
		  <th>Details</th>
					</tr>
					<xsl:for-each select="incollection">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="author"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="crossref"/></td>
							<td><xsl:value-of select="year"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				<h3>Inproceedings</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>AUTHOR</th>
					<th>TITLE</th>
          <th>CROSSREF</th>
          <th>YEAR</th> 
		  <th>Details</th>
					</tr>
					<xsl:for-each select="inproceedings">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="author"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							
							<td><xsl:value-of select="crossref"/></td>
							<td><xsl:value-of select="year"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				<h3>Mastersthesis</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>AUTHOR</th>
					<th>TITLE</th>
          <th>SCHOOL</th>
          <th>YEAR</th> 
		  <th>Details</th>
					</tr>
					<xsl:for-each select="mastersthesis">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="author"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="school"/></td>
							<td><xsl:value-of select="year"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				<h3>Phdthesis</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>AUTHOR</th>
					<th>TITLE</th>
          <th>School</th>
          <th>YEAR</th> 
		  <th>Details</th>
					</tr>
					<xsl:for-each select="phdthesis">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="author"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="school"/></td>
							<td><xsl:value-of select="year"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				<h3>Proceedings</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>Editor</th>
					<th>TITLE</th>
          <th>BOOKTITLE</th>
          <th>YEAR</th> 
		  <th>Details</th>
					</tr>
					<xsl:for-each select="proceedings">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="editor"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="booktitle"/></td>
							<td><xsl:value-of select="year"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				<h3>WWW</h3>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>KEY</th>
					<th>MDATE</th>
					<th>AUTHOR</th>
					<th>TITLE</th>
          <th>URL</th>
		  <th>Details</th>
					</tr>
					<xsl:for-each select="www">
					<xsl:sort select="title" /> <!-- sortiert die Element nach dem Titel -->
						<tr>
							<td><xsl:value-of select="@key"/></td>
							<xsl:variable name="key">
								<xsl:value-of select="@key"/>
							</xsl:variable>
							<td><xsl:value-of select="@mdate"/></td>
							<td>
							<xsl:for-each select="author"> 
							<xsl:value-of select="."/> , 
							</xsl:for-each>	
							</td>
							<td><xsl:value-of select="title"/></td>
							<td><xsl:value-of select="url"/></td>
							<td>
							<xsl:apply-templates select="@key"/>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<br></br>
				
				
				
</body>
</html>
</xsl:template>




<xsl:template match="@key">

<script type="text/javascript">
 function Function_Name(key)
{
 var find = '/';
 var re = new RegExp(find, 'g');
 key = key.replace(re, '_');
 var link = "http://localhost:8984/bykey/" + key;
window.location=link;
}
</script>
<a>
<xsl:attribute name="href">
#
 </xsl:attribute>
<xsl:attribute name="onclick">
  javascript:Function_Name('<xsl:value-of select="." />')
</xsl:attribute>
Details
</a>
</xsl:template>

</xsl:stylesheet>
	