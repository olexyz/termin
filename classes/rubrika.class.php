<?php
class rubrika extends slova {
	//id
	public function sql(){
	       $sql="SELECT id as uid, par_id as pid, rubrika, rubrika as name FROM rubrikator ORDER BY id";
           $m=pg_query($sql);		   
	   return $m;
	}
private function withnull($lnm){
if(($lnm==1)||($lnm==2)||($lnm==3)||($lnm==4)||($lnm==5)||($lnm==6)||($lnm==7)||($lnm==8)||($lnm==9)){
		$lm="0".$lnm;
        }
        else{
          $lm=$lnm;
        }
return $lm;
}
	
public function recursive($data, $pid=0, $level=0, $num=""){
	global $array;
	$b=0;
	foreach($data as $row){
	if($row['pid']==$pid){
		$b++;	
			$_row['uid']=$row['uid'];
			$_row['pid']=$row['pid'];
			if($num=="")$_row['num']=$this->withnull($b);
			else $_row['num']=$num.'.'.$this->withnull($b);
			$_row['rubrika']=str_pad('', $level*3,'-').' '.$_row['num'].' '.$row['rubrika'];
			$_row['name']=$row['name'];
			$_row['level']=$level;
			$array[]=$_row;
			$this->recursive($data,$row['uid'],$level+1, $_row['num']);
			
		}
}
   return $array;
}	
	
}
?>