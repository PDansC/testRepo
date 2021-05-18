#!/bin/bash
#passwordCheck

error=0 #error flag
Message="" #final message
minLen=10 #minimum length for password
messageColor="\033[0;31m" #setting default color to red

if [ $1 ];then #checking if there are command line arguments
    password=$1
else
    echo "Note:password Length – minimum of 10 characters
Contain both alphabet and number 
Include both the small and capital case letters."
    echo "Input your password:"

    read password #storing password in variable
    echo "test"
fi

passwordLen=${#password} #storing password length in variable

if [ $passwordLen -lt $minLen ];then #checking password length
    error=1
    Message+="Password must be minimum of 10 characters \n"
fi

if ! [[ $password =~ [0-9] ]];then #checking if password contains a number
    error=1
    Message+="Password must contain atleast one number \n"
fi

if ! [[ $password =~ [a-z] ]] || ! [[ $password =~ [A-Z] ]];then #checking if password contains small and capital letters
    error=1
    Message+="Password must contain atleast one small and capital case letter \n"
fi

if [[ error -eq 0 ]];then #checking if there are no errors and changing message color
    Message="Password is secure"
    messageColor="\033[0;32m"
fi

echo -e $messageColor$Message #sending message to user
exit $error #returning exit code
#run script using ./passwordCheck.sh
