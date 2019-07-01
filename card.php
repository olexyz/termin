<?php
include_once('config.php');
		//card
	//card
	//card
	//card
	//card
	$xmldoc = new DOMDocument();
	$elem_find = $xmldoc->appendChild(new DOMElement('find'));
	$a=array();
	if(!is_array(unserialize($_REQUEST['id'])))array_push($a,$_REQUEST['id']);
	else $a=unserialize($_REQUEST['id']);
	foreach($a as $id){
        
	    
	    $sql="SELECT slova.id as id_slova, slova.name as name, slova.sokr FROM slova
		WHERE slova.id=".$id;
		$m=pg_fetch_object(pg_query($sql));
		$sql_2="SELECT znach.id as id_znach, id_slova, znach, fts_v, comment, date_upd
		FROM znach
        WHERE id_slova=".$m->id_slova;
		$elem_inf = $elem_find->appendChild(new DOMElement('row'));
		$id_z = $elem_inf->appendChild(new DOMElement('id_slova'));
		$id_z_text = $id_z->appendChild(new DOMText($m->id_slova));
		$cell_inf = $elem_inf->appendChild(new DOMElement('name'));
		$text_inc = $cell_inf->appendChild(new DOMText($m->name));
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
		$res_2=pg_query($sql_2);
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
		
	}	
if($_REQUEST['vid']=='xml'){
    $xsldoc = new DOMDocument();
        $xsldoc->load('out.xsl');
        $xsl = new XSLTProcessor();
       $xmldoc->saveXML();
        $xsl->importStyleSheet($xsldoc);
        $str=$xsl->transformToXML($xmldoc);
  header('Content-type: application/octet-stream');
  header('Content-Type: text/xml; charset=utf-8');
 header('Content-Disposition: attachment; filename=spisok.xml');
  header('Content-Transfer-Encoding: utf-8');
  }
  elseif($_REQUEST['vid']=='doc'){
  header('Content-type: application/octet-stream');
header('Content-Type: application/vnd.ms-word; charset=utf-8');
header('Content-Disposition: attachment; filename=report.doc');
header('Content-Transfer-Encoding: utf-8');
  $count=pg_fetch_object(pg_query("SELECT count(id_znach) FROM (".$sql_2.") AS foo"));
		if($count->count>0){
		  $element = $xmldoc->appendChild(new DOMElement('footer'));
          $comment = $element->appendChild(new DOMText('Термину назначены '.$count->count.' определений'));
		}
  $xsldoc = new DOMDocument();
        $xsldoc->load('doc.xsl');
        $xsl = new XSLTProcessor();
        $xmldoc->saveXML();
        $xsl->importStyleSheet($xsldoc);
        $str=$xsl->transformToXML($xmldoc);
  }
  else{
  $count=pg_fetch_object(pg_query("SELECT count(id_znach) FROM (".$sql_2.") AS foo"));
		if($count->count>1){
		  $element = $xmldoc->appendChild(new DOMElement('footer'));
          $comment = $element->appendChild(new DOMText('Термину назначены '.$count->count.' определения'));
		}
		elseif($count->count==1){
			$element = $xmldoc->appendChild(new DOMElement('footer'));
            $comment = $element->appendChild(new DOMText('Термину назначено '.$count->count.' определение'));
		}
		else{
			
		}
  $xsldoc = new DOMDocument();
        $xsldoc->load('card.xsl');
        $xsl = new XSLTProcessor();
        $xmldoc->saveXML();
        $xsl->importStyleSheet($xsldoc);
        $str=$xsl->transformToXML($xmldoc);
		}
echo $str;