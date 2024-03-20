
Function Test-ADAuthentication {
    Param(
        [Parameter(Mandatory)]
        [string]$User,
        [Parameter(Mandatory)]
        $Password,
        [Parameter(Mandatory = $false)]
        $Server,
        [Parameter(Mandatory = $false)]
        [string]$Domain = $Env:USERDOMAIN
        )
    
    Add-Type -AssemblyName System.DirectoryServices.AccountManagement
 
    $contextT = [System.DirectoryServices.AccountManagement.ContextType]::Domain
    $contextO = [System.DirectoryServices.AccountManagement.ContextOptions]::Negotiate
    
    $argumentList = New-Object -TypeName "System.Collections.ArrayList"
    $null = $argumentList.Add($contextT)
    $null = $argumentList.Add($Domain)
        If($null -ne $Server){
            $argumentList.Add($Server)
            }
    
    $principalC = New-Object System.DirectoryServices.AccountManagement.PrincipalContext -ArgumentList $argumentList -ErrorAction SilentlyContinue
    if($null -eq $principalC){
      return $false
    }
    if ($principalC.ValidateCredentials($User, $Password, $contextO)){
        return $true
    }
    else{
        return $false
    }
}
 
# # Carregar objetos para exibição de MsgBox
# Add-Type -AssemblyName PresentationFramework
# Add-Type -AssemblyName Microsoft.VisualBasic
 
# Uso da Função
Do{
    
    $Credential = Get-Credential -Message "Digite apenas o login e senha de usuário para validar no domínio atual:"
    $User = $Credential | Select Username -ExpandProperty Username
    $Pass = $Credential.GetNetworkCredential() | Select Password -ExpandProperty Password
    
    $Domain = "rodobens.net"
    
    
    $Validar = Test-ADAuthentication -User $User -Password $Pass -Domain $Domain
 
    If($Validar -eq $false){
        Write-Host("ERRO: As credenciais para o usuário "+$User+" estão incorretas! Favor digitar novamente.");
        }
        Else{
            Write-Host("SUCESSO: As credenciais para o usuário  "+$User+" estão corretas!");
        }
}While($Validar -ne $true)