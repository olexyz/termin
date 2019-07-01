<?
include_once('config.php');
$sql="SELECT DISTINCT slova.id, znach.znach, slova.name 
FROM znach
LEFT OUTER JOIN slova ON (znach.id_slova=slova.id)
ORDER BY slova.id";
$res=pg_query($sql);
$arr=array();
while($m=pg_fetch_assoc($res)){
   	array_push($arr, $m);
}
$json=json_encode($arr);
echo"var jall=".$json;
?>