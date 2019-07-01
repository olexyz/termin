<?php
class myhtml {
	//проверить работу конструктора и деструктора в эдит и индекс
	public $title='Термины';
	public $any='';
	public $wx='';
	public $card=0;
    public $endhtml='</body>';
	public $modal="$('<div/>').css({
	        position: 'fixed',
	        top: 0,
	        left: 0,
	        right: 0,
	        bottom: 0,
	        background: 'black',
	        opacity: 0.5
	    }).appendTo(document.body).addClass('modal');";
	public function headder(){
		$str.='<!DOCTYPE html>
	    <html>
        <head>
        <title>'.$this->title.'</title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
		<meta http-equiv="Access-Control-Allow-Origin" content="*">
		<link rel="stylesheet" type="text/css" href="style.css"/>
		<script language="JavaScript" src="script.js" type="text/JavaScript"></script>
        <script language="JavaScript" src="jquery.js" type="text/JavaScript"></script>
		<script language="JavaScript" src="jquery-ui.min.js" type="text/JavaScript"></script>
		<script type="text/javascript" src="xmlhttprequest.js"></script>
		'.$this->any.'
		</head><body>';
		return $str;
	}
	public function block_load($id,$ssilka,$selector, $p=''){
	$str.= "<script type=\"text/javascript\">
       $(document).ready(function(){
      $('".$selector."').click(function(){
		  ".$this->modal."
	    $('#loadizm').css('display', 'block');
		 $('#loadscr').load('".$ssilka."');
		 });
	  $('#lclose').click(function(){
	     $('#loadizm').css('display', 'none');
		 $('div.modal').remove();
	  });
	   $('#loadizm').draggable();
  });
  </script>";

  $str.=  '<div id="loadizm"><img src="img/svg/multiply.svg" style="float:right;width:1em;cursor:pointer;" id="lclose"/><h1>'.$p.'</h1><div id="loadscr" style="width:95%; margin-left:3px;"></div></br></br></div>';
  return $str;
	}
	public function menu($search, $wxid='', $off=0){
	$str.="<script type=\"text/javascript\">
	$(document).ready(function(){
		     $('.inmenu').hover(function(){
			     $(this).children('ul').css('display','block');
				 
			   },
			   function(){
			     $(this).children('ul').css('display','none');
				 });
			 });
		</script>";
		if($wxid!=='')$id='&id='.$wxid;
	$str.='<div class="menu">
 <div class="top_menu" id="top_menu">
  <div class="inmenu"><img src="img/svg/menu.svg"/></div><div class="inmenu"><a href="/termin/">Поиск</a>
 <ul style="display:none;" id="p1" class="podmenu">
 <li><a href="index.php?do=filtr">Поиск с параметрами</a></li>
 <li><a href="abc.php?">Алфавитный указатель</a></li>
 <li><a href="index.php?do=cont">Контекстный поиск</a></li></ul></div>
 <div class="inmenu"><a href="#">Редактор</a>
 <ul style="display:none;" id="p1" class="podmenu">
 <li><a href="form.php?editslovo=plus">Добавить термин</a></li>
 <li><a href="rub.php">Редактор рубрик</a></li>
 <li><a href="ist.php">Редактор источников</a></li>
  <li><a href="slovari.php?act=edit">Редактор словарей</a></li></ul>
 </div><div class="inmenu"><a href="#">Обмен</a>
  <ul style="display:none;" id="p1" class="podmenu">
  <li><a href="slovari.php?act=view">Словари</a></li>
  <li><a href="fromxml.php">Импорт XML</a></li>
   <li><a href="izxls.php">Импорт XLS</a></li>';
 if($off==1){
  	 if($this->card==0){
       $str.='<li><a href="index.php?vid=xml&vivod=1&act=find'.$this->wx.$id.'&search='.$search.'">Экспорт в XML</a></li>
        <li><a href="index.php?vid=doc&vivod=1&act=find'.$this->wx.$id.'&search='.$search.'">Печать справки</a></li>';
	 }
	 else{
		 $str.='<li><a href="card.php?vid=xml&act=find'.$this->wx.$id.'&search='.$search.'">Экспорт в XML</a></li>
        <li><a href="card.php?vid=doc&act=find'.$this->wx.$id.'&search='.$search.'">Печать справки</a></li>';
	 }
  }
$str.='</ul></div></div>
   <br/><br/><br/><div style="padding-left:7%;padding-right:7%;">'.$this->block_load('new','form.php?editslovo=plus','#newt');
   return $str;
   }
	public function footer($text){
		$str.='</div><div style="text-align: left; color: #000000; width:100%; font-size: 1em; bottom: 0; left: 0; position: fixed;">
         '.$text.'
</div>';
		return $str;
	}
	public function search($search="",$act=1){
		if($act==1){
			$a='<a href="index.php?do=filtr" style="text-decoration:none; opacity:0.5; margin-left:5px; height:1.2em;"><img title="параметры поиска" style="margin-bottom:-5px;" src="img/svg/sliders.svg"/></a>';
		}
		else{
			$a='<a href="index.php" style="text-decoration:none; margin-left:5px; height:1.8em;"><img title="сбросить настройки" style="margin-bottom:-5px; opacity:0.5; height:1.2em;" src="img/svg/cross.svg"/></a>';
		}
   $str.='<input type="hidden" name="vivod" value="1" />
   <div><input type="text" style="width:75%; padding: .5em ; font-size: 1.2em;" id="insearch" name="search" value="'.$search.'"/>'.$a.'
   <input type="submit" value="Найти" class="buttons"  /></div>';
   return $str;
	}
	public function ud(){
	     $str.="<script type=\"text/javascript\">
	     $(document).ready(function(){
		     $('#ud').draggable();
		     $('.ud').click(function(){
			     url=$(this).attr('href');
				  ".$this->modal."
		         $('#ud').css('display','block');
				 $('#h').attr('href', url);
				 name=$(this).attr('m');
				 $('#ud').children('p').html('Удалить '+name+'?');
				 });
			$('#ud').click(function(){ 
			     $('#ud').css('display','none');
				 $('div.modal').remove();
			});
			 });
		</script>";
	    $str.='<div style="background-color:#FFFFFF; width:300px; z-index:102; position:fixed; border:1px solid; display:none; top:20%; left:20%;" id="ud"><p style="text-align:center;" id="pud"></p><a class="btnud" href="" style="float:bottom; margin-left:7%; margin-bottom:5px;" id="h">Удалить</a><a class="btnud" id="cud">Отмена</a></div>';
   return $str;
	}
}

?>