<?php
include_once('config.php');
$html=new myhtml;
$sql="SELECT * FROM slovari";
switch($_REQUEST['act']){
	case'view':
	$str.=$html->title='Cловари';
	$str.=$html->headder();
	$str.=$html->menu('');
	$str.='<script type="text/javascript" src="xmlhttprequest.js"></script><h1>Cловари</h1>';
	
	//$sql=$sql." WHERE accept=TRUE ORDER BY id";
	$res=pg_query($sql);/*
	$str.="<script type=\"text/javascript\">	 
 var request;
 var request = getXmlHttpRequest();
 function getServ(){
  var url='http://172.16.46.47/doki/';
  request.onreadystatechange = function(){
  if(request.readyState == 4){
  var responseText = String(request.responseText);
    alert(responseText);
    }
  }
  //Запрос
  request.open('GET', url, true);
  var tok = 'root:12345678';
  request.setRequestHeader('Authorization', 'Basic'+ btoa(tok));
  request.send(null);
  
  
 }
 window.onload = function(){
		  getServ();
		}
		</script>";*/
		
	/*	$str.='<script type=\"text/javascript\">
		function addScript(src){
		   var elem=document.createElement("script");
		   var src=src;
		   document.head.appendChild(elem);
		}
		</script>';*/
		$n=0;
	while($m=pg_fetch_object($res)){
	$n++;
	   $str.='
	   <div class="ist"><p>Словарь № '.$n.'</p><p>Наименование: <a href="slovari.php?act=main&id='.$m->id.'" class="pseudoa openform">'.$m->name.'</a></p><p>Описание: '.$m->comment.'</p><p>IP-адрес: '.$m->ip.'</p></div>';
	   }
	   $str.='';
	   
	break;
	case 'form':
	if($_REQUEST['id']==''){
	pg_query("INSERT INTO slovari (name, ip, comment) VALUES ('".$_REQUEST['name']."','".$_REQUEST['ip']."','".$_REQUEST['comment']."')");
	}
	else{
	pg_query("UPDATE slovari SET name='".$_REQUEST['name']."', ip='".$_REQUEST['ip']."', comment='".$_REQUEST['comment']."' WHERE id=".$_REQUEST['id']."");
	}
	header("Location: slovari.php?act=view");
	break;
	case 'del':
	pg_query("DELETE FROM slovari WHERE id=".$_REQUEST['id']);
	header("Location: slovari.php?act=view");
	break;
	case'edit':
	function form($id='', $name='', $ip='', $comment=''){
		$str.='<form style="text-align:center;" act="slovari.php" method="POST"><input type="hidden" name="act" value="form"/><input type="hidden" name="id" value="'.$id.'"/><div><label for="name">Название словаря:</label><br/><textarea  style="width:100%;" name="name">'.$name.'</textarea></div><div><label for="ip">Адрес словаря:</label><br/><textarea style="width:100%;" name="ip">'.$ip.'</textarea></div><label for="ip">Комментарии:</label><br/><textarea name="comment" style="width:100%;">'.$comment.'</textarea><br/><br/><br/><input type="submit" id="btnok" value="Сохранить"/></form>';
		return $str;
	}
	$str.=$html->title='Редактор словарей';
	$str.=$html->headder();
	$str.=$html->menu('');
	$str.="<h1>Редактор словарей</h1><script type=\"text/javascript\">
	$(document).ready(function(){
			 $('.openform').click(function(){	
               ".$html->modal."
			 $(this).parent().parent().children('.izmform').css('display','block');
			 });
			 $('.izmform').draggable();
			 $('.closeform').click(function(){				   
			     $(this).parent().css('display','none');
				 $('div.modal').remove();
			 });
			 });
		</script>";
	$str.=form();
	$str.='';
	$res=pg_query($sql);
	$n=0;
	while($m=pg_fetch_object($res)){
		$n++;
		if($m->name=='')$name=$m->ip;
		else $name=$m->name;
		$str.='<div class="ist" ><p>Словарь № '.$n.'</p><p>Наименование: '.$name.'</p><div class="izmform" style="z-index:102;display:none; border:1px solid gray; position:absolute; padding:3px; background-color:#FFFFFF;"><img class="closeform" align="right" style="cursor:pointer; width:1em;" src="img/svg/multiply.svg"/>'.form($m->id, $m->name, $m->ip, $m->comment).'</div><p>Описание: '.$m->comment.'</p><p>IP-адрес: '.$m->ip.'</p><p style="width:100%;" align="right"><aa href="slovari.php?act=del&id='.$m->id.'" m="'.$name.'" class="ud" >Удалить словарь</aa><aa class="btnud openform"  style="margin-left:5px;" >Изменить</aa></p></div>';
		 
	}
	$str.=$html->ud();
	break;
	case'main':
		$sql_1="SELECT * FROM slovari WHERE id=".$_REQUEST['id'];
	$m=pg_fetch_object(pg_query($sql_1));
	$str.=$html->title='Словарь '.$m->name;
	$str.=$html->headder();
	$str.=$html->menu('');

		   $str.="<script type=\"text/javascript\">
	   	   function save(){
		   $('.save').on('click',function(){
		     var name=$(this).parent().parent().children('.ntd').text();
			 var op=$(this).parent().parent().children('.otd').text();
             $('#loadff').load('form.php?act=lfroms&name='+encodeURI(name)+'&op='+encodeURI(op));
		   });
		}
	   </script>";
	   $str.='<h1>Словарь "'.$m->name.'"</h1><div id="d'.$m->id.'"></div><script type="text/javascript">
  window.onload = function() {
    show();
  }; 
          
	    var url="http://'.$m->ip.'/termin/data.php";
		var script=document.createElement("script");
		script.setAttribute("src", url);
		document.getElementById("d'.$m->id.'").appendChild(script);
		function show(){
		var finn=document.getElementById("load'.$m->id.'");
		for (var i = 0; i < jall.length; i++){
		  var td1=document.createElement("td");
		  var td2=document.createElement("td");
		  var td3=document.createElement("td");
		  var tr=document.createElement("tr");
		  var ii=document.createElement("img");
		  var n =jall[i].name;
		  var z = jall[i].znach
		  var jsondata=jall[i];
		  var name=document.createTextNode(n);
		  var opis=document.createTextNode(z);
		  ii.setAttribute("src", "img/svg/add-playlist.svg");
		  ii.setAttribute("class", "save");
		  ii.setAttribute("onclick", "save()");
		  ii.setAttribute("title", "Сохранить к себе в словарь");
		  ii.style.height="2em"
		  ii.style.cursor="pointer"
		  tr.setAttribute("class", "ntr");
		  td1.setAttribute("class", "ntd");
		  td2.setAttribute("class", "otd");
		  td1.appendChild(name);
		  tr.appendChild(td1);
		  finn.appendChild(tr);
		  td2.appendChild(opis);
		  tr.appendChild(td2);
		  finn.appendChild(tr);
		  td3.appendChild(ii);
		  tr.appendChild(td3);
		  finn.appendChild(tr);
		}
}
		   </script>';
	   $str.='<div id="loadff" style="width:100%; height:2em; text-align:center; color:red;"></div><div id="'.$m->ip.'" style="width:100%;"><table id="load'.$m->id.'" style="background-color:#FFFFFF;"></table></div>';
	break;
}
$str.=$html->endhtml;
echo $str;
?>