<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >
    <xsl:output
    method="html"
    doctype-public="XSLT-compat"
    omit-xml-declaration="yes"
    encoding="UTF-8"
    indent="yes" />
 <xsl:template match="/">
 <html><head>
 <meta http-equiv="Content-Type" content="text/xhtml; charset=utf-8" />
 <script language="JavaScript" src="jquery.js" type="text/JavaScript"></script>
 <script language="JavaScript" src="jquery-ui.min.js" type="text/JavaScript"></script>
 <link rel="stylesheet" type="text/css" href="style.css"/>
 <title><xsl:value-of select="find/row/name" /></title>
  </head><body><script language="JavaScript" type="text/JavaScript">
  $(document).ready(function(){
      var id=$("#id").attr("class");
	  $("#loadmenu").load("form.php?act=menu<![CDATA[&]]>id="+id);
	  $("#loadud").load("form.php?act=ud");
	   $("#loadizm").draggable();
  });
  </script><br/><br/>
    <div id="loadmenu"></div>
	<div id="loadud"></div>
   <br/>
    <xsl:apply-templates 
			select="/find" 
			mode="find"/>
<div style="text-align: left; color: #000000; width:100%; font-size: 11pt; height: 20px; position: fixed; bottom:0;"><xsl:value-of select="footer"/>
</div><br/><br/>
</body></html>		  
 </xsl:template>
 
 <xsl:template match="/find" mode="find">
        <xsl:apply-templates 
			select="/find/row" 
			mode="opisanie"/>
 </xsl:template>
 

 
  <xsl:template match="row" mode="opisanie">
  <br/>
  <div class="card">
  <table width="100%">
  <tr>
     <td>
	    <b style="color:#660033; font-size:2em;"><xsl:value-of select="name" /></b><id>
   <xsl:attribute name="class">
     <xsl:value-of select="./id_slova"/>
   </xsl:attribute>
   <xsl:attribute name="id">
     <xsl:text>id</xsl:text>
   </xsl:attribute></id>
	 </td>	
    </tr>
	<xsl:if  test="./sokr[text()!='']">
		 <tr>
     <td>
	    <i class="lzag">Сокращенное наименование:</i>
	 </td>	
    </tr>
	<tr>
     <td>
	    <b style="font-size:1em;"><xsl:value-of select="sokr"/></b>
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
		<tr><td> <br/><br/><div style="float:right;">
		<aa class="ud">
   <xsl:attribute name="m">
     <xsl:value-of select="name"/>
	 </xsl:attribute>
    <xsl:attribute name="href">
     <xsl:text><![CDATA[form.php?act=delslovo&id_slovo=]]></xsl:text>
     <xsl:value-of select="./id_slova"/>
   </xsl:attribute>
   Удалить термин</aa>
   <a class="izte" style="margin-left:5px;">
   <xsl:attribute name="href">
   <xsl:text><![CDATA[form.php?editslovo=]]></xsl:text>
   <xsl:value-of select="./id_slova"/>
   </xsl:attribute>
      Изменить термин
	  </a>
   <a class="izte" id="plus" style="margin-left:5px;">
   <xsl:attribute name="href">
   <xsl:text><![CDATA[form.php?editz=plus&id_slovo=]]></xsl:text>
   <xsl:value-of select="./id_slova"/>
   </xsl:attribute>
  Добавить определение
   </a></div></td></tr></table></div>
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
		<text style="font-size:1em;"><xsl:value-of select="i_name"/>
		<xsl:if  test="./i_sokr[text()!='']"><i> (<xsl:value-of select="i_sokr"/>)</i></xsl:if>
		</text>
		
	 </td>	
    </tr>
	  </xsl:template>
	  
	  <xsl:template match="opisanie" mode="opis">
	  <div class="card"><table>
	 <tr>
     <td>
	 <br/>
	    <i class="lzag">Определение:</i>
	 </td>	
    </tr>
	<tr>
     <td>
	    <b style="font-size:1em;"><xsl:value-of select="znachenie"/></b><br/><br/><br/>
	 </td>	
    </tr>
	 <xsl:apply-templates 
	  select="./istochnik" 
			  mode="ist"/>
			  
		<tr>
     <td>
	 <br/>
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
		<tr>
	  <td>
	     <p align="right" class="ltext">
		 <aa class="ud">
   <xsl:attribute name="m">
     <xsl:value-of select="znachenie"/>
	 </xsl:attribute>
    <xsl:attribute name="href">
     <xsl:text><![CDATA[form.php?act=del&id_znach=]]></xsl:text>
     <xsl:value-of select="./id_znachenie"/>
   </xsl:attribute>
   Удалить определение</aa>
		 <a style="margin-left:5px;" class="izte">
		 <xsl:attribute name="href">
   <xsl:text><![CDATA[form.php?id_slovo=]]></xsl:text>
   <xsl:value-of select="./id_slova"/>
   <xsl:text><![CDATA[&editz=]]></xsl:text>
     <xsl:value-of select="./id_znachenie"/>
   </xsl:attribute>
   Изменить определение
   </a></p>
	  </td>
   </tr></table></div>
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
   <xsl:choose>
	<xsl:when  test="./ssilka[text()!='']">
		    <xsl:apply-templates 
			  select="./ssilka" 
			  mode="ssilka"/>
		</xsl:when>	  
	<xsl:when test="./ssilka[text()='']">
	<xsl:apply-templates 
			  select="./ssilka" 
			  mode="istochnik"/>
			  </xsl:when>
			  </xsl:choose>
 </td>
  </tr>
   <tr>
     <td>
	    <i class="lzag">Описание источника:</i>
	 </td>	
    </tr>
    <tr>
   <td>
   <i class="ltext"><xsl:value-of select="./istochnik_opisanie" /></i>
   </td>
  </tr>
   </xsl:template>
   
<xsl:template match="rubrika" mode="rub">
    <p><text style="font-size:1em; margin-left:3px;"><xsl:value-of select="./name_rubrika" /></text></p>
    </xsl:template>
	
 <xsl:template match="ssilka" mode="istochnik">
	       <pi class="ltext"><xsl:value-of select="parent::node()/istochnik_name" /></pi>
 </xsl:template>
 
 <xsl:template match="ssilka" mode="ssilka">
   <a class="ltext">
   <xsl:attribute name="href">
     <xsl:value-of select="node()" />
   </xsl:attribute><text>
   <xsl:value-of select="parent::node()/istochnik_name" /></text>
   </a>
 </xsl:template>
 
</xsl:stylesheet>