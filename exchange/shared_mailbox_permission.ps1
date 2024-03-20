$mails = 'ouvidoria@rodobens.com.br','ouvidoriabanco@rodobens.com.br','ouvidoria@cnfconsorcio.com.br','ouvidoria@portobensconsorcio.com.br','ouvidoria_brqualy@brqualy.com.br'

$result = @()

foreach($mail in $mails){
    $users = Get-MailboxPermission -identity $mail | select user,accessrights
    foreach($user in $users){
        if($user -like "*\SELF*")
        {
    
        }
        else {
            $results = [PSCustomObject]@{
                Mailbox = $mail
                Email = $user.user
                Acesso = $user.accessrights
            }
            $result += $results
        }
    }

}

$result | Export-csv -path C:\temp\1917894.csv -NoTypeInformation