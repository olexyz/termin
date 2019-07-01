<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    <xsl:output method="xml"
                encoding="UTF-8"/>
 <xsl:template match="/">
    <xsl:apply-templates 
			select="/find" 
			mode="find"/> 
 </xsl:template>
 
 <xsl:template match="/find" mode="find">
    <xsl:if  test="./search[text()!='']">
      <xsl:comment>
	    <text>Запрос поиска: </text>
	    <xsl:value-of select="./search"/>
	  </xsl:comment>
	</xsl:if>
       <root>
        <xsl:apply-templates 
			select="/find/row" 
			mode="row"/>
	   </root>
 </xsl:template>
 

 
  <xsl:template match="row" mode="row">
    <termin>
	 <name>
	   <xsl:value-of select="./name"/>
	 </name>
	 <xsl:apply-templates 
			select="./opisanie" 
			mode="opisanie"/>
	</termin>
  </xsl:template>
  
  <xsl:template match="opisanie" mode="opisanie">
    <opisanie>
	 <xsl:value-of select="./znachenie"/>
	</opisanie>
  </xsl:template>
  
</xsl:stylesheet>