<xsl:stylesheet version="1.0" 
		xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:php="http://php.net/xsl">
 <xsl:output method="html" encoding="iso-8859-1" indent="no"/>

 <xsl:template match="SnomIPPhoneMenu">
<html>
<head>
<link href="snom.css" rel="stylesheet" type="text/css"/>
<title><xsl:value-of select="Title"/></title></head>
<body><div id="container">
		<h1><xsl:value-of select="Title"/></h1>
 <div id="content">
 <xsl:apply-templates select="MenuItem" />
 </div>
 <hr /> 
 <xsl:apply-templates select="SoftKeyItem" />
 <a href="javascript:history.go(-1)">Go Back</a>
</div></body>
</html>
 </xsl:template>

 <xsl:template match="SnomIPPhoneDirectory">
<html>
<head>
<link href="snom.css" rel="stylesheet" type="text/css"/>
<title><xsl:value-of select="Title"/></title></head>
<body><div id="container">
		<h1><xsl:value-of select="Title"/></h1>
 <div id="content">
 <ul>
  <xsl:apply-templates select="DirectoryEntry" />
 </ul>
 </div>
 <hr /> 
 <xsl:apply-templates select="SoftKeyItem" />
 <a href="javascript:history.go(-1)">Go Back</a>
</div></body>
</html>
 </xsl:template>


 <xsl:template match="SnomIPPhoneInput">
  <xsl:param name="def" select="InputItem/DefaultValue"/>
  <xsl:variable name="param" as="xs:string" select="php:functionString('makeUrlInput', URL, InputItem/QueryStringParam)" />
<html>
<head>
<link href="snom.css" rel="stylesheet" type="text/css"/>
<title><xsl:value-of select="Title"/></title></head>
<body><div id="container">
 <h1><xsl:value-of select="InputItem/DisplayName"/></h1>
 <div id="content">
 <form action="{$param}" method="post">
		 <input type="text" name="param" value="{$def}" />
		<input type="submit" />
 </form>
	</div>
 <hr /> 
 <xsl:apply-templates select="SoftKeyItem" />
 <a href="javascript:history.go(-1)">Go Back</a>
</div></body>
</html>
 </xsl:template>

 <xsl:template match="SnomIPPhoneText">
<html>
<head>
<link href="snom.css" rel="stylesheet" type="text/css" />
<title><xsl:value-of select="Title"/></title></head>
<body><div id="container">
	<h1><xsl:value-of select="Title"/></h1>
 	<div id="content">
	<xsl:value-of select="Text"/>
	</div>
 <hr /> 
 <xsl:apply-templates select="SoftKeyItem" />
 <a href="javascript:history.go(-1)">Go Back</a>
</div></body>
</html>
 </xsl:template>

 <xsl:template match="DirectoryEntry">
	<li><b><xsl:value-of select="Name"/>:</b><xsl:value-of select="Telephone"/></li>
 </xsl:template>

 <xsl:template match="MenuItem">
  <xsl:variable name="uri" as="xs:string" select="php:functionString('makeUrl', URL)" />
  <a href="{$uri}"><xsl:value-of select="Name"/></a><br />
 </xsl:template>

 <xsl:template match="SoftKeyItem">
  <xsl:variable name="uri" as="xs:string" select="php:functionString('makeUrl', URL)" />
  <a href="{$uri}"><xsl:value-of select="Name"/> (<xsl:value-of select="Label"/>)</a><br/>
 </xsl:template>
</xsl:stylesheet>

