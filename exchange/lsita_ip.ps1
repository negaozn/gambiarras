 $creds = Get-Credential
         $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://rodsrr01mail01.rodobens.net/PowerShell/ -Authentication Kerberos -Credential $creds
         Import-PSSession $Session

# Substitua "NomeDoConector" pelo nome real do conector
$Conector = Get-ReceiveConnector "RODSRR01MAIL02\Relay RODSRR01MAIL02"

# Criar um array vazio para armazenar os IPs permitidos
$IPsPermitidos = @()

# Loop através dos intervalos de IP e adicioná-los ao array
foreach ($IPRange in $Conector.RemoteIPRanges) {
    foreach ($IPAddress in $IPRange) {
        $IPsPermitidos += $IPAddress
    }
}

# Exportar o array para um arquivo CSV
$IPsPermitidos.ToString() #| Export-Csv -Path "C:\temp\CONECTORESIP.csv" -NoTypeInformation