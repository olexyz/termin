<?php
include_once('config.php');
switch($_REQUEST['act']){
case 'add':

break;

case 'file':   
	$picn=$_FILES['pic']['name'];
    $uploaddir='dat/';
    $uploadfile=$uploaddir.basename($picn);
    if (is_uploaded_file($_FILES['pic']['tmp_name'])){
	    move_uploaded_file($_FILES['pic']['tmp_name'],$uploadfile);
	    $html=new myhtml;
	$str.=$html->title='Разбор XML';
	$str.=$html->headder();
	$str.=$html->menu('');
    $xmldoc = new DOMDocument;
	$xmldoc->load($uploadfile);
	$xsd=$xmldoc->schemaValidate('shema_in.xsd');
	if($xsd==1){
		$id_slova=array();
		$file=file_get_contents($uploadfile);
	    $simplexml=simplexml_load_file($uploadfile);
		foreach($simplexml->termin as $termin){
			$str.='name: '.$termin->name.'</br>';
			$pg=pg_fetch_object(pg_query("INSERT INTO slova (name) VALUES ('".$termin->name."') RETURNING id"));
			array_push($id_slova, $pg->id);
			foreach($termin->opisanie as $opisanie){
				$str.='opis: '.$opisanie.'</br>';
				pg_query("INSERT INTO znach (znach, id_slova) VALUES ('".$opisanie."', ".$pg->id.") RETURNING id");
			}
		}
		header("Location: card.php?id=".serialize($id_slova));
        
	}
	else{
	   $str.='XML файл не соответствует заданной схеме!';
	}
	$str.=$html->endhtml;
	echo $str;
	}
    else{
        echo"что-то не так";
        print_r($_FILES);
    }
break;
default:
	$html=new myhtml;
	$str.=$html->title='Импорт XML';
	$str.=$html->headder();
	$str.=$html->menu('');
	$str.="<script type=\"text/javascript\">
	         $(document).ready(function(){
				 $('#i').click(function(){
					 if($(this).hasClass('c')){
					 $('#spravka').css('display','none');
					 $(this).removeClass();
					 }else{
                       $('#spravka').css('display','block');
					 $(this).addClass('c');
					 }
				 });
				 });
	   </script>";
	$str.='<h1>Загрузите XML<img src="img/svg/cercle-7.svg" id="i" style="height:0.8em;cursor:pointer;"/></h1>
	<div id="spravka" style="display:none;"><p>Схема XML файла:</p><pre style="background-color:#EEEEEE;">'.htmlspecialchars('
<?xml version="1.0" encoding="utf-8"?>
<xs:schema xmlns:xs="http://www.w3.org/2001/XMLSchema">
	<!-- Описание структуры -->
	<xs:element name="root">
		<xs:complexType>
			<xs:sequence>
				<xs:element name="termin" maxOccurs="unbounded">
					<xs:complexType>
						<xs:sequence>
							<xs:element name="name" type="xs:string"  />
							<xs:element name="opisanie" type="xs:string"  minOccurs="0" maxOccurs="unbounded" />
						</xs:sequence>
					</xs:complexType>
				</xs:element>
			</xs:sequence>
		</xs:complexType>
	</xs:element>
</xs:schema>').'</pre>
<p>Пример XML файла:</p>
  <pre style="background-color:#EEEEEE;">'.htmlspecialchars('
    <?xml version="1.0" encoding="utf-8"?>
	  <root>
	    <termin>
		  <name></name>
		  <opisanie></opisanie>
		</termin>
	    <termin>
		  <name></name>
		  <opisanie></opisanie>
		  <opisanie></opisanie>
		</termin>
	  </root>
	  ').'</pre>';
$str.='</div>
<div style="text-align:center;">
<form enctype="multipart/form-data" action="fromxml.php" method="POST"><input type="hidden" name="MAX_FILE_SIZE" value="100000000" /><input name="pic" type=file size=5/ ><input type="hidden" name="act" value="file" /><input  type="submit" value="Открыть"></form></div>';
    $str.=$html->endhtml;
    echo $str;
break;
}
?>