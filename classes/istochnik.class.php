<?php
class istochnik{
	public $id_znach;
	public $id_ist;
	
	public function vid($name,$opisanie,$ssilka,$id){
	    $str.="<script type=\"text/javascript\">
        $(document).ready(function(){
				  $('.nonist".$id."').click(function(){
					  var val=$('#plusi".$id."').remove();
			  $(this).parent().css('display', 'none');			   	  
		  });
	    });
        </script>";
	    $str.='<div class="ist"><p>Источник №'.$id.':</p><p>'.$name.'</p><p>'.$opisanie.'</p><p>'.$ssilka.'</p><input type="hidden" name="plus_ist[]" class="plusi" id="plusi'.$id.'" value="'.$id.'"/><input type="button" value="Удалить источник" class="nonist'.$id.'" /></div>';
		return $str;
	}
	
	public function select_vid(){
		  $sql="SELECT istochnik.id, istochnik.name, istochnik.opisanie, istochnik.ssilka 
	      FROM k_ist 
	      LEFT JOIN istochnik ON (k_ist.id_ist=istochnik.id)
	      WHERE id_znach=".$this->id_znach." ORDER BY id";
		  $res=pg_query($sql);
		  $str.='<div>';
	      $n=0;
	      while($m=pg_fetch_object($res)){
	        $n++;
			$str.=$this->vid($m->name,$m->opisanie,$m->ssilka,$m->id);
	      }
		return $str;   
	}
	
	public function sql_all(){
		$sql="SELECT *
	          FROM istochnik  ORDER BY id";
	    $res=pg_query($sql);
		return $res;
	}
	
	public function sql_one(){
		$sql="SELECT *
	          FROM istochnik WHERE id=".$this->id_ist;
	    $res=pg_fetch_object(pg_query($sql));
		return $res; 
	}
	
	public function vid_one(){
	    $m=$this->sql_one();
		$str.=$this->vid($m->name,$m->opisanie,$m->ssilka,$m->id);
		return $str;
	}
	
	public function option(){
		$res_2=$this->sql_all();
		while($m_2=pg_fetch_object($res_2)){
	      $str.='<option value="'.$m_2->id.'">'.$m_2->id.' - '.$m_2->name.'</option>';
	    }
		return $str;
	}
  public function inputs($id){
	        $a=array();
			if($id!=='plus'){
			  
		      $res=pg_query("SELECT * FROM k_ist WHERE id_znach=".$id);
			  while($m=pg_fetch_object($res)){
				  array_push($a,$m->id_ist);
			  } 
			}
			$res_2=$this->sql_all();
			$chk='';
		    while($m_2=pg_fetch_object($res_2)){
				if(in_array($m_2->id, $a))$chk='checked';
				else $chk='';
	        $str.='<p><input type="checkbox" name="plus_ist[]" '.$chk.' value="'.$m_2->id.'" name/><label style="color:#000000; font-size:1em;">'.$m_2->id.' - '.$m_2->name.'</label></p>';
	    }
		return $str;
	}
	public function input($name, $opisanie, $ssilka, $id){
		$str.='<div><label for="ist_name">Наименование источника</label><br/><textarea style="width:100%;" name="ist_name" id="ist_name">'.$name.'</textarea></div><div><label for="ist_o">Описание источника</label><br/><textarea style="width:100%;" name="ist_o"  id="ist_o">'.$opisanie.'</textarea></div><div><label for="ist_ss">Ссылка на источник</label><br/>
	    <textarea style="width:100%;" id="ist_ss" name="ist_ss">'.$ssilka.'</textarea></div>';
		return $str;
		
	}
	
	public function insert($name, $opis, $ssilka){
	   $id=pg_fetch_object(pg_query("INSERT INTO istochnik (name, opisanie, ssilka) VALUES ('".$name."', '".$opis."', '".$ssilka."') RETURNING id"));
	   return $id->id;
	}
}
?>