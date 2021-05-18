This repository contains three scripts
two powershell scripts and one bash script

Bash Script:
The bash script checks the input from the user and validates it according to:
Length – minimum of 10 characters.
Contain both alphabet and number.
Include both the small and capital case letters.
for example ./passwordcheck.sh 9Secure!Passwords#
it returns 0 if its valid and 1 if there are errors.
you can either pass the password as a commandline argument or when opening the script it will prompt you to enter the password.

Powershell Scripts:
One script is simply creating a notepad containing "Helloworld" and then opening said notepad
The other script is for taking a script and adding it as a schedueled task for a certain amount of time then it stops it
inorder to use that script you need to call the script and pass :task name , script path , wait time
for example: ./taskCreator.ps1 NotepadOpener C:\folder1\folder2\notepadScript.ps1 210
*note* inorder to run these scripts you need to enable script execution policy
