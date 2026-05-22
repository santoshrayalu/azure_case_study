<?php
$host = "your-server.mysql.database.azure.com";
$username = "azureuser@your-server";
$password = "YourPassword";
$database = "productdb";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>