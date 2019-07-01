<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    <xsl:output method="html"
                encoding="UTF-8"/>
 <xsl:template match="/">
    <div id="loadmenu"></div>
   <br/>
    <xsl:apply-templates 
			select="/find" 
			mode="find"/>
<div style="text-align: left; color: #000000; width:100%;  height: 20px; position: fixed; bottom:0;"><xsl:value-of select="footer"/>
</div>			  
 </xsl:template>
 
 <xsl:template match="/find" mode="find">
 <div style="background-color:#FFFFFF;">
  <table width="100%">
        <xsl:apply-templates 
			select="/find/row" 
			mode="opisanie"/>
  </table></div>
 </xsl:template>
 

 
  <xsl:template match="row" mode="opisanie">
  <tr>
     <td>
	    <b style="color:#660033; font-size:2em;"><text>Справка по термину "</text>
		<xsl:value-of select="name" /><text>"</text></b>
	 </td>	
    </tr>
	<xsl:if  test="/find/row/sokr[text()!='']">
		 <tr>
     <td>
	    <i class="lzag">Сокращенное наименование:</i>
	 </td>	
    </tr>
	<tr>
     <td>
	    <b style="font-size:10pt;"><xsl:value-of select="sokr"/></b>
	 </td>	
    </tr>
	</xsl:if>
	<xsl:if  test="./interm/i_name[text()!='']">
	 <tr>
     <td>
	    <i class="lzag">Переводные эквиваленты термина:</i>
	 </td>	
    </tr>

	 <xsl:apply-templates 
			select="./interm" 
			mode="lang"/>
	  	</xsl:if>
	<xsl:apply-templates 
			select="./opisanie" 
			mode="opis"/>
   
	  </xsl:template>
	  
	  <xsl:template match="interm" mode="lang">
	  <tr>
     <td>
	 <xsl:if  test="./lang[text()!='']">
	    <text class="lzag"><xsl:value-of select="lang"/>:</text>
	</xsl:if>
		<text style="font-size:10pt;"><xsl:value-of select="i_name"/>
		<xsl:if  test="./i_sokr[text()!='']"><i> (<xsl:value-of select="i_sokr"/>)</i></xsl:if>
		</text>
		
	 </td>	
    </tr>
	  </xsl:template>
	  
	  <xsl:template match="opisanie" mode="opis">
	 <tr>
     <td>
	 <br/>
	    <i class="lzag">Определение:</i>
	 </td>	
    </tr>
	<tr>
     <td>
	    <b><xsl:value-of select="znachenie"/></b>
	 </td>	
    </tr>
	 <xsl:apply-templates 
	  select="./istochnik" 
			  mode="ist"/>
			  
		<tr>
     <td>
	    <i class="lzag">Соответствие предметным областям:</i>
	 </td>	
    </tr>
     <tr>
      <td>
	  <xsl:apply-templates 
	  select="./rubrika" 
			  mode="rub"/>
	  </td>
	    </tr>
   </xsl:template>
   
    <xsl:template
	  match="istochnik" 
			  mode="ist">
 	<tr>
	    <td>
	     <i class="lzag">Источник:</i>
	  </td></tr>
  <tr>
   <td>

	<xsl:apply-templates 
			  select="./ssilka" 
			  mode="istochnik"/>
 </td>
  </tr>
   <tr>
     <td>
	    <i class="lzag">Описание источника:</i>
	 </td>	
    </tr>
    <tr>
   <td>
   <i class="ltext"><xsl:value-of select="istochnik_opisanie" /></i>
   </td>
  </tr>
   </xsl:template>
   
<xsl:template match="rubrika" mode="rub">
     <text><xsl:value-of select="name_rubrika" /></text><br/>
    </xsl:template>
	
 <xsl:template match="ssilka" mode="istochnik">
	       <p class="ltext"><xsl:value-of select="parent::node()" /></p>
 </xsl:template>
 
 <xsl:template match="ssilka" mode="ssilka">
   <a class="ltext">
   <xsl:attribute name="href">
     <xsl:value-of select="node()" />
   </xsl:attribute>
   <xsl:value-of select="parent::node()" />
   </a>
 </xsl:template>
 
</xsl:stylesheet>