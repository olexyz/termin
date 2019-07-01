function view_del_but(id,act) {
   var el = window.document.getElementById(id);
   if (act == 2) el.style.display = 'none';
   else el.style.display = 'block';
}