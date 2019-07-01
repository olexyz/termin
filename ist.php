<?php
include_once('config.php');
$html=new myhtml;
$html->title='Редактор источников';
$str.=$html->headder();
$str.=$html->menu('');
$ist=new istochnik;
$str.='<h1>Редактор источников</h1><div style="text-align:center;"><p>Добавить новый источник:</p><form name="dobist" action="form.php"><input name="act" type="hidden" value="editist"/><input name="id" type="hidden" value="new"/>'.$html->ud();
$str.=$ist->input('','','','','');
$str.='<br/><input type="submit" value="Сохранить"/></form></div>';
$res=$ist->sql_all();
while($m=pg_fetch_object($res)){
	$str.='<div class="ist"><p>Источник № '.$m->id.'</p><p>Наименование: '.$m->name.'</p><p>Описание: '.$m->opisanie.'</p><p>Ссылка: <a href="'.$m->ssilka.'">'.$m->ssilka.'</a></p>'.$html->block_load($m->id, 'form.php?act=loadistizm&id='.$m->id, '#'.$m->id, '$(this).attr("id")').'<br/><div style="float:right; margin-top:-30px;"><ai  m="'.$m->name.'" class="ud" style="margin-right:20px;" href="form.php?act=delist&id='.$m->id.'">Удалить источник</ai><aa class="btnud" style="margin-right:5px;" id="'.$m->id.'">Изменить источник</aa></div></div>';
}
$str.='</div>'.$html->endhtml;
echo $str;
?>