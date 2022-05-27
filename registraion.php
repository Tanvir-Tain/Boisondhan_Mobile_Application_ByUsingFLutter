<?php

 include "connect.php";
define('UPLOAD_DIR', 'images/');


$name = $_POST['name'];
$password = $_POST['password'];
$email = $_POST['email'];
$varsity = $_POST['varsity'];
$mobile = $_POST['mobile'];
$image = $_POST['image'];


$image = str_replace('data:image/png;base64,', '', $image);
$image = str_replace(' ', '+', $image);
$realImage = base64_decode($image);
$file = UPLOAD_DIR . uniqid() . '.png';
file_put_contents($file, $realImage);


$sql = "SELECT * FROM `user` WHERE username = '$name'";

$check = mysqli_fetch_array(mysqli_query($conn,$sql));

  if(isset($check)){
   header("Content-Type: application/json");
    
     // Successfully Login Message.
     $onLoginSuccess = 'Login Matched';
     
     // Converting the message into JSON format.
     $SuccessMSG = json_encode($onLoginSuccess);
     
     // Echo the message.
     echo $SuccessMSG ; 
   
   } else{
           header("Content-Type: application/json");

   		 $sql2 = "INSERT INTO `user`(`username`, `password`,`usermail`,`university`,`user_mobile`,`pro_pic`) VALUES ('$name','$password', '$email','$varsity' ,'$mobile','$file')";

            if (mysqli_query($conn, $sql2)) {
               // Successfully Login Message.
				     $reg = 'registered';
				     
				     // Converting the message into JSON format.
				     $SuccessMSGs = json_encode($reg);
				     
				     // Echo the message.
				     echo $SuccessMSGs ;
            }


   }



?>