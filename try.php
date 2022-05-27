<?php

include "connect.php";

 	$username = 'moinul';
 	$username2 = 'ami';
 	$response = '';
 	$response2 = '';
 	$result = array();
 	$userid = array();
 	$usersid = '';

 if ($conn) 
 {
 	$fire = 'SELECT DISTINCT(user.user_id) as user_id FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username.'" OR message.`recvID` = user.user_id and username = "'.$username.'"';
 	$res = mysqli_query($conn,$fire);
 	if($res){
 		header("Content-Type: application/json");
 		
 		
 		while($row = mysqli_fetch_assoc($res))
	 		{
	 			$response = $row['user_id'];
			 	
	 		}

	 		$sql = 'SELECT DISTINCT(user.user_id) as user_id FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username2.'" OR message.`recvID` = user.user_id and username = "'.$username2.'"';
			$res2 = $conn->query($sql);

			while($rows = $res2->fetch_assoc()) {
				$response2 = $rows['user_id'];
   
  				}

  			$final = 'SELECT DISTINCT(message.msg),message.senderID, message.recvID , message.msgType FROM `message` JOIN `user` WHERE (message.`senderID` = user.user_id OR message.`recvID` = user.user_id)  and (message.senderID = "'.$response.'" and message.recvID = "'.$response2.'" OR message.senderID = "'.$response2.'" and message.recvID = "'.$response.'")';
			$res3 = $conn->query($final);

			$i = 0;

			while($rowz = $res3->fetch_assoc()) {
				$result[$i]['msg'] = $rowz['msg'];
				$result[$i]['senderID'] = $rowz['senderID'];
				$result[$i]['recvID'] = $rowz['recvID'];
				$result[$i]['msgType'] = $rowz['msgType'];
				$i++;
  				}	
 		
 	}
 	echo json_encode($result);
 		
 }
 else
 {
 	echo "Nothing";
 }


 	

?>

