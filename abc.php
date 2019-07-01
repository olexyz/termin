<?php
include_once('config.php');
	$html=new myhtml;
	$html->title='Алфавитный укзатель';
	$str.=$html->headder();
	$str.=$html->menu('');
	$arr=array('А','Б','В','Г','Д','Е','Ж','З','И','К','Л','М','Н','О','П','Р','С','Т','У','Ф','Х','Ц','Ч','Ш','Щ','Э','Ю','Я');
	$ara=array('A', 'B', 'C', 'D','E','F','G','H','I','J','K','L','M','N','O','P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W');
	$str.='<div style="margin-top:20px;">';
	foreach($arr as $s){
		$str.='<a  style="margin-left:20px;"href="index.php?search='.$s.'&p=1&l=r&vivod=1">'.$s.'</a>';
	}
	$str.='</div><div style="margin-top:20px;">';
	foreach($ara as $s){
		$str.='<a  style="margin-left:20px;"href="index.php?search='.$s.'&p=1&l=a&vivod=1">'.$s.'</a>';
	}
	$str.='</div>';
	$str.=$html->endhtml;
echo $str;
?>