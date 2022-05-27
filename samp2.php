<?php

include "connect.php";

 	$username = $_POST['name'];
 	$response = array();
 	$response2 = array();
 	$result = array();
 	$userid = array();
 	$usersid = '';
 	$key = '';

 	if ($conn) {
 	$fire = 'SELECT * FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username.'" OR message.`recvID` = user.user_id and username = "'.$username.'"';
 	$res = mysqli_query($conn,$fire);
 	if($res){

 		$row = mysqli_fetch_assoc($res);
 		$usersid = $row['user_id'];
 		$i = 0;
 		while($row = mysqli_fetch_assoc($res))
 		{
 			$response[$i]= $row['recvID'];
			$userid[]= $response[$i];
			print_r($userid);
			$i++;
 		}


 	}

 		
 }
 else{
 	echo "Nothing";
 }