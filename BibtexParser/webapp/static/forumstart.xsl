<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/forum">
<html>
<head>
	
</head>
 
<body>
		<h3>Forum</h3>
			<br></br>
			<a href="../user"> Zur Userverwaltung</a>
				<table border="1">
					<tr bgcolor="#FF4500">
					<th>Name</th>
					<th>Link</th>
					<th>Löschen</th>
					</tr>
					<xsl:for-each select="kategorie">
						<tr>
						<xsl:variable name="var1"><xsl:value-of select="name"/></xsl:variable>
							<td><xsl:value-of select="name"/></td>
							<td>
							<b><a href="../forum/{$var1}">Zu dein Eintraegen.</a></b>
							</td>
														<td>
							<b><a href="../delete/{$var1}">Löschen.</a></b>
							</td>
						</tr>
				</xsl:for-each>	
				</table>
				<a href="../add/kat"> Neue Kategorie</a>
				<br></br>
				
				
</body>
</html>
</xsl:template>
</xsl:stylesheet>
	