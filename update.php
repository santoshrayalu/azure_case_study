<?php
include 'db.php';

$id = $_POST['id'];
$name = $_POST['name'];

$sql = "UPDATE products SET name='$name' WHERE id=$id";
$conn->query($sql);

echo "Updated";
?>