<?php 
  include "connect.php";
  // REGISTER USER
       $name = $_POST['name'];
  
       $fire = "SELECT * FROM `user` WHERE username = '$name' ";
         $res = mysqli_query($conn,$fire);
         if($res){
            header("Content-Type: application/json");
            while($row = mysqli_fetch_assoc($res)){
               $response['user_id'] = $row['user_id'];
               
            }
            $ID = $response['user_id'];

            $sql2 = "INSERT INTO `message` ('mID',`senderID`, `recvID`, `msg`, `msgType`, `connected`, `timez`) VALUES ('203','$ID', '1', 'what', 'sender', 'yes', '2021-07-17')";

                 $results = mysqli_query($connect, $sql2);
      if($results>0)
      {
          echo "user added successfully";
      }
          }          }
  

  

      
      
      ?>