<?php
class myxml {
	private $xmldoc = new DOMDocument();
	public $id;
	public $search;
	public function find(){
		$m=$this->xmldoc;
		return $m->appendChild(new DOMElement('find'));
	}
	public $sql_one(){
			$sql="SELECT slova.id as id_slova, slova.name as s_name, slova.sokr, slova.i_name, slova.i_sokr, znach.znach, znach.id AS id_znach, rubrikator.rubrika , rubrikator.id AS id_rub FROM znach
	        LEFT JOIN slova ON (znach.id_slova=slova.id)
	        LEFT JOIN rubrikator ON (znach.id_rubrika=rubrikator.id)
	        WHERE znach.id=".$this->id;
		    $m=pg_fetch_object(pg_query($sql));
		    return $m;
	}
	public function sql_search(){
		$sql="SELECT slova.name, znach.znach, rubrikator.rubrika, znach.id as id_znach FROM znach
		LEFT JOIN slova ON (znach.id_slova=slova.id)
		LEFT JOIN rubrikator ON (znach.id_rubrika=rubrikator.id)
		WHERE
		slova.name ILIKE '%".$this->search."%' 
		OR znach.znach ILIKE '%".$this->search."%' 
		ORDER BY slova.name";
		return $sql;
	}
	public function sql_istochnik(){
		    $sql="SELECT istochnik.name, istochnik.opisanie, istochnik.ssilka FROM k_ist
			LEFT JOIN istochnik ON (k_ist.id_ist=istochnik.id)
			WHERE k_ist.id_znach=".$this->id;
			return $sql;
	}
	public function elements(){
		    $elem_find=$this->find();
		    $elem_inf = $elem_find->appendChild(new DOMElement('row'));
			$id_z = $elem_inf->appendChild(new DOMElement('id'));
		    $id_z_text = $id_z->appendChild(new DOMText($m->id_znach));
			$cell_inf = $elem_inf->appendChild(new DOMElement('name'));
			$text_inc = $cell_inf->appendChild(new DOMText($m->name));
			$cell_zn = $elem_inf->appendChild(new DOMElement('znachenie'));
			$text_zn = $cell_zn->appendChild(new DOMText($m->znach));
			if($m->rubrika!==''){
			  $cell_rub = $elem_inf->appendChild(new DOMElement('rubrika'));
			  $text_rub = $cell_rub->appendChild(new DOMText($m->rubrika));
			}
			$res_1=pg_query($this->sql_istochnik());
			while($m_1=pg_fetch_object($res_1)){
				$cell_ist = $elem_inf->appendChild(new DOMElement('istochnik'));
			    $name_ist = $cell_ist->appendChild(new DOMElement('istochnik_name'));
				$opis_ist = $cell_ist->appendChild(new DOMElement('istochnik_opisanie'));
				$name_ist_text = $name_ist->appendChild(new DOMText($m_1->name));
				$opis_ist_text = $opis_ist->appendChild(new DOMText($m_1->opisanie));
				$ss_ist = $cell_ist->appendChild(new DOMElement('ssilka'));
				$ss_ist_text = $ss_ist->appendChild(new DOMText($m_1->ssilka));
				
			}
			$xml=$this->xmldoc;
		return $xml->saveXML();
	}
	
}
?>