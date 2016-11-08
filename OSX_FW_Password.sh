#!/usr/bin/expect
# 

spawn firmwarepasswd -check
expect {
    "Password Enabled: No" {
         spawn firmwarepasswd -setpasswd
         expect "Enter new password:"
         send "YourNewPassword\r";
         expect "Re-enter new password:"
         send "YourNewPassword\r";
         expect eof
    }
    "Password Enabled: Yes" { #if password is set - check whether this is a known password
   spawn firmwarepasswd -verify
   expect "Enter password:"
   send "CurrentPassword\r"
   expect {
      "Correct" {
         #puts "Correct password identified"
         #######
         #  use this part to change a known password
         #spawn firmwarepasswd -setpasswd
         #expect "Enter password:"
         #send "YourCurrentPassword\r";
         #expect "Enter new password:"
         #send "YourNewPassword\r";
         #expect "Re-enter new password:"
         #send "YourNewPasswordd1\r";
         ########
       expect eof
       }
      "Incorrect" {
        # puts "Password incorrect"
         exit 1
            }      
    }   
    }
    }
exit 0
