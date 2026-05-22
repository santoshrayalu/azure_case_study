<?php
include 'db.php';

// Fetch products
$result = $conn->query("SELECT * FROM products");
?>

<!DOCTYPE html>
<html>
<head>
    <title>Product Management</title>
    <style>
        body {
            font-family: Arial;
            margin: 40px;
        }

        input {
            padding: 8px;
            margin: 5px;
        }

        button {
            padding: 8px 12px;
            background: green;
            color: white;
            border: none;
            cursor: pointer;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
        }

        th {
            background: #f2f2f2;
        }

        a {
            margin: 0 5px;
        }
    </style>
</head>

<body>

<h2>Add Product</h2>

<form method="POST" action="create.php">
    <input type="text" name="name" placeholder="Product Name" required>
    <input type="text" name="description" placeholder="Description" required>
    <input type="number" name="price" placeholder="Price" required>
    <input type="number" name="quantity" placeholder="Quantity" required>
    <button type="submit">Add Product</button>
</form>

<h2>Product List</h2>

<table>
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Description</th>
        <th>Price</th>
        <th>Quantity</th>
        <th>Actions</th>
    </tr>

    <?php while($row = $result->fetch_assoc()) { ?>
        <tr>
            <td><?= $row['id'] ?></td>
            <td><?= $row['name'] ?></td>
            <td><?= $row['description'] ?></td>
            <td><?= $row['price'] ?></td>
            <td><?= $row['quantity'] ?></td>
            <td>
                <a href="edit.php?id=<?= $row['id'] ?>">Edit</a>
                <a href="delete.php?id=<?= $row['id'] ?>" onclick="return confirm('Delete this product?')">Delete</a>
            </td>
        </tr>
    <?php } ?>
</table>

</body>
</html>