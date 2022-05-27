<?php
 include "connect.php";

 $response = array();
 $userID = $_POST['name'];

 if ($conn) {
 	$fire = "SELECT * FROM `user` WHERE username = '$userID' ";
 	$res = mysqli_query($conn,$fire);
 	if($res){
 		header("Content-Type: application/json");
 		$i = 0;
 		while($row = mysqli_fetch_assoc($res)){
 			$response[$i]['user_id'] = $row['user_id'];
 			$response[$i]['username'] = $row['username'];
 			$response[$i]['usermail'] = $row['usermail'];
 			$response[$i]['password'] = $row['password'];
 			$response[$i]['university'] = $row['university'];
 			$response[$i]['user_mobile'] = $row['user_mobile'];
 			$response[$i]['registrationdate'] = $row['registrationdate'];
 			$i++;
 		}
 		echo json_encode($response);
 	}
 }
 else{
 	echo "Nothing";
 }

?>


