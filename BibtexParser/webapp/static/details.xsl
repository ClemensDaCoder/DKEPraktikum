<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  

<xsl:template match="/">
  <html>
  <body>
  <h2>Details </h2>
  <xsl:apply-templates/>
  </body>
  </html>
</xsl:template>

<xsl:template match="article">
  <p>
  <xsl:apply-templates select="@key"/><br></br>
   <xsl:apply-templates select="@mdate"/><br></br>
    <xsl:apply-templates/>

<script type="text/javascript">
function getDetailsLink()
{

 var key = "<xsl:value-of select="@key"/>";
 
 var find = '/';
 var re = new RegExp(find, 'g');
 key = key.replace(re, '_');
 var link = "http://localhost:8984/change/" + key;
 window.open(link);
}
</script>
		 <!-- <xs:group ref="pageselements"/> 
          <xs:element ref="url"/>
          <xs:element ref="volume"/>
          <xs:element ref="year"/>
        </xs:choice>
      </xs:sequence>
       <xs:attributeGroup ref="attributegrmp"/>
	  <xs:attribute name="rating" type="xs:string"/>
      <xs:attribute name="reviewid" type="xs:anyURI"/>
  
  -->
  </p>
  <xsl:variable name="key" select="@key"/>
  <a href="#" onclick="javascript:getDetailsLink();">Bearbeiten/Löschen </a> <br></br>
</xsl:template>

<xsl:template match="title">
Title: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>

<xsl:template match="author">
Author: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>

<xsl:template match="school">
School: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>

<xsl:template match="editor">
Editor: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>

<xsl:template match="author">
Author: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>

<xsl:template match="booktitle">
Booktitle: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
<xsl:template match="cdrom">
Cdrom: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
<xsl:template match="cite">
Cite: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
<xsl:template match="crossref">
Crossref: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
<xsl:template match="ee">
EE: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
 <xsl:template match="journal">
Journal: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template><xsl:template match="month">
Month: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template><xsl:template match="note">
Note: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template><xsl:template match="number">
Number: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template><xsl:template match="publisher">
Publisher: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template> 
<xsl:template match="url">
Url: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
<xsl:template match="volume">
volume: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
<xsl:template match="year">
Year: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>
<xsl:template match="from">
from: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>

<xsl:template match="to">
to: <strong>
  <xsl:value-of select="."/></strong>
  <br />
</xsl:template>


</xsl:stylesheet>


	