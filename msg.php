<?php

include "connect.php";

 	$username =$_POST['name'];
 	$response = array();
 	$response2 = array();
 	$result = array();
 	$userid = array();
 	$usersid = '';
 	$key = '';

 if ($conn) 
 {
 	$fire = 'SELECT * FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username.'" OR message.`recvID` = user.user_id and username = "'.$username.'"';
 	$res = mysqli_query($conn,$fire);
 	if($res)
 	{
 		header("Content-Type: application/json");
 		
 		$row = mysqli_fetch_assoc($res);
 		$usersid = $row['user_id'];
 		
 		$fire2 = 'SELECT DISTINCT CASE WHEN senderID = "'.$usersid.'" THEN recvID ELSE senderID END as chat_user FROM message JOIN user WHERE senderID = "'.$usersid.'" OR recvID ="'.$usersid.'"';
 		$res2 = $conn->query($fire2);

 		$i= 0;

 		while($rowz = $res2->fetch_assoc()) 
 		{
 			$response[$i]= $rowz['chat_user'];
 			$userid[$i] = $response[$i];
 			$i++;
 			
 		}

 		$j = 0;
 		

 		foreach ($userid as $userid)
 		{
 			$fire3 = 'SELECT DISTINCT(user.username), user.pro_pic,  message.senderID, message.recvID FROM message JOIN user WHERE (message.`recvID` = user.user_id OR message.`senderID` = user.user_id) AND ((message.`senderID`="'.$usersid.'" AND message.`recvID` ="'.$userid.'") OR (message.`senderID`="'.$userid.'" AND message.`recvID` ="'.$usersid.'")) AND user.username != "'.$username.'"';
			 $res3 = $conn->query($fire3);
			 
			 while($rows = $res3 -> fetch_assoc())
			 	{
			 		$result[$j]['username'] = $rows['username'];
				 	$result[$j]['pro_pic'] = $rows['pro_pic'];
				 	$result[$j]['senderID'] = $rows['senderID'];
				 	$result[$j]['recvID'] = $rows['recvID'];
				 			
			}
			$j++;
 		}

 	}
 	
 	/*---------------------For Checking Duplicates Username if found remove that one----------------------*/
 	

	echo json_encode($result);
 		
 }
 else
 {
 	echo "Nothing";
 }


 	

?>

