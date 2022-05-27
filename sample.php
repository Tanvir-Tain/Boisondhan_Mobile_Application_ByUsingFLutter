<?php

include "connect.php";

 	$username = 'moinul';
 	$response = array();
 	$response2 = array();
 	$result = array();
 	$userid = array();

 if ($conn) {
 	$fire = 'SELECT * FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username.'"';
 	$res = mysqli_query($conn,$fire);
 	if($res){
 		header("Content-Type: application/json");
 		$i = 0;
 		while($row = mysqli_fetch_assoc($res)){
 			$response[$i]= $row['recvID'];
 			$userid[]= $response[$i];
 			$i++;
 		}
 		foreach ($userid as $userid) {

 			$fire2 = 'SELECT user.username, message.msg FROM `message` JOIN `user` WHERE message.`recvID` ="'.$userid.'" and  user.user_id="'.$userid.'"';
 			$res2 = $conn->query($fire2);
 			

 			// array_push($result, $rows['username']);
 			$j = 0;
 		while($rows = $res2 -> fetch_assoc()){
 			$result[$j]['username'] = $rows['username'];
 			$result[$j]['msg'] = $rows['msg'];
 			$j++;
 		}
 		}
 		echo json_encode($result);
 	}

 }
 else{
 	echo "Nothing";
 }


 	

?>

