<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">


  

<xsl:template match="/">
  <html>
  <body>
  <h2>Bearbeiten</h2>
   <form method="post" action="update">
   <xsl:apply-templates/>
	 <input type="submit"> </input>
   </form>
  </body>
  </html>
</xsl:template>

<xsl:template match="article">
  <p>
  <xsl:apply-templates select="@key"/>
    <xsl:apply-templates select="@mdate"/>
  <input type="hidden" name="type">
    <xsl:attribute name="value">
       <xsl:value-of select="local-name(.)"/>
    </xsl:attribute>
</input>	
<xsl:apply-templates/>
	
<script type="text/javascript">
function getDetailsLink()
{

 var key = "<xsl:value-of select="@key"/>";
 
 var find = '/';
 var re = new RegExp(find, 'g');
 key = key.replace(re, '_');
 var link = "http://localhost:8984/change/delete/" + key;
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
   <br></br>
  <a href="#" onclick="javascript:getDetailsLink();">Löschen </a> <br></br>
</xsl:template>

<xsl:template match="@key">
key:  <xsl:value-of select="."/>
  <input type="hidden" name="key" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
<br />
</xsl:template>

<xsl:template match="@mdate">
mdate:  <xsl:value-of select="."/>
<input type="hidden" name="mdate" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	
</input>	
<br />
</xsl:template>


<xsl:template match="title">
Title: 
  <input type="text" name="title" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
<br />
</xsl:template>

<xsl:template match="author">
Author: 
  <input type="text" name="author" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
<br />
</xsl:template>

<xsl:template match="school">
School: <input type="text" name="school" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
</xsl:template>

<xsl:template match="editor">
Editor: <input type="text" name="editor" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>


<xsl:template match="booktitle">
Booktitle: <input type="text" name="booktitle" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
</xsl:template>
<xsl:template match="cdrom">
Cdrom: <input type="text" name="cdrom" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
<xsl:template match="cite">
Cite: <input type="text" name="cite" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
<xsl:template match="crossref">
Crossref: <input type="text" name="crossref" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
<xsl:template match="ee">
EE: <input type="text" name="ee" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
 <xsl:template match="journal">
Journal: <input type="text" name="journal" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template><xsl:template match="month">
Month: <input type="text" name="month" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template><xsl:template match="note">
Note: <input type="text" name="note" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template><xsl:template match="number">
Number: <input type="text" name="number" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template><xsl:template match="publisher">
Publisher: <input type="text" name="publisher" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template> 
<xsl:template match="url">
Url: <input type="text" name="url" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
<xsl:template match="volume">
volume: <input type="text" name="volume" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
<xsl:template match="year">
Year: <input type="text" name="year" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
<xsl:template match="from">
from page: <input type="text" name="from" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>
<xsl:template match="to">
to page: <input type="text" name="to" size="50">
    <xsl:attribute name="value">
       <xsl:value-of select="."/>
    </xsl:attribute>	  
</input>
  <br />
</xsl:template>

</xsl:stylesheet>
