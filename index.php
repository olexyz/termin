<?php
include_once('config.php');
//$xsldoc = new DOMDocument();
//$xsldoc->load('index.xsl');
$xmldoc = new DOMDocument();
//$xsl = new XSLTProcessor();
$elem_find = $xmldoc->appendChild(new DOMElement('find'));
$elem_search = $elem_find->appendChild(new DOMElement('search'));
$comment = $elem_search->appendChild(new DOMText($_REQUEST['search']));
$search=$_REQUEST['search'];




    if(($_REQUEST['pname']=='on')&&($_REQUEST['pznach']=='on')&&($_REQUEST['psokr']=='on')){
	  $_REQUEST['pole']='all';
	}
	elseif(($_REQUEST['pname']!=='on')&&($_REQUEST['pznach']!=='on')&&($_REQUEST['psokr']!=='on')){
	  $_REQUEST['pole']='all';
	}else{
	  if($_REQUEST['pname']=='on')$_REQUEST['pole']='name';
      if($_REQUEST['pznach']=='on')$_REQUEST['pole']='znach';
      if($_REQUEST['psokr']=='on')$_REQUEST['pole']='sokr';
	}
if(($_REQUEST['p']==1)&&($_REQUEST['l']=='r')){
	$_REQUEST['search']=$_REQUEST['search'].'%';
		$sql="SELECT  DISTINCT slova.id as id_slova,  slova.name,  slova.name as znach,  slova.sokr, inslovo.name as i_name, inslovo.sokr as i_sokr, inslovo.id_lang, lang.abr
FROM  slova
LEFT JOIN inslovo ON (inslovo.id_slovo=slova.id)
LEFT JOIN lang ON (lang.id=inslovo.id_lang)
WHERE slova.name ILIKE '".$_REQUEST['search']."'
OR slova.sokr ILIKE '".$_REQUEST['search']."'
OR inslovo.name ILIKE '".$_REQUEST['search']."'
OR inslovo.sokr ILIKE '".$_REQUEST['search']."'
";

}
elseif(($_REQUEST['p']==1)&&($_REQUEST['l']=='a')){
	$_REQUEST['search']=$_REQUEST['search'].'%';
	$sql="SELECT  DISTINCT slova.id as id_slova,  inslovo.name,  ( inslovo.sokr || slova.name) as znach,  slova.sokr, inslovo.name as i_name, inslovo.sokr as i_sokr, inslovo.id_lang, lang.abr
FROM  slova
LEFT JOIN inslovo ON (inslovo.id_slovo=slova.id)
LEFT JOIN lang ON (lang.id=inslovo.id_lang)
WHERE 
inslovo.name ILIKE '".$_REQUEST['search']."'
OR inslovo.sokr ILIKE '".$_REQUEST['search']."'
";
	
}
elseif((isset($_REQUEST['search']))&&($_REQUEST['search']!=='')){
if((isset($_REQUEST['pole']))||(isset($_REQUEST['ist']))||(isset($_REQUEST['rub']))){
  switch($_REQUEST['pole']){
  case 'all':
  if((!isset($_REQUEST['fts']))&&($_REQUEST['fts']!=='on')){
  $fts_nz=" ts_headline( name, plainto_tsquery('%".$_REQUEST['search']."%')) AS name, ts_headline( znach, plainto_tsquery('%".$_REQUEST['search']."%'), 'MinWords=8, MaxWords=10, MaxFragments=5, FragmentDelimiter=\"...\"') AS znach";
  $where=" (znach.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%'))
OR (slova.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%')) OR";
$from=" plainto_tsquery('%".$_REQUEST['search']."%'), znach ";
  }
  else{
     $fts_nz="  name,  znach, id_znach ";
	 $where="";
	 $from="znach";
  }
  $pole=" ( slova.name ILIKE '%".$_REQUEST['search']."%'
          OR slova.sokr ILIKE '%".$_REQUEST['search']."%'
          OR znach.znach ILIKE '%".$_REQUEST['search']."%' ) ";
  break;
  case 'name':
  $pole=" slova.name ILIKE '%".$_REQUEST['search']."%' ";
  if((!isset($_REQUEST['fts']))&&($_REQUEST['fts']!=='on')){
   $fts_nz=" ts_headline( name, plainto_tsquery('%".$_REQUEST['search']."%')) AS name,  znach";
  $where=" (slova.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%')) OR";
$from=" plainto_tsquery('%".$_REQUEST['search']."%'), znach ";
}
  else{
     $fts_nz="  name,  znach, id_znach ";
	 $where="";
	 $from="znach";
  }
  break;

  case 'znach':
  if($_REQUEST['pname']=='on'){
	  $pole=" (znach.znach ILIKE '%".$_REQUEST['search']."%' OR slova.name ILIKE '%".$_REQUEST['search']."%' ) ";
	  if((!isset($_REQUEST['fts']))&&($_REQUEST['fts']!=='on')){
	  $fts_nz=" ts_headline( name, plainto_tsquery('%".$_REQUEST['search']."%')) AS name, ts_headline( znach, plainto_tsquery('%".$_REQUEST['search']."%'), 'MinWords=8, MaxWords=10, MaxFragments=5, FragmentDelimiter=\"...\"') AS znach";
  $where=" (znach.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%'))
OR (slova.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%')) OR";
$from=" plainto_tsquery('%".$_REQUEST['search']."%'), znach ";
  }
else{
     $fts_nz="  name,  znach,  id_znach ";
	 $where="";
	 $from=" znach ";
}
  }
  else {
	  $pole=" znach.znach ILIKE '%".$_REQUEST['search']."%'  ";
  
  if((!isset($_REQUEST['fts']))&&($_REQUEST['fts']!=='on')){
  $fts_nz="  name, ts_headline( znach, plainto_tsquery('%".$_REQUEST['search']."%'), 'MinWords=8, MaxWords=10, MaxFragments=5, FragmentDelimiter=\"...\"') AS znach";
  $where=" (znach.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%'))
 OR";
$from=" plainto_tsquery('%".$_REQUEST['search']."%'), znach ";
}
else{
     $fts_nz="  name,  znach,  id_znach ";
	 $where="";
	 $from=" znach ";
}
}
  break;
    case 'sokr':
  
  
  if(($_REQUEST['pname']=='on')&&(!isset($_REQUEST['pznach']))){
	  $pole=" (slova.sokr ILIKE '%".$_REQUEST['search']."%' OR slova.name ILIKE '%".$_REQUEST['search']."%' ) ";
	  if((!isset($_REQUEST['fts']))&&($_REQUEST['fts']!=='on')){
   $fts_nz=" ts_headline( name, plainto_tsquery('%".$_REQUEST['search']."%')) AS name,  znach";
  $where=" (slova.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%')) OR";
$from=" plainto_tsquery('%".$_REQUEST['search']."%'), znach ";
}else{
  $fts_nz="  name,  znach, id_znach ";
  $where="";
  $from=" znach ";	
}
  }
  elseif(($_REQUEST['pznach']=='on')&&(!isset($_REQUEST['pname']))){
	  $pole=" (znach.znach ILIKE '%".$_REQUEST['search']."%' OR slova.sokr ILIKE '%".$_REQUEST['search']."%' ) ";
	  if((!isset($_REQUEST['fts']))&&($_REQUEST['fts']!=='on')){
  $fts_nz="  name, ts_headline( znach, plainto_tsquery('%".$_REQUEST['search']."%'), 'MinWords=8, MaxWords=10, MaxFragments=5, FragmentDelimiter=\"...\"') AS znach";
  $where=" (znach.fts_v @@ plainto_tsquery('%".$_REQUEST['search']."%'))
 OR";
$from=" plainto_tsquery('%".$_REQUEST['search']."%'), znach ";
}
else{
  $fts_nz="  name,  znach, id_znach ";
  $where="";
  $from=" znach ";	
}
  }
  else {
	  $pole=" slova.sokr ILIKE '%".$_REQUEST['search']."%' ";
	  $fts_nz="  name,  znach, id_znach ";
  $where="";
  $from=" znach ";	
  }
  break;
  }
  if($_REQUEST['ist']=='on'){
     $ist=" 
	 LEFT JOIN k_ist ON (k_ist.id_znach=znach.id)
LEFT JOIN istochnik ON (k_ist.id_ist=istochnik.id ) 
";
foreach($_REQUEST['id_ist'] as $id_ist){
 $and_ist=" AND istochnik.id=".$id_ist." ";
}
  }
  if($_REQUEST['rub']=='on'){
     if(isset($_REQUEST['id_rub'])){
	   $rub=" 
	 LEFT JOIN k_rub ON (k_rub.id_znach=znach.id)
LEFT JOIN rubrikator ON (k_rub.id_rub=rubrikator.id ) 
";
     foreach($_REQUEST['id_rub'] as $id_rub){
	   $and_rub.=" AND rubrikator.id=".$id_rub." ";
	 }
	}
  }
  if($fts_nz=='')$fts_nz.=' ';
  else $fts_nz.=' , ';
  
 $sql="SELECT  DISTINCT id_slova,  ".$fts_nz."  sokr, id_znach, i_name, i_sokr as i_sokr, id_lang, abr
FROM 
(SELECT  DISTINCT slova.id as id_slova,  slova.name,  znach, znach.id as id_znach, slova.sokr, inslovo.name as i_name, inslovo.sokr as i_sokr, inslovo.id_lang, lang.abr 
FROM ".$from."
LEFT JOIN slova ON (znach.id_slova=slova.id)
LEFT JOIN inslovo ON (inslovo.id_slovo=slova.id)
LEFT JOIN lang ON (lang.id=inslovo.id_lang)
".$ist.$rub."
WHERE ( ".$where.$pole." ) ".$and_ist.$and_rub."
 AND slova.id>0)
AS foo
";


}
else{
	$_REQUEST['search']='%'.$_REQUEST['search'].'%';
	$sql="SELECT DISTINCT id_slova, ts_headline( name, plainto_tsquery('".$_REQUEST['search']."')) AS name, ts_headline( znach, plainto_tsquery('".$_REQUEST['search']."'), 'MinWords=8, MaxWords=10, MaxFragments=5, FragmentDelimiter=\"...\"') AS znach, id_znach, sokr,  i_name,  i_sokr,  abr
FROM
(SELECT  DISTINCT slova.id as id_slova,  slova.name,  znach, znach.id as id_znach, slova.sokr, inslovo.name as i_name, inslovo.sokr as i_sokr, inslovo.id_lang, lang.abr
FROM plainto_tsquery('".$_REQUEST['search']."'), znach
LEFT JOIN slova ON (slova.id=znach.id_slova)
LEFT JOIN inslovo ON (inslovo.id_slovo=slova.id)
LEFT JOIN lang ON (lang.id=inslovo.id_lang)
WHERE (znach.fts_v @@ plainto_tsquery('".$_REQUEST['search']."'))
OR (slova.fts_v @@ plainto_tsquery('".$_REQUEST['search']."'))
OR znach ILIKE '".$_REQUEST['search']."' 
OR slova.name ILIKE '".$_REQUEST['search']."'
OR slova.sokr ILIKE '".$_REQUEST['search']."'
OR inslovo.name ILIKE '".$_REQUEST['search']."'
OR inslovo.sokr ILIKE '".$_REQUEST['search']."'
)
AS foo";
}
}
else{
if((isset($_REQUEST['pole']))||(isset($_REQUEST['ist']))||(isset($_REQUEST['rub']))){
  if(($_REQUEST['pole']!=='all'))$from=" znach ";
else $from=" slova ";
  if($_REQUEST['ist']=='on'){
     $ist=" 
	  LEFT JOIN slova ON (znach.id_slova=slova.id) 
 LEFT JOIN k_ist ON (k_ist.id_znach=znach.id) 
 LEFT JOIN istochnik ON (k_ist.id_ist=istochnik.id )  
";
$where=" WHERE istochnik.id>0 ";
if(isset($_REQUEST['id_ist'])){
foreach($_REQUEST['id_ist'] as $id_ist){
 $and_ist=" AND istochnik.id=".$id_ist." ";
}
} 
 $from=" znach ";
  }
  if($_REQUEST['rub']=='on'){
     if(isset($_REQUEST['id_rub'])){
	   $rub=" 
	 LEFT JOIN slova ON (znach.id_slova=slova.id) 
	 LEFT JOIN k_rub ON (k_rub.id_znach=znach.id)
LEFT JOIN rubrikator ON (k_rub.id_rub=rubrikator.id ) 
";
$where=" WHERE rubrikator.id>0 ";
if(is_array($_REQUEST['id_rub'])){
$n=0;
     foreach($_REQUEST['id_rub'] as $id_rub){
	   if($n==0)$and_rub.=" AND ( rubrikator.id=".$id_rub." ";
	   else$and_rub.=" OR rubrikator.id=".$id_rub." ";
	   $n++;
	 }
	 $and_rub.=' ) ';
	}
	else $and_rub=" AND rubrikator.id=".$_REQUEST['id_rub']." ";
	}
	$from=" znach ";
  }

  }
 else{
$from=" slova ";
} 
$sql="SELECT DISTINCT slova.id as id_slova,  slova.name,  slova.sokr
FROM ".$from."
".$ist.$rub."
".$where.$and_ist.$and_rub."
ORDER by slova.name";
}
switch($_REQUEST['do']){
	case 'filtr':
	$html=new myhtml;
	$str.=$html->headder();
	if($_REQUEST['vivod']==1)$str.=$html->menu($search,'',1);
	else$str.=$html->menu($search,'',0);
	$html->title='Поиск с параметрами';
	$str.= "<script type='text/javascript'>
      $(document).ready(function(){
	  if($('.slcr').is(':checked')){
	      
	      $('.id_rub').attr('disabled', false);
		  $('#s').addClass('v');
		  $('.srcnamer').css('color', '#000000');
		}
		else{
	  $('.id_rub').attr('disabled', true);
	  $('#s').removeClass();
	  $('.srcnamer').css('color', '#999999');
	  }
	  if($('.slc').is(':checked')){
		  $('.srcname').css('color', '#000000');
		  $('.srcname').children().attr('disabled', false);
		}
		else{
	  
	  $('.srcname').css('color', '#999999');
	  $('.srcname').children().attr('disabled', true);
	  }
	  $('.open').click(function(){
	  if($('#s').hasClass('v')){
	  var id=$(this).attr('id');  
		$(this).css('display','none');
        var json_id_rub=".json_encode($_REQUEST['id_rub']).";
		$(this).parent().children('.src').load('form.php?act=loadrubchk&&id='+id+'&id_rub='+json_id_rub);
		$(this).parent().children('.close').css('display','inline'); 
	  }
	  });
	  $('.close').click(function(){
	  if($('#s').hasClass('v')){
		$(this).css('display','none'); $(this).parent().children('.src').html('');
		$(this).parent().children('.open').css('display','inline'); 
	  }
	  });
      $('.slc').change(function(){
	  if($(this).is(':checked')){
		  $(this).parent().parent('.obsh').children('.srcname').children().attr('disabled', false);
		  $('.srcname').css('color', '#000000');
		}
		else{
		  $(this).parent().parent('.obsh').children('.srcname').children().attr('disabled', true);
		  $('.srcname').css('color', '#999999');
		}
		});
	$('.slcr').change(function(){
	  if($(this).is(':checked')){
		  $('.id_rub').attr('disabled', false);
		  $('#s').addClass('v');
		  $('.srcnamer').css('color', '#000000');
		}
		else{
		  $('.id_rub').attr('disabled', true);
	  $('#s').removeClass();
	  $('.srcnamer').css('color', '#999999');
	  
		}
		});
  });

  </script>";
	$str.='<form action="" method="GET" ><input type="hidden" name="do" value="filtr" />'.$html->search($search,0);
	
	/*
	$str.='<label for="pole" >Искать в поле</label><select style="margin-left:3%;" name="pole">
	<option value="all"></option>
	<option value="name">Полное наименование</option>
	<option value="sokr">Сокращенное наименвание</option>
	<option value="znach">Определение</option>
	</select><br/><input name="fts"  type="checkbox"/><label for="fts">С учетом словоизменения</label>';
	*/
	if($_REQUEST['fts']=='on')$ftsch='checked';
	else$ftsch='';
	if($_REQUEST['pname']=='on')$pnch='checked';
	else$pnch='';
	if($_REQUEST['pznach']=='on')$pzch='checked';
	else$pzch='';
	if($_REQUEST['psokr']=='on')$psch='checked';
	else$psch='';
	if(($_REQUEST['pname']!=='on')&&($_REQUEST['pznach']!=='on')&&($_REQUEST['psokr']!=='on')){
	$pnch='checked';
	$pzch='checked';
	$psch='checked';
	}
	$str.='<div style="margin-top: 10px;margin-bottom: 10px;"><input name="fts" '.$ftsch.' class="fts" type="checkbox" id="fts"/><label for="fts">Точно как в запросе</label>
	<br/><br/>
	<input type="checkbox" id="pname" '.$pnch.' class="button15" name="pname" style=""/><label for="pname" >Наименование</label>
	<input type="checkbox" id="pznach" '.$pzch.' class="button15" name="pznach"/><label for="pznach" >Определение</label>
	<input type="checkbox" id="psokr" '.$psch.' class="button15" name="psokr"/><label for="psokr" >Сокращение</label></div>';
    if($_REQUEST['rub']=='on')$rch='checked';
	else$rch='';
	if($_REQUEST['ist']=='on')$ich='checked';
	else$ich='';
	$str.='<fieldset style="background-color:#EEEEEE;">
	<div class="obsh"><div style="margin-top:10px;margin-bottom: 10px;"><input name="ist" '.$ich.' class="slc fts" type="checkbox" id="ist"/><label for="ist">Источник</label></div><div class="srcname"><fieldset style="background-color:#FFFFFF; height:10em;overflow-y:scroll;overflow-x:hidden;">';
	/*
	$str.='<select style="margin-left:3%;" disabled name="id_ist">';
	$sqlf="SELECT * FROM istochnik ORDER BY name";
	$resf=pg_query($sqlf);
	while($mf=pg_fetch_object($resf)){
	   $str.='<option value="'.$mf->id.'">'.$mf->name.'</option>';
	}
	$str.='</select>';*/
	$sqlf="SELECT * FROM istochnik ORDER BY name";
	$resf=pg_query($sqlf);
	while($mf=pg_fetch_object($resf)){
	if((isset($_REQUEST['id_ist']))&&(in_array($mf->id,$_REQUEST['id_ist'])))$idist='checked';
	else$idist='';
	   $str.='<p style="width:100%"><input name="id_ist[]" '.$idist.' class="id_ist" type="checkbox" value="'.$mf->id.'"/>'.$mf->name.'</p>';
	}
	$str.='</fieldset></div></div>
	<div class="obsh"><div style="margin-top:10px;margin-bottom: 10px;"><input name="rub"  '.$rch.' class="slcr fts" type="checkbox" id="rub" /><label for="rub">Предметные рубрики</label></div><div id="s"></div><div class="srcnamer"><fieldset style="background-color:#FFFFFF; height:10em;overflow-y:scroll;overflow-x:hidden;">';
	$sqlf_2="SELECT * FROM rubrikator WHERE par_id is NULL ORDER BY id";
	$resf_2=pg_query($sqlf_2);
	while($mf_2=pg_fetch_object($resf_2)){
	
	if((isset($_REQUEST['id_rub']))&&(in_array($mf_2->id,$_REQUEST['id_rub'])))$idrub='checked';
	else$idrub='';
	   $str.='<p style="width:100%"><div class="r" style="display:inline;"><v class="open" id="'.$mf_2->id.'" style="cursor:pointer;"> + </v><e class="close" style="display:none; cursor:pointer;"> - </e><input name="id_rub[]" '.$idrub.' class="id_rub" type="checkbox" value="'.$mf_2->id.'"/>'.$mf_2->num.' '.$mf_2->rubrika.'<div class="src" style="margin-left:5%;"></div></div></p>';
	}
	$str.='</fieldset></div></div>
	</fieldset></form>';
	//найдено
	//найдено
	//найдено
	//найдено
	break;
	case 'cont':
	$html=new myhtml;
	$html->title='Контекстный поиск';
	$str.=$html->headder();
	if($_REQUEST['vivod']==1)$str.=$html->menu($search,'',1);
	else$str.=$html->menu($search,'',0);
/*	$str.= "<script type=\"text/javascript\">
      $(document).ready(function(){
	    $('#conts').click(function(){
		   $('#loadfind').load('index.php?do=contfind&act=find&vivod=1search=');
		  });
	    });
  </script>";*/
  $str.= '<script type="text/javascript">
  	  $(document).ready(function(){
	  $("html").keydown(function(event){
			  if (event.ctrlKey && event.which==13){
					 search();
			  }
	  });
	  
  });
  		function search(){
			// Параметры поиска

			// Формирование строки поиска
		
//выделеный текст в текстареа
  var textComponent = document.getElementById("contxt");
  var selectedText;
  // IE version
  if (document.selection != undefined)
  {
    textComponent.focus();
    var sel = document.selection.createRange();
    selectedText = sel.text;
  }
  // Mozilla version
  else if (textComponent.selectionStart != undefined)
  {
    var startPos = textComponent.selectionStart;
    var endPos = textComponent.selectionEnd;
    selectedText = textComponent.value.substring(startPos, endPos)
  }
  //alert("Вы ищете: " + selectedText);

			var searchString = "do=contfind&act=find&vivod=1&search=" + selectedText;
			//alert("searchString: " + searchString);
			
			// Запрос к серверу
			var req = new getXmlHttpRequest();
			req.onreadystatechange = function(){
					if (req.readyState != 4) return;
					var responseText = String(req.responseText);
					var books = responseText;
					document.getElementById("loadfind").innerHTML=books;
				};
				
			// Метод POST
			req.open("POST", "index.php", true);

			// Установка заголовков
			req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
			//req.setRequestHeader("Content-Length", searchString.length);
			
			// Отправка данных
			req.send(searchString);			
		}
		</script>';
	$str.='<div style="text-align:center;"><input type="hidden" name="do" value="cont" /><textarea style="width:100%;height:20em; overflow-y:scroll;" id="contxt"></textarea><br/>
	<input type="submit" value="Найти" class="buttons" id="conts"  onclick="search()"/><br/><br/></div><div style="width:100%;" id="loadfind"></div><br/><br/>';
	break;
	case 'contfind':
	$str.='<br/>';
	break;
	default:
	//index.php
	//index.php
	//index.php
	//index.php
	$html=new myhtml;
	$html->title='Термины и определения';
	$str.=$html->headder();
	if($_REQUEST['vivod']==1)$str.=$html->menu($search,'',1);
	else$str.=$html->menu($search,'',0);
    $str.='<form action="index.php" method="GET">
   <input type="hidden" name="act" value="find" />'.$html->search($search);
break;
}
if($_REQUEST['vivod']==1){
$str.='<div style="margin-top:10px;width:100%;">
  <table width="100%" class="find">';
$res=pg_query($sql);
	while($m=pg_fetch_object($res)){
		$sql_2="SELECT znach.id as id_znach, id_slova, znach, comment, date_upd
		FROM znach
        WHERE id_slova=".$m->id_slova;
		$elem_inf = $elem_find->appendChild(new DOMElement('row'));
		$id_z = $elem_inf->appendChild(new DOMElement('id_slova'));
		$id_z_text = $id_z->appendChild(new DOMText($m->id_slova));
		$arr_z=array('<b>','</b>');
		$cell_inf = $elem_inf->appendChild(new DOMElement('name'));
		$cell_sok = $elem_inf->appendChild(new DOMElement('sokr'));
		$text_ins = $cell_sok->appendChild(new DOMText($m->sokr));
	$sql_5="SELECT inslovo.name as i_name, sokr as i_sokr, abr FROM inslovo
    LEFT OUTER JOIN lang ON (inslovo.id_lang=lang.id)
	WHERE inslovo.id_slovo=".$m->id_slova;
	$res_5=pg_query($sql_5);
	while($m_5=pg_fetch_object($res_5)){
		$cell_interm = $elem_inf->appendChild(new DOMElement('interm'));
		$cell_inl = $cell_interm->appendChild(new DOMElement('i_name'));
		$text_inl = $cell_inl->appendChild(new DOMText($m_5->i_name));
		$cell_inls = $cell_interm->appendChild(new DOMElement('i_sokr'));
		$text_inls = $cell_inls->appendChild(new DOMText($m_5->i_sokr));
		$cell_lang = $cell_interm->appendChild(new DOMElement('lang'));
		$text_lang = $cell_lang->appendChild(new DOMText($m_5->abr));
	}
		$text_inc = $cell_inf->appendChild(new DOMText(str_replace($arr_z, '', $m->name)));
		$res_2=pg_query($sql_2);
		$or=preg_match('#b#', $m->name);
		if((($or==0)&&(isset($search))&&($search!==''))&&(($_REQUEST['p']==0)||(!isset($_REQUEST['p'])))){
			$name=preg_replace('#'.$search.'#usi', '<b>'.$search.'</b>', $m->name);
		}
		else $name=$m->name;
					  $str.='<tr>
    <td><a href="card.php?&id='.$m->id_slova.'"/>'.$name.'</a>
	</td></tr>';
		    while($m_2=pg_fetch_object($res_2)){
		    $sql_1="SELECT istochnik.name, istochnik.opisanie,
      		istochnik.ssilka     FROM k_ist
			LEFT JOIN istochnik ON (k_ist.id_ist=istochnik.id)
			WHERE k_ist.id_znach=".$m_2->id_znach;
			$sql_3="SELECT rubrikator.id, (num || ' - ' || rubrika) as rubrika, par_id   FROM k_rub
			LEFT JOIN rubrikator ON (rubrikator.id=k_rub.id_rub)
			WHERE k_rub.id_znach=".$m_2->id_znach;
			$cell_opis = $elem_inf->appendChild(new DOMElement('opisanie'));
			$cell_idzn = $cell_opis->appendChild(new DOMElement('id_znachenie'));
			$text_idzn = $cell_idzn->appendChild(new DOMText($m_2->id_znach));
			$cell_zn = $cell_opis->appendChild(new DOMElement('znachenie'));
			$text_zn = $cell_zn->appendChild(new DOMText($m_2->znach));
			$res_3=pg_query($sql_3);
			while($m_3=pg_fetch_object($res_3)){
			  $cell_rub = $cell_opis->appendChild(new DOMElement('rubrika'));
			  $name_rub = $cell_rub->appendChild(new DOMElement('name_rubrika'));
			  $text_nrub = $name_rub->appendChild(new DOMText($m_3->rubrika));
			 }
			$res_1=pg_query($sql_1);
			while($m_1=pg_fetch_object($res_1)){
				$cell_ist = $cell_opis->appendChild(new DOMElement('istochnik'));
			    $name_ist = $cell_ist->appendChild(new DOMElement('istochnik_name'));
				$opis_ist = $cell_ist->appendChild(new DOMElement('istochnik_opisanie'));
				$name_ist_text = $name_ist->appendChild(new DOMText($m_1->name));
				$opis_ist_text = $opis_ist->appendChild(new DOMText($m_1->opisanie));
				$ss_ist = $cell_ist->appendChild(new DOMElement('ssilka'));
			    $ss_ist_text = $ss_ist->appendChild(new DOMText($m_1->ssilka));
				
			}
		}
		if((isset($_REQUEST['search']))&&($_REQUEST['search']!=='')){
		  $sqli="SELECT istochnik.name, istochnik.opisanie,
      		istochnik.ssilka     FROM k_ist
			LEFT JOIN istochnik ON (k_ist.id_ist=istochnik.id)
			WHERE k_ist.id_znach=".$m->id_znach;
			$resi=pg_query($sqli);
		  $str.='<tr><td>';
		  while($mi=pg_fetch_object($resi)){
		    $str.='<a class="ista" href="'.$mi->ssilka.'">'.$mi->name.'</a>';
		  }
		  $str.='</td></tr><tr><td><zn>'.$m->znach.'</zn></td></tr>';
		  }
	}
}	
  if($_REQUEST['vid']=='xml'){
  $xsldoc = new DOMDocument();
        $xsldoc->load('out.xsl');
        $xsl = new XSLTProcessor();
       $xmldoc->saveXML();
        $xsl->importStyleSheet($xsldoc);
         
  header('Content-type: application/octet-stream');
  header('Content-Type: text/xml; charset=utf-8');
  header('Content-Disposition: attachment; filename=spisok.xml');
  header('Content-Transfer-Encoding: utf-8');
  echo $str=$xsl->transformToXML($xmldoc);
  }
  elseif($_REQUEST['vid']=='doc'){
header('Content-type: application/octet-stream');
header('Content-Type: application/vnd.ms-word; charset=utf-8');
header('Content-Disposition: attachment; filename=report.doc');
header('Content-Transfer-Encoding: utf-8');
  $xsldoc = new DOMDocument();
        $xsldoc->load('doc.xsl');
        $xsl = new XSLTProcessor();
       $xmldoc->saveXML();
        $xsl->importStyleSheet($xsldoc);
       $str=$xsl->transformToXML($xmldoc);
	   echo $str;
  }
   else{
  $count=pg_fetch_object(pg_query("SELECT count(id_slova) FROM (".$sql.") AS foo"));
		if($count->count>0){
		  $element = $xmldoc->appendChild(new DOMElement('footer'));
          $comment = $element->appendChild(new DOMText('Количество терминов: '.$count->count));
		}
  $str.='</table></div><br/>';
if($_REQUEST['do']!=='contfind'){
 if(($_REQUEST['vivod']==1)&&($_REQUEST['do']=='contfind'))$str.=$html->footer('Количество терминов: '.$count->count);
 else{
 $counto=pg_fetch_object(pg_query("SELECT count(id) FROM znach"));
 $counti=pg_fetch_object(pg_query("SELECT count(id) FROM istochnik"));
 $countr=pg_fetch_object(pg_query("SELECT count(id) FROM rubrikator"));
 $str.=$html->footer('Терминов: '.$count->count.', определений: '.$counto->count.', источников: '.$counti->count.', рубрик: '.$countr->count);
 }
}
  $str.=$html->endhtml;
  $xmldoc->saveXML();
  echo $str;
  }
  //переделать поиск:  поля если приходят 2 не работает, обработка массивов ист и рубрик сейчас через and, сделать скобки и or если массив
  //отметить запрошенные рубрики и источники галочками, выбирать все вложенные рубрики
//print_r($_REQUEST); 
//echo $sql;
