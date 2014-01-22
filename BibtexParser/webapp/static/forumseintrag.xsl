<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="*">
<html>
<head>
	
</head>
 
<body>
		<xsl:variable name="kat"><xsl:value-of select="./@kat"/></xsl:variable>
		<xsl:variable name="thema"><xsl:value-of select="./thema/@titel"/></xsl:variable>
		<h3><xsl:value-of select="./thema/@titel"/></h3>
			 <br></br><br></br>
				
				   <xsl:for-each select="thema/eintrag">
				   <xsl:variable name="id"><xsl:value-of select="./@id"/></xsl:variable>
							<xsl:value-of select="@autor"/>  <xsl:text>&#9;</xsl:text>
							<xsl:value-of select="text"/>
							<xsl:for-each select="text/eintrRef">
							  <xsl:variable name="refthema"><xsl:value-of select="@themaRef"/></xsl:variable>
							<a href="{$refthema}"> zur Referenz</a>
							</xsl:for-each>
							<a href="../../../add/eintrag/{$kat}/{$thema}/{$id}"> Antworten</a>
							<a href="../../../delete/{$kat}/{$thema}/{$id}"> Löschen</a>
							<br></br>
				   <xsl:call-template name="eintrag">
							 <xsl:with-param name="anzahl">	1 </xsl:with-param> 
							       <xsl:with-param name="kat"><xsl:value-of select="$kat"/></xsl:with-param>
								    <xsl:with-param name="thema"><xsl:value-of select="$thema"/></xsl:with-param>
					 </xsl:call-template>	
				  </xsl:for-each>	
					<a href="../../../add/eintrag/{$kat}/{$thema}"> Neuer Eintrag</a>
				<br></br>
				<br></br>
				<a href="/index"> Zur Startseite</a>
				
</body>
</html>
</xsl:template>

<xsl:template name="eintrag">
<xsl:param name="anzahl"/>
<xsl:param name="kat"/>
<xsl:param name="thema"/>
 <xsl:for-each select="eintrag"> 
  <xsl:variable name="id"><xsl:value-of select="./@id"/></xsl:variable>
	<xsl:call-template name="abstand">
      <xsl:with-param name="mal"><xsl:value-of select="$anzahl"/></xsl:with-param>
    </xsl:call-template>
							<xsl:value-of select="@autor"/>  <xsl:text>&#9;</xsl:text>
							<xsl:value-of select="text"/>
							<xsl:for-each select="text/eintrRef">
							  <xsl:variable name="refthema"><xsl:value-of select="@themaRef"/></xsl:variable>
							<a href="{$refthema}"> zur Referenz</a>
							</xsl:for-each>
							<a href="../../../add/eintrag/{$kat}/{$thema}/{$id}"> Antworten</a>
							<a href="../../../delete/{$kat}/{$thema}/{$id}">  Löschen</a>
							<br></br>
					   <xsl:call-template name="eintrag">
							 <xsl:with-param name="anzahl">
									<xsl:value-of select="$anzahl+1"/>
							 </xsl:with-param> 
							  <xsl:with-param name="kat"><xsl:value-of select="$kat"/></xsl:with-param>
								    <xsl:with-param name="thema"><xsl:value-of select="$thema"/></xsl:with-param>
					 </xsl:call-template>							
				  </xsl:for-each>	
</xsl:template>

<xsl:template name="abstand">
<xsl:param name="mal"/>
      <xsl:if test="$mal &gt; 0">
      &#160;&#160;&#160;&#160;
		<xsl:call-template name="abstand">
			<xsl:with-param name="mal"> <xsl:value-of select="$mal -1 "/></xsl:with-param>
		</xsl:call-template>
	
      </xsl:if>

</xsl:template>

</xsl:stylesheet>


	