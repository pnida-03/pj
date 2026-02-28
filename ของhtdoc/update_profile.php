<?php
header('Content-Type: application/json; charset=utf-8');

$conn = new mysqli("localhost", "root", "", "food_and_fit_db");
$conn->set_charset("utf8");

$data = json_decode(file_get_contents("php://input"), true);

$mb_ID = $data['mb_ID'];
$height = $data['mb_Height'];
$weight = $data['mb_Weight'];
$goal = $data['mb_Goal'];
$activity = $data['mb_ActivityLevel'];

$sql = "UPDATE member SET
  mb_Height = '$height',
  mb_Weight = '$weight',
  mb_Goal = '$goal',
  mb_ActivityLevel = '$activity'
WHERE mb_ID = '$mb_ID'";

if ($conn->query($sql)) {
  echo json_encode(["status" => true]);
} else {
  echo json_encode([
    "status" => false,
    "error" => $conn->error
  ]);
}