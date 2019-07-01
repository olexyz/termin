<?php
include_once('config.php');
if($_REQUEST['editslovo']){
	//editslovo
	//editslovo
	//editslovo
	$html=new myhtml;

$str.=$html->headder();
$str.=$html->menu('');
if(($_REQUEST['editslovo'])=='plus'){
  $html->title='Добавление термина';
  $str.='<h1>Добавление термина</h1>';
}
else
{
  $html->title='Редактирование термина';
  $str.='<h1>Редактирование термина</h1>';
}
	$slova=new slova;
	$slova->id=$_REQUEST['editslovo'];
    $res=$slova->sql();
	$m=pg_fetch_object($res);
	$str.='<form method="POST" action="form.php"><input type="hidden" name="act" value="edit"/><input type="hidden" name="only" value="slovo"/><input type="hidden" name="id_slovo" value="'.$slova->id.'"/>';
	$str.='<div id="lslova">'.$slova->input().$slova->spisok_perevod().$slova->plus_perevod(0,'','').'</div>
	<br/><br/>
	<input type="submit" style="margin-left:40%;" value="Сохранить"/><br/><br/></form>';
	$str.=''.$html->endhtml;
	echo $str;
}
else if($_REQUEST['editz']){
	//edit znach
	//edit znach
	//edit znach
	$html=new myhtml;
	if($_REQUEST['editz']=='plus'){
	   $id_slovo=$_REQUEST['id_slovo'];
	   $name=pg_fetch_object(pg_query("SELECT name FROM slova WHERE id=".$id_slovo));
	   $html->title='Добавление определения для термина "'.$name->name.'"';
       $h1='<h1>Добавление определения для термина "'.$name->name.'"</h1>';
		
    }
    else{
	   $m=pg_fetch_object(pg_query("SELECT * FROM znach WHERE id=".$_REQUEST['editz']));
	   $id_slovo=$m->id_slova;
	   $name=pg_fetch_object(pg_query("SELECT name FROM slova WHERE id=".$id_slovo));
	   $html->title='Редактирование определения для термина "'.$name->name.'"';
       $h1='<h1>Редактирование определения для термина "'.$name->name.'"</h1>';
	   
       
    }
$str.=$html->headder();
$str.=$html->menu('').$h1;
	$str.="<script type=\"text/javascript\">
       $(document).ready(function(){
		  $('#r_name').change(function(){
			  var v=$(this).val();
			      $('#rub').load('form.php?act=rub&val='+v);
		  });
		  
		  $('#ist').change(function(){
			  var id=$(this).val();
			  $('#isist').load('form.php?act=isist&id='+id);			   	  
		  });
		  		  
		  $('#addist').on('click', function(){
		  var ist=$('#ist').val();
		  var name=$('#ist_name').val();
		  var opis=$('#ist_o').val();
		  var ssilka=$('#ist_ss').val();	  $.get('form.php?act=plusist&id='+ist+'&name='+name+'&opis='+opis+'&ssilka='+ssilka, function(data){
			     $('#vidist').append(data);
			  });  
		  });
		});
    </script>";
	$str.='<form method="POST" action="form.php"><input type="hidden" name="act" value="edit"/><input type="hidden" name="id_znach" value="'.$_REQUEST['editz'].'"/>';
	$str.='<input type="hidden" name="slova" value="'.$id_slovo.'"/><br/><label for="znach">Описание</label><br/><textarea name="znach" style="width:100%; font-size: 1em; height:150px;">'.$m->znach.'</textarea><br/><br/><label for="s_name">Рубрики:</label><br/>
	<fieldset style="cursor:default; width:99%; height:200px; overflow-y:scroll; margin-bottom:5px; margin-top:5px;">
    <div style="margin-top:10px;width:100%;"><table>';
	$rub= new rubrika;
	$tab=array();
	$sql=$rub->sql();
	while($m=pg_fetch_assoc($sql)){
		array_push($tab,$m);
	}
	$r=$rub->recursive($tab);
	if($_REQUEST['editz']!=='plus'){
    $sql_3="SELECT * FROM k_rub WHERE id_znach=".$_REQUEST['editz'];
	$res_3=pg_query($sql_3);
	$check=array();
	while($m_3=pg_fetch_assoc($res_3)){
		array_push($check,$m_3['id_rub']);
	}
	}
	foreach($r as $ckx){
    if($_REQUEST['editz']!=='plus'){
      if(in_array($ckx['uid'],$check)){
			$ch="checked";
		}
		else{
			$ch="unchecked";
		}
	   }
		$str.='<tr><td><input type="checkbox" name="rub[]"  value="'.$ckx['uid'].'" '.$ch.'/></td><td style="font-size: 1em;">'.$ckx['rubrika'].'</td></tr>';
	}
	$str.='</table></div></fieldset><br/>';
	$ist=new istochnik;
	$ist->id_ist=$_REQUEST['editz'];
	if($_REQUEST['editz']!=='plus')$ist->id_znach=$_REQUEST['editz'];
	$str.='<div><label>Источники:</label><fieldset id="vidist" style="width:100%;height:200px;overflow-y:scroll;overflow-x:hidden;">';
	$str.=$ist->inputs($_REQUEST['editz']);
	$str.='</fieldset><input type="submit" style="margin-top:10px; margin-left:40%;" value="Сохранить описание"/></form></div>';
	$str.=''.$html->endhtml;
	echo $str;
}
else{
switch($_REQUEST['act']){
	case 'ud':
	$html=new myhtml;
	echo $html->ud();
	break;
	case 'loadrubchk':
	$id_rub=explode(',',$_REQUEST['id_rub']);
	$sql_2="SELECT * FROM rubrikator WHERE par_id=".$_REQUEST['id']." ORDER BY id";
	$res_2=pg_query($sql_2);

	while($m_2=pg_fetch_object($res_2)){
		echo"<script type=\"text/javascript\">
      $(document).ready(function(){
		  $('.open".$m_2->id."').click(function(){
	  var id=$(this).attr('id');
	  var json_id_rub=".$_REQUEST['id_rub'].";
	     $(this).parent().children('.src".$m_2->id."').load('form.php?act=loadrubchk&&id='+id+'&id_rub='+json_id_rub);
		 $(this).css('display','none'); 
		 $(this).parent().children('.close".$m_2->id."').css('display','inline'); 
	  });
	  
	  $('.close".$m_2->id."').click(function(){
		$(this).css('display','none'); $(this).parent().children('.src".$m_2->id."').html('');
		$(this).parent().children('.open".$m_2->id."').css('display','inline'); 
	  });
	    });
  </script>";
  	if((in_array($m_2->id,$id_rub)))$idrub='checked';
	else$idrub='';
	   echo'<p><div class="r'.$m_2->id.'"><div class="r" style="display:inline;"><v class="open'.$m_2->id.'" style="cursor:pointer;" id="'.$m_2->id.'"> + </v><v class="close'.$m_2->id.'" style="display:none; cursor:pointer;"> - </v><input name="id_rub[]" '.$idrub.' class="id_rub" type="checkbox" value="'.$m_2->id.'"/>'.$m_2->num.' '.$m_2->rubrika.'<div class="src'.$m_2->id.'" style="margin-left:5%;"></div></div></p>';
	}
	
	
	
	break;
	
	
	
	
	
    case 'loads':
echo"<script type=\"text/javascript\">
      $(document).ready(function(){
	  $('.open').click(function(){
	  var id=$(this).attr('id');
	     $(this).parent().children('.src').load('form.php?act=loadrubchk&id='+id);
	  });
  });
  </script>";
	break;
	case 'lfroms':
echo"Термин ".$_REQUEST['name']." сохранен!";
$m=pg_fetch_object(pg_query("INSERT INTO slova(
             name)
            VALUES ( '".$_REQUEST['name']."' ) RETURNING id
          "));
		  $id_slova=$m->id;
		  pg_query("INSERT INTO znach(
             id_slova, znach)
             VALUES ( ".$id_slova.", '".$_REQUEST['op']."')");
	break;
	 case 'loada':
echo"";
	break;
	
	case 'slovo':
	$slova=new slova;
	$slova->id=$_REQUEST['val'];
	echo $slova->input().$slova->spisok_perevod().$slova->plus_perevod(0,'','');
	break;
	
	case 'delinsl':
    pg_query("DELETE FROM inslovo WHERE id=".$_REQUEST['id']);
	break;
	
	case 'rub':
	$fs=new rubrika;
	$fs->id=$_REQUEST['val'];
	echo $fs->input();
	break;
	
	case 'edit':

    if($_REQUEST['only']=='slovo'){
	 if($_REQUEST['id_slova']=='plus'){
		$m=pg_fetch_object(pg_query("INSERT INTO slova(
             name, sokr)
            VALUES ( '".$_REQUEST['name']."', '".$_REQUEST['sokr']."') RETURNING id
          "));
		  $id_slova=$m->id;
	}
	else{
		$id_slova=$_REQUEST['id_slova'];
		pg_query("UPDATE slova
                  SET name='".$_REQUEST['name']."', sokr='".$_REQUEST['sokr']."'
                  WHERE id=".$_REQUEST['id_slova']);
	}
	if((isset($_REQUEST['znach']))&&($_REQUEST['znach']!=='')){
		 pg_query("INSERT INTO znach(
             id_slova, znach)
             VALUES ( ".$id_slova.", '".$_REQUEST['znach']."')");
	}
	if(isset($_REQUEST['sp'])){
	   $msp=pg_query("SELECT * FROM inslovo WHERE id_slovo=".$_REQUEST['id_slova']);
	   $arr_msp=array();
	    foreach($_REQUEST['sp'] as $pps){
	      array_push($arr_msp,$pps);
		}
	   while($msps=pg_fetch_object($msp)){
	     if(!in_array($msps->id,$arr_msp)){
		    pg_query("DELETE FROM inslovo WHERE id=".$msps->id);
		 }
	  
	  
	   }
	}
	if((isset($_REQUEST['i_name']))&&($_REQUEST['i_name']!==''))pg_query("INSERT INTO inslovo(
             name, sokr, id_lang, id_slovo) VALUES ('".$_REQUEST['i_name']."', '".$_REQUEST['i_sokr']."', ".$_REQUEST['lang'].", ".$id_slova.")");
			// print_r($_REQUEST);
			 
		header("Location: card.php?id=".$id_slova);
	}
	else{
	//print_r($_REQUEST);
	
    header("Location: card.php?id=".$_REQUEST['slova']);
	if($_REQUEST['id_znach']!=='plus'){
		$id_znach=$_REQUEST['id_znach'];
		pg_query("UPDATE znach
        SET  id_slova=".$_REQUEST['slova'].", znach='".$_REQUEST['znach']."'
        WHERE id=".$_REQUEST['id_znach']);
		$res_7=pg_query("SELECT id FROM k_rub WHERE id_znach=".$_REQUEST['id_znach']);
	    while($m_7=pg_fetch_object($res_7))pg_query("DELETE FROM k_rub WHERE id=".$m_7->id);
	}
	else{
	$id_slova=$_REQUEST['slova'];
	    $m_1=pg_fetch_object(pg_query("INSERT INTO znach(
             id_slova, znach)
             VALUES ( ".$id_slova.", '".$_REQUEST['znach']."') RETURNING id"));
	         $id_znach=$m_1->id;
	}
	if(is_array($_REQUEST['rub'])){
    foreach($_REQUEST['rub'] as $idrub){
			pg_query("INSERT INTO k_rub (id_znach, id_rub) VALUES (".$id_znach.", ".$idrub.")");
	}
	}
	else{
	pg_query("INSERT INTO k_rub (id_znach, id_rub) VALUES (".$id_znach.", ".$_REQUEST['rub'].")");
	}
	$d=pg_query("SELECT * FROM k_ist WHERE id_znach=".$id_znach);
	while ($a=pg_fetch_object($d)){
	  pg_query("DELETE FROM k_ist WHERE id=".$a->id);
	}
	foreach($_REQUEST['plus_ist'] as $kist){
		if($kist>0){
		  pg_query("INSERT INTO k_ist(
             id_znach, id_ist)
              VALUES ( ".$id_znach.", ".$kist.")");
		}
	}
	}
	break;
	
	case 'isist':
	$ist=new istochnik;
	if($_REQUEST['id']=='plus')$ist->id_ist=0;
	else$ist->id_ist=$_REQUEST['id'];
	$m=$ist->sql_one();
	echo $ist->input($m->name, $m->opisanie, $m->ssilka, $m->id);
	break;
	
	case 'plusist':
	$ist=new istochnik;
	if($_REQUEST['id']=='plus'){
			$ist->id_ist=$ist->insert($_REQUEST['name'],$_REQUEST['opis'],$_REQUEST['ssilka']);
			echo $ist->vid_one();
	}
	else{
	    $ist->id_ist=$_REQUEST['id'];
	    echo $ist->vid_one();
	}
	break;
	
	case 'del':
	$s=pg_fetch_assoc(pg_query("SELECT id_slova FROM znach WHERE id=".$_REQUEST['id_znach']));
	$a=$s['id_slova'];
	header("Location: card.php?id=".$a);
	pg_query("DELETE FROM znach WHERE id=".$_REQUEST['id_znach']);
	break;
	
	case 'delslovo':
     header("Location: index.php");
	pg_query("DELETE FROM slova WHERE id=".$_REQUEST['id_slovo']);
	break;
	
	case 'menu':
    $html=new myhtml;
	$html->card=1;
	echo $html->menu('',$_REQUEST['id'],1);
	break;
	
	case 'editrub':
	if((!isset($_REQUEST['par_id']))||($_REQUEST['par_id']==''))$_REQUEST['par_id']='NULL';
	header("Location: rub.php");
if($_REQUEST['id']=='new'){
	$i=pg_fetch_object(pg_query("INSERT INTO rubrikator(
             rubrika, par_id)
             VALUES ( '".$_REQUEST['rubrika']."', ".$_REQUEST['par_id'].") RETURNING id"));
			 $id=$i->id;
}
else{
	pg_query("UPDATE rubrikator
             SET rubrika='".$_REQUEST['rubrika']."', par_id=".$_REQUEST['par_id']."
             WHERE id=".$_REQUEST['id']);
			 $id=$_REQUEST['id'];
}
    $rub=new rubrika;
    $tab=array();
	$sql=$rub->sql();
	while($m=pg_fetch_assoc($sql)){
		array_push($tab,$m);
	}
	$r=$rub->recursive($tab);
	foreach($r as $n){
	  if($n['uid']==$id){
		  pg_query("UPDATE rubrikator
             SET num='".$n['num']."'
             WHERE id=".$id);
	  }
	}
	break;
	
	
	case 'delrub':
header("Location: rub.php");
$r=pg_fetch_assoc(pg_query("SELECT id as uid, par_id as pid, rubrika, rubrika as name FROM rubrikator WHERE id=".$_REQUEST['id']));
echo"<pre>";
print_r($r);
echo"</pre>";
if($r['pid']==''){
		$res=pg_query("SELECT 
		rubrikator.id, 
		rubrikator.par_id, 
		rubrikator.rubrika
	FROM 
		rubrikator WHERE id=".$_REQUEST['id']);
}
else{
   $res=pg_query("WITH RECURSIVE rec(id, par_id, rubrika)
AS (
	SELECT rubrikator.id, 
		rubrikator.par_id, 
		rubrikator.rubrika FROM rubrikator WHERE id = ".$r['uid']."
	UNION
	SELECT 
		rubrikator.id, 
		rubrikator.par_id, 
		rubrikator.rubrika
	FROM 
		rubrikator , rec
	WHERE 
		rec.id = rubrikator.par_id)
SELECT
  rec.id,
  rec.par_id
FROM
  rec
WHERE 
	NOT rec.id = ".$r['pid']);
}
while($m=pg_fetch_assoc($res)){
	echo"<pre>";
print_r($m);
echo"</pre>";
pg_query("DELETE FROM rubrikator WHERE id=".$m['id']);
}
	break;
	
	case 'delist':
    header("Location: ist.php");
    pg_query("DELETE FROM istochnik WHERE id=".$_REQUEST['id']);
	
	break;
	
	case 'editist':
	header("Location: ist.php");
	$ist=new istochnik;
	print_r($_REQUEST);
	if($_REQUEST['id']=='new'){
		echo 'b';
	    $ist->id_ist=$ist->insert($_REQUEST['ist_name'],$_REQUEST['ist_o'],$_REQUEST['ist_ss']);
    }
    else{
		$ist->id_ist=$_REQUEST['id'];
		echo 'a';
	    pg_query("UPDATE istochnik
                 SET name='".$_REQUEST['ist_name']."', opisanie='".$_REQUEST['ist_o']."', ssilka='".$_REQUEST['ist_ss']."'
                 WHERE id=".$_REQUEST['id']);
    }
    break;
	
	case 'loadistizm':
    $ist=new istochnik;
	$ist->id_ist=$_REQUEST['id'];
	$m=$ist->sql_one();
	echo'<form action="form.php"><input name="act" type="hidden" value="editist"/><p>Источник №: '.$_REQUEST['id'].'</p>'.$ist->input($m->name, $m->opisanie, $m->ssilka, $_REQUEST['id']).'<input type="hidden" name="id" value="'.$_REQUEST['id'].'"/><br/><br/><input type="submit" value="Сохранить изменения" style="margin-left:auto;"/></form>';
	
	break;
	case 'sel_rub':
	//для выделения всех вложенных рубрик
	$arr=array();
	$res=pg_query("WITH RECURSIVE rec(id, par_id, rubrika)
AS (
	SELECT rubrikator.id, 
		rubrikator.par_id, 
		rubrikator.rubrika FROM rubrikator WHERE par_id = ".$_REQUEST['id']."
	UNION
	SELECT 
		rubrikator.id, 
		rubrikator.par_id, 
		rubrikator.rubrika
	FROM 
		rubrikator , rec
	WHERE 
		rec.id = rubrikator.par_id)
SELECT
  rec.id,
  rec.par_id
FROM
  rec
WHERE 
	NOT rec.id = ".$_REQUEST['id']." ORDER BY id");
	while($m=pg_fetch_assoc($res))array_push($arr,$m['id']);
	$output = json_encode($arr);

   echo $output . "\n";
	break;
}
}
?>