<?php

include "connect.php";

 	$username =$_POST['name'];
 	$postID =$_POST['postID'];

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

	 		$sql = 'DELETE FROM book_post WHERE userID= "'.$response.'" and `postID`="'.$postID.'"';
			
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

