<?php
if($_REQUEST['act']=='save'){
	include_once('config.php');
	header("Location: izxls.php?act=openfile");
	$a=array();
	$n=0;
	foreach($_REQUEST['xsltermin'] as $i){
	  $n++;
	  $a[$n]=json_decode($i);
	  
	}
	foreach($a as $e){
	  $m=pg_fetch_object(pg_query("INSERT INTO slova(
             name)
            VALUES ( '".$e[0]."') RETURNING id
          "));
	   pg_query("INSERT INTO znach(
             id_slova, znach)
             VALUES ( ".$m->id.", '".$e[1]."')");
	}
	/*
	echo"<pre>";
	print_r($a);
	echo"</pre>";/*
    foreach($a as $e){
		/*
		 $name=$e[0];
		 $sokr=$e[1];
		 $m=pg_fetch_object(pg_query("INSERT INTO slova(
             name, sokr)
            VALUES ( '".$name."','".$sokr."') RETURNING id
          "));
		 
		 $in=$e[2];
		 $in_sokr=$e[3];
		 $mi=pg_fetch_object(pg_query("INSERT INTO inslovo(
             id_slovo, id_lang, name, sokr)
    VALUES ( ".$m->id." , 1, '".$in."', '".$in_sokr."') RETURNING id "));
	     $allrub=explode(";",preg_replace("# #", "", $e[4]));
		 $op=$e[5];
		 $mo=pg_fetch_object(pg_query("INSERT INTO znach(
             id_slova, znach )
    VALUES (  ".$m->id.", '".$op."') RETURNING id"));

		 foreach($allrub as $rub){
			 $si=pg_fetch_object(pg_query("SELECT id FROM rubrikator WHERE num='".$rub."'"));
			$r=pg_fetch_object(pg_query("INSERT INTO k_rub(
             id_rub, id_znach)
    VALUES ( ".$si->id.", ".$mo->id.") "));
			// echo 'rub: '.$r->id;
		 }
	     
		 $allist=explode(";",preg_replace("# #", "", $e[6]));
		 foreach($allist as $ist){
			 if($ist!==''){
			 $is=pg_fetch_object(pg_query("INSERT INTO k_ist(
             id_znach, id_ist)
    VALUES ( ".$mo->id.", '".$ist."')"));
			 }
		    //$si=pg_fetch_object(pg_query("SELECT id FROM istochnik WHERE id='".$ist."'"));*/
			/* $allrub=explode(";",preg_replace("# #", "", $e[4]));
			 foreach($allrub as $rub){
			 $si=pg_fetch_object(pg_query("SELECT id, num, rubrika FROM rubrikator WHERE num='".$rub."'"));
			 echo  '<p>ищу '.$rub.' id '.$si->id.' num '.$si->num.' рубрика '.$si->rubrika.'</p>';
			    if($si->num==''){
				    $si=pg_fetch_object(pg_query("INSERT INTO rubrikator(
                num)
    VALUES ('".$rub."')"));
				 echo "!!!"	;
			    }
			 }
			  }
		//для источника
		/*$id=preg_replace("#\.#", "", $e[0]);
		echo $id;
		$name=$e[1];
		$opisanie=$e[2];
		$m=pg_fetch_object(pg_query("INSERT INTO istochnik( id, name, opisanie) VALUES (".$id.", '".$name."', '".$opisanie."')"));*/
	}
	elseif(($_REQUEST['act'])=='openfile'){
	
	require_once ('classes/PHPExcel.php');
    require_once ('classes/PHPExcel/IOFactory.php');
	require('config.php');
	if ($_SESSION['startRow']) $startRow = $_SESSION['startRow'];
    else $startRow = 1;
	  if($_REQUEST['file']=='new'){
	      $picn=$_FILES['pic']['name'];
          $uploaddir='dat/';
          $uploadfile=$uploaddir.basename($picn);
          if (is_uploaded_file($_FILES['pic']['tmp_name'])){
	        move_uploaded_file($_FILES['pic']['tmp_name'],$uploadfile);
			$_SESSION['file']=$uploadfile;
           }
		  }
		  else $uploadfile=$_SESSION['file'];
          // Открываем файл
    $inputFileType = 'Excel5';
$objReader = PHPExcel_IOFactory::createReader($inputFileType);
$chunkSize = 20;
$chunkFilter = new chunkReadFilter();
$objReader->setReadFilter($chunkFilter);
$objReader->setReadDataOnly(true);
$chunkFilter->setRows($startRow,$chunkSize);
    $xls = $objReader->load($uploadfile);
	
// Устанавливаем индекс активного листа
    $xls->setActiveSheetIndex(0);
// Получаем активный лист
    $sheet = $xls->getActiveSheet();
	
// Получили строки и обойдем их в цикле
   $rowIterator = $sheet->getRowIterator();
   $m=$startRow;
   //print_r($xls);
  $sheet->getHighestRow();
   if($sheet->getHighestRow()>1){
   $html=new myhtml;
$html->title='Обработка терминов с '.$startRow.' по '.$sheet->getHighestRow();
$str.=$html->headder();
$str.=$html->menu('');
$str.='<h1>Обработка терминов с '.$startRow.' по '.$sheet->getHighestRow().'</h1>';
/*/foreach ($rowIterator as $row) {
	// Получили ячейки текущей строки и обойдем их в цикле
	$cellIterator = $row->getCellIterator();
	$str.=  "<tr>";
		$a=array();
		$n=0;
	foreach ($cellIterator as $cell) {
		$n++;
		if(($n==1)||($n==2)){
		  array_push($a,preg_replace("#^'#", "", $cell->getCalculatedValue()));
		  $str.=  "<td>" .$cell->getCalculatedValue() . "</td>";
		}
	}
	$str.=  "<td><input type='checkbox' name='xsltermin[]' value='".json_encode($a)."' checked='checked'></td></tr>";
}

		  //Только выводит! Дописать сохранение!
		  /*$objReader = new PHPExcel_Reader_Excel5();
          $objPHPExcel = $objReader->load($uploadfile);

		   print_r($objPHPExcel);*/
 /*      
$str.= "<p>вариант 2</p><table>";
*/
$str.= "<div style='text-align:center;'><form method='POST' action=''><table class='xlstbl' style='width:100%; text-align:center;'><tr border='1px'><th>Термин</th><th>Определение</th><th>Выбрать</th></tr>";
for ($i = $startRow; $i <= $sheet->getHighestRow(); $i++) {  
    $str.=  "<tr>";
	
	$nColumn = PHPExcel_Cell::columnIndexFromString(
		$sheet->getHighestColumn());
	$a=array();
	$j = 0;
	while($j<2) {
	   
		$value = $sheet->getCellByColumnAndRow($j, $i)->getValue();
		
		$str.=  "<td>".$value."</td>";
		array_push($a,preg_replace("#^'#", "", $value));
		$j++;
	}
     
    $str.=  "<td><input type='checkbox' name='xsltermin[]' value='".json_encode($a)."' checked='checked'></td></tr>";
}

$startRow += $chunkSize;
$_SESSION['startRow'] = $startRow;
//echo $startRow;
unset($objReader);
unset($xls);
$str.=  "</table><input type='hidden' name='act' value='save'><br/><br/><input type='submit' value='Сохранить'></form>";
   $str.='</div>'.$html->endhtml;
   echo $str;
}
else {
  header("Location: izxls.php");
}
}
else{
include_once('config.php');
$html=new myhtml;
$html->title='Загрузка из xsl';
$str.=$html->headder();
$str.=$html->menu('');
$str.='<h1>Загрузите xls</h1>';
  $str.='<div style="text-align:center;"><form enctype="multipart/form-data" action="izxls.php" method="POST"><input type="hidden" name="MAX_FILE_SIZE" value="100000000" /><input name="pic" type="file" size=5/ ><input type="hidden" name="act" value="openfile" /><input type="hidden" name="file" value="new" /><input  type="submit" value="Открыть"></form>';
   echo $str;
   unset($_SESSION['startRow']);
   unset($_SESSION['file']);
	}
?>