<?php
/*
 * Ciphron - Advanced Security
 *
 * Tel.: (05 11) 59 02 54 - 70 Fax: (05 11) 59 02 54 - 74
 * Web: http://www.ciphron.de/ Support: (05 11) 59 02 54 - 76
 *
 * Snom XML Browser Emulator
 *
 *
 * @author: jk@ciphron.de
 * @modifyed by: Bertera Pietro <pietro@bertera.it>
 */
ini_set('display_errors', true);

if (! array_key_exists ("url", $_GET)) {
?>
<html>
<head>
<link href="snom.css" rel="stylesheet" type="text/css" />
<title><xsl:value-of select="Title"/></title></head>
<body><div id="container">
    <h1>Error</h1>
    <div id="content">
    You must specify <b>url</b> variable in query string.<br/><br/>
	For Example: <a href="http://snom.bertera.it/phone.php?url=http://www.snom.com/minibrowser/telbook.xml">http://snom.bertera.it/phone.php?url=http://www.snom.com/minibrowser/telbook.xml</a>
    </div>
 <hr />

</div></body>
</html>
<?php	
	die();
}

// Decode URL
$url = rawurldecode($_GET['url']);

// and attach get input params
if ( isset($_POST['param']) )
	$url .= "=".rawurlencode($_POST['param']);

// Get Content
$buf = file_get_contents ( $url, FALSE, stream_context_create(array('http'=>array('ignore_errors' => TRUE))));

// Clean XML
$buf = preg_replace ( "/\&(?![a-zA-Z]+;)/", "&amp;", $buf );

// Define some XSLT Helper
function makeUrl($str) {
	return "phone.php?url=".urlencode($str);
}

function makeUrlInput ( $str1, $str2 ) {
	return makeUrl($str1."?".$str2);	
}

// Load the XML source
$xml = new DOMDocument;
$xml->loadXml($buf);

$xsl = new DOMDocument;
$xsl->load('phone.xsl');

// Configure the transformer
$proc = new XSLTProcessor;
$proc->registerPHPFunctions();
$proc->importStyleSheet($xsl); // attach the xsl rules

echo $proc->transformToXML($xml);
