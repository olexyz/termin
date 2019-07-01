<?php
include_once('config.php');
$html=new myhtml;
$html->title='Редактор рубрик';
$str.=$html->headder();
$str.=$html->menu('');
$array=array();
	$n=0;
	$c=0;
    $a=array();
$rub= new rubrika;
	$str.='<h1>Редактор рубрик</h1><div style="text-align:center;"><form name="new" action="form.php"><div><label for="par_id">Выбрать родительскую рубрику</label><br/><select name="par_id" style="width:100%;">';
	$str.='<option value="" > </option>';
	$sql=$rub->sql();
	$tab=array();
	$tablee=array();
	$table_1=array();
	while($m=pg_fetch_assoc($sql)){
		array_push($tab,$m);
	}
	$tablee=$tab;
	$tablee=$table_1;
		$om=$rub->recursive($tab);
		foreach($om as $u){
			    $str.='<option value="'.$u['uid'].'">'.$u['rubrika'].'</option>';
		}
		$str.="</select></div><br/><label for='rubrika'>Наименование рубрики</label><br/><div><textarea name='rubrika' style='width:100%;'></textarea><input name='act' type='hidden' value='editrub'/><input name='id' type='hidden' value='new'/></div><br/><input  type='submit' value='Сохранить рубрику' /></form><br/><br/></div>";
	$a=$rub->recursive($tablee);
	foreach($a as $r){
		$str.='<div style="width:100%;"><ai class="pseudoa" id="i_'.$r['uid'].'">'.$r['rubrika'].'</ai><div id="r_id'.$r['uid'].'" class="r_id" style="display:none; text-align:center;"><br/><ai m="'.$r['rubrika'].'" class="ud" href="form.php?id='.$r['uid'].'&act=delrub">Удалить рубрику</ai>
		<form name="form'.$r['uid'].'" action="form.php?act=editrub"><div><label for="par_id">Выбрать родительскую рубрику</label><br/><select style="width:100%;" name="par_id">';
		if($r['pid']==''){
			$str.='<option value=""></option>';
			$sql_1=pg_query("WITH RECURSIVE rec(id, par_id, rubrika)
AS (
	SELECT rubrikator.id, 
		rubrikator.par_id, 
		rubrikator.rubrika FROM rubrikator WHERE par_id = ".$r['uid']."
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
	NOT rec.id = ".$r['uid']." ORDER BY id
		");
		}
		else{
			$b=pg_fetch_assoc(pg_query("SELECT id as uid, par_id as pid, rubrika FROM rubrikator WHERE id=".$r['pid']));
			 $str.='<option value="'.$b['uid'].'">'.$b['rubrika'].'</option>';
			 $sql_1=pg_query("WITH RECURSIVE rec(id, par_id, rubrika)
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
	NOT rec.id = ".$r['pid']." ORDER BY id
		");
		}
		$arrin=array();
		while($m_2=pg_fetch_assoc($sql_1)){
		array_push($arrin,$m_2['id'],$r['uid']);
	}

		$op=$rub->recursive($table_1);
		foreach($op as $o){
			if(!in_array($o['uid'],$arrin)){
			    $str.='<option value="'.$o['uid'].'">'.$o['rubrika'].'</option>';
			}
			else $str.='';
		}
		$str.="</select></div><label for='rubrika'>Изменить наименование рубрики</label><br/><div><textarea style='width:100%;' name='rubrika'  >".$r['name']."</textarea><input name='act' type='hidden' value='editrub'/><input name='id' type='hidden' value='".$r['uid']."'/>
		</div>
		<br/><input  type='submit'  value='Сохранить изменения'/></form></div><script type=\"text/javascript\">
       $(document).ready(function(){
		     $('#i_".$r['uid']."').on('click', function(){
			 $('.r_id').css('display','none');
		$('#r_id".$r['uid']."').css('display','inline');
		  });
		  });
    </script>";
	$str.='</div>';
	$str.=$html->ud();
	}
	
echo $str;
$html->footer('');

?>