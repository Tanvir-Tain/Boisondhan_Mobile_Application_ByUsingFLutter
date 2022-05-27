<?php
 include "connect.php";

 	$username = $_POST['name'];
 	$response = array();

 if ($conn) {
 	$fire = 'SELECT * FROM `book_post` JOIN `user` WHERE book_post.userID = user.user_id and username = "'.$username.'"';
 	$res = mysqli_query($conn,$fire);
 	if($res){
 		header("Content-Type: application/json");
 		$i = 0;
 		while($row = mysqli_fetch_assoc($res)){
 			$response[$i]['postID'] = $row['postID'];
 			$response[$i]['bookName'] = $row['bookName'];
 			$response[$i]['bookPhoto'] = $row['bookPhoto'];
 			$response[$i]['authorName'] = $row['authorName'];
 			$response[$i]['bookPrice'] = $row['bookPrice'];
 			$response[$i]['bookCond'] = $row['bookCond'];
 			$response[$i]['postCond'] = $row['postCond'];
 			$response[$i]['postDes'] = $row['postDes'];
 			$response[$i]['meetLoc'] = $row['meetLoc'];
 			$response[$i]['userID'] = $row['userID'];
 			$response[$i]['catID'] = $row['catID'];
 			$response[$i]['bookLang'] = $row['bookLang'];
 			$response[$i]['postCreated'] = $row['postCreated'];
 			$response[$i]['username'] = $row['username'];
 			$i++;
 		}
 		echo json_encode($response);
 	}
 }
 else{
 	echo "Nothing";
 }
 

?>


