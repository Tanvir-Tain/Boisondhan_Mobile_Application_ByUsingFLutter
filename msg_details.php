<?php
 include "connect.php";

 	$username = $_POST['name'];
 	$username2 = $_POST['username'];
 	$senderid = '';
 	$usersid = '';
 	$result = array();

 	if ($conn) {
 	$fire = 'SELECT * FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username.'" OR message.`recvID` = user.user_id and username = "'.$username.'"';
 	$res = mysqli_query($conn,$fire);
 	if($res)
 	{
 		header("Content-Type: application/json");
 		$row = mysqli_fetch_assoc($res);
 		if ($row['recvID'] == $row['user_id']) 
 		{
 			$userid = $row['user_id'];
 			

 			$fire2 = 'SELECT * FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username2.'" OR message.`recvID` = user.user_id and username = "'.$username2.'" ORDER by `timez` ASC';
 			$res2 = mysqli_query($conn,$fire2);
 			
 			while($row = mysqli_fetch_assoc($res2))
	 			{
	 				$senderid= $row['senderID'];
	 			}


 			$fire3 = 'SELECT * FROM `message` JOIN `user` WHERE message.`senderID` ="'.$senderid.'" and  user.user_id="'.$senderid.'" AND message.`recvID`="'.$userid.'"';
 			$res3 = $conn->query($fire3);

 			$j = 0;

 			while($rows = $res3 -> fetch_assoc())
			{
			 	$result[$j]['username'] = $rows['username'];
				$result[$j]['msg'] = $rows['msg'];
				$j++;
			}
			


 		}


 		
 	}
 	echo json_encode($result);
 }
 else
 {
 	echo "Nothing";
 }

 	
 
 

?>


