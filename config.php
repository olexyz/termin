<?php
  $user = "postgres";
  $pass = "12345678";
  $db = "termin";
  $port = "5432";
  $host = "localhost";
  $conn = pg_pconnect ("host=".$host." port=".$port." dbname=".$db." user=".$user." password=".$pass);
  if ( !$conn )  die( "No connection" );
  pg_set_client_encoding($conn, "UNICODE");
  date_default_timezone_set("Europe/Moscow");
  spl_autoload_register(function ($class) {
    include 'classes/' . $class . '.class.php';
  });
  session_start();
?>