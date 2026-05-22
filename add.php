<?php
include 'db.php';

$name = $_POST['name'];
$desc = $_POST['description'];
$price = $_POST['price'];
$qty = $_POST['quantity'];

$sql = "INSERT INTO products (name, description, price, quantity)
        VALUES ('$name', '$desc', '$price', '$qty')";

$conn->query($sql);

echo "Product added";
?>