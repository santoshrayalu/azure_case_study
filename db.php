<?php
$host = "product-db-server1.mysql.database.azure.com";
$username = "azureuser";
$password = "Password@12345";
$database = "productdb";

$conn = new mysqli($host, $username, $password, $database);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
?>
