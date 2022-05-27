<?php

include "connect.php";

 	$username = $_POST['name'];
 	$username2 = $_POST['username'];
 	$msg = $_POST['msg'];
 	$response = '';
 	$response2 = '';
 	$result = '';
 	$userid = array();
 	$usersid = '';


 if ($conn) 
 {
 	$fire = 'SELECT * FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username.'" OR message.`recvID` = user.user_id and username = "'.$username.'"';
 	$res = mysqli_query($conn,$fire);
 	if($res)
 	{
 		header("Content-Type: application/json");
 		
 		$row = mysqli_fetch_assoc($res);
 		
	 				
	 			while($row = mysqli_fetch_assoc($res))
	 		{
	 			$response = $row['user_id'];
			 	
	 		}

	 		$sql = 'SELECT DISTINCT(user.user_id) as user_id FROM `message` JOIN `user` WHERE message.`senderID` = user.user_id and username = "'.$username2.'" OR message.`recvID` = user.user_id and username = "'.$username2.'"';
			$res2 = $conn->query($sql);

			while($rows = $res2->fetch_assoc()) {
				$response2 = $rows['user_id'];
   
  				}

  				$borrow = "SELECT * FROM `message`";
				$res3 = $conn->query($borrow);

				$rowz = $res3->fetch_assoc();

  				if ($rowz['senderID'] == $response)
  				{

  					$sql2 = "INSERT INTO `message`(`senderID`, `recvID`, `msg`, `msgType`, `connected`) VALUES ('$response', '$response2', '$msg','sender', 'yes')";

		            if (mysqli_query($conn, $sql2)) {
		               // Successfully Login Message.
						     $result = 'Sent to user';
						     
						     // Converting the message into JSON format.
						    
		  				}

  				}
  				else
  				{
  					
					$sql2 = "INSERT INTO `message`(`senderID`, `recvID`, `msg`, `msgType`, `connected`) VALUES ('$response', '$response2', '$msg','sender', 'yes')";

		            if($conn->query($sql2)==TRUE) {
		            	$last_id = $conn->insert_id;
		               // Successfully Login Message.
						    $result = 'Sent to user';
						     
						     // Converting the message into JSON format.
						    
		  				}
						     
						     // Converting the message into JSON format.
						    
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

