#Load the AD module
Import-Module ActiveDirectory

# Get a list of computers whose computer names start with CO- (Or whatever property you need to search for)
$Computers = Get-ADComputer -Filter "Name -like 'CO-*'" | ForEach-Object {$_.Name}

cls

workflow Test-WFConnection {
    param($Computers)

    foreach -parallel ($Computer in $Computers){
 
        #write-Host "Testing Computer $Computer" #Fails- write-Host Not allowed inside Workflow
 
        if (Test-Connection -ComputerName $Computer -Quiet) {
            $Computer + "  - Online!"
            }
        else {
            $Computer + "  - Off"
            }
        }
    }

Test-WFConnection -Computers $Computers

write-Host $Computers
