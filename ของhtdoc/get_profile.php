<?php
header('Content-Type: application/json; charset=utf-8');

$conn = new mysqli("localhost", "root", "", "food_and_fit_db");
$conn->set_charset("utf8");

$mb_ID = $_GET['mb_ID'];

$sql = "SELECT * FROM member WHERE mb_ID = '$mb_ID'";
$result = $conn->query($sql);

if ($row = $result->fetch_assoc()) {
  echo json_encode([
    "status" => true,
    "data" => $row
  ]);
} else {
  echo json_encode([
    "status" => false,
    "message" => "Not found"
  ]);
}