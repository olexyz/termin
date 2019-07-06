<?php
  $user = "wcezxvczbtdeqc";
  $pass = "1def5a5d62d33ca99d00329236a0734b7e5cb860abd857c8644c12cda00c8a23";
  $db = "d8mn1v5711ut84";
  $port = "5432";
  $host = "ec2-54-228-246-214.eu-west-1.compute.amazonaws.com";
  $conn = pg_pconnect ("host=".$host." port=".$port." dbname=".$db." user=".$user." password=".$pass);
  if ( !$conn )  die( "No connection" );
  pg_set_client_encoding($conn, "UNICODE");
  date_default_timezone_set("Europe/Moscow");
  spl_autoload_register(function ($class) {
    include 'classes/' . $class . '.class.php';
  });
  session_start();
?>
