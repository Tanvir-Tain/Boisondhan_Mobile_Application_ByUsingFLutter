<?php

include "connect.php";

 	$username =$_POST['name'];

 if ($conn) 
 {
 	$fire = 'SELECT * FROM `user` Where username = "'.$username.'"';

 	$res = mysqli_query($conn,$fire);
 	if($res)
 	{
 		header("Content-Type: application/json");
 		
 		
 		while($row = mysqli_fetch_assoc($res))
	 		{
	 			$response = $row['user_id'];
			 	
	 		}

       //$sql = 'DELETE FROM `message` WHERE senderID= "'.$response.'"';

	 	 $sql = "INSERT INTO `message`(`senderID`, `recvID`, `msg`, `msgType`, `connected`) VALUES ('.$response.', '1', 'everybody  i am  new ','sender', 'yes'),('1', '.$response.', 'everybody  i am  new ','receiver', 'yes')";
			
			if (mysqli_query($conn, $sql)) 
			{
				echo json_encode("Data Delete");
			}
			else
			{
				echo json_encode("Data Not Deleted");

			}
 		
 	}
 		
 }
 else
 {
 	echo "Nothing";
 }


 	

?>

