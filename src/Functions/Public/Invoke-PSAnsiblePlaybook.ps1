function Invoke-PSAnsiblePlaybook {                                                    
 
    param(
        [String]$Playbook,
        [switch]$AskVaultPass
    )

    # Create Instance of PSAnsiblePlaybook
    $PSAnsiblePlaybook = [PSAnsiblePlaybook]::new($Playbook)

    # Set Parameters
    if($AskVaultPass){
        $PSAnsiblePlaybook.AddParam("--ask-vault-pass","",$true)
    }
     
    # Generate ExcecutionString
    $PSAnsiblePlaybook.GenerateExcecutionString()

    # Trigger Playbook Run
    $PSAnsiblePlaybook.InvokePSAnsiblePlaybook()

    # Return whole Object as a result
    return $PSAnsiblePlaybook
}