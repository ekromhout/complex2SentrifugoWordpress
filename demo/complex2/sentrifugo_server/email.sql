root@a6cf7d197dd3:/var/www/html/sentrifugo/install.old# grep -i update  step3.php 
                $query = "update main_users set emailaddress = '".$email."' where id = ".SUPERADMIN." and emprole = ".SUPERADMINROLE;
root@a6cf7d197dd3:/var/www/html/sentrifugo/install.old# grep -i insert step4.php 
            insert_into_db($tls,$smtpserver,$username,$password,$port,$auth);
function insert_into_db($tls,$smtpserver,$username,$password,$port,$auth)
        $query1 = "INSERT INTO main_mail_settings (tls,auth, port,username,password,server_name,createddate,modifieddate) VALUES ('".$tls."','".$auth." ',".$port.",'".$username."','".$password."','".$smtpserver."','".$date."','".$date."') ";
}//end of insert_into_db function.
root@a6cf7d197dd3:/var/www/html/sentrifugo/install.old# grep -i update  step4.php 
        $query1 = "UPDATE main_mail_settings SET tls='".$tls."', port=".$port.", auth='".$auth."', username='".$username."', password='".$password."', server_name='".$smtpserver."', createddate='".$date."', modifieddate='".$date."' ";

