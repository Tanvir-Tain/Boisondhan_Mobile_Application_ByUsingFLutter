<?php
include "connect.php";

$name = $_POST['name'];
$password = $_POST['password'];

$sql = "SELECT * FROM `user` WHERE username = '$name' ";

$check = mysqli_fetch_array(mysqli_query($conn,$sql));

  if(isset($check)){
    
     // Successfully Login Message.
     $response = 'Login Matched';
 	echo json_encode($response);
 	}
 	else{
   	 // Successfully Login Message.
     $onLoginNotSuccess = 'Invalid Username/Password';
     
     // Converting the message into JSON format.
     $SuccessMSG = json_encode($onLoginNotSuccess);
     
     // Echo the message.
     echo $SuccessMSG ; 
   
   }
?>