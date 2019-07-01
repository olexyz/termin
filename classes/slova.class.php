<?php
class slova{
	public $id='plus';
	public function sql(){
		if($this->id=='plus'){
	       $sql="SELECT slova.id as id_slova, slova.name as s_name, slova.sokr FROM slova
		   ORDER BY slova.name";
           $m=pg_query($sql);		   
	   }
	   else{
		   $sql="SELECT slova.id as id_slova, slova.name as s_name, slova.sokr FROM slova
		   WHERE  slova.id=".$this->id;
           $m=pg_query($sql);	
	   }
	   return $m;
	}
	public function input(){
	   if($this->id!=='plus'){
	       $m=pg_fetch_assoc($this->sql());
	}   
	$str.='<div id="l_slova"><div><label for="name">Наименование</label><br/><textarea name="name" style="width:100%;">'.$m['s_name'].'</textarea></div><div><label for="sokr">Сокращенное наименование</label><br/><textarea style="width:100%;" name="sokr">'.$m['sokr'].'</textarea></div><div>
	<input type="hidden" name="id_slova" value="'.$this->id.'"/></div>';
	return $str;
	}
	public function spisok_perevod(){
	if($this->id!=='plus'){
	    $sql="SELECT inslovo.id, inslovo.name, inslovo.sokr, lang.abr FROM inslovo
LEFT JOIN lang ON (inslovo.id_lang=lang.id)
		WHERE id_slovo=".$this->id;
		$str.='<div><br/><label>Список переводных эквивалентов:</label>';
	    $res=pg_query($sql);
		while($m=pg_fetch_object($res)){
		 $str.="<script type=\"text/javascript\">
       $(document).ready(function(){
	    $('#p".$m->id."').click(function(){
		  $(this).parent().children('.delb".$m->id."').css('display','inline');
		});
		$('#delb".$m->id."').click(function(){
		   $('#udd".$m->id."').css('display','block');
		   $('<div/>').css({
	        position: 'fixed',
	        top: 0,
	        left: 0,
	        right: 0,
	        bottom: 0,
	        background: 'black',
	        opacity: 0.5
	    }).appendTo(document.body).addClass('modal');
		   name='".$m->name."';
		   $('#udd".$m->id."').children('p').html('Удалить '+name+'?');  
		});
		
		$('#udd".$m->id."').draggable();
		 $('#udp".$m->id."').click(function(){
		  $('#delb".$m->id."').parent().css('display', 'none');
		  $('#xsp".$m->id."').remove();
		  $('#udd".$m->id."').css('display', 'none');
		  $('div.modal').remove();
				 });
			$('#udo".$m->id."').click(function(){ 
			$('#udd".$m->id."').css('display', 'none');
			     $('div.modal').remove();
				 
			});
	   });
	   </script>";
	     $str.='<div style="background-color:#FFFFFF; width:300px; z-index:102; position:fixed; border:1px solid; display:none; top:20%; left:20%;" id="udd'.$m->id.'"><p style="text-align:center;" id="pud"></p><aa class="btnud" href="" style="float:bottom; margin-left:7%; margin-bottom:5px;" id="udp'.$m->id.'">Удалить</aa><aa class="btnud" id="udo'.$m->id.'">Отмена</aa></div>';
		 $str.='<p><aa class="pseudoa" id="p'.$m->id.'"><i>'.$m->abr.':</i>'.$m->name.' '.$m->sokr.'</aa><input type="hidden" id="xsp'.$m->id.'" name="sp[]" value="'.$m->id.'"><img style="display:none;height:1em;cursor:pointer;" class="delb'.$m->id.'" id="delb'.$m->id.'" title="Удалить" src="img/svg/delete.svg"/></p>';
		}
		$str.='<br/></div><br/>';
		}
		return $str;
	}
	public function plus_perevod($lang,$i_name,$i_sok){
	    $str.='<div style=""><label for="i_name">Перевод</label><br/><textarea style="width:100%;" name="i_name" >'.$i_name.'</textarea>
	
	<br/><label for="lang">Язык</label><br/><select name="lang">';
	if($lang==0){
		$str.='<option value="NULL"> </option>';
	}
	else{
	    $m_3=pg_fetch_object(pg_query("SELECT * FROM lang WHERE id=".$lang));
		$str.='<option value="'.$m_3['id'].'">'.$m_3['ame'].'</option>';
	}
	$res=pg_query("SELECT * FROM lang ORDER by name");
	while($m_1=pg_fetch_assoc($res)){
		$str.='<option value="'.$m_1['id'].'">'.$m_1['name'].'</option>';
	}
	$str.='</select><br/><label for="i_sokr">Иностранное сокращение</label><br/>
	<textarea style="width:100%;" name="i_sokr" >'.$i_sokr.'</textarea></div>';
		return $str;
	}
}
?>