#Generated at 03/27/2022 18:09:47 by Kevin Bates
Class PSAnsiblePlaybookParam {
    [String]$ParamName
    [String]$ParamValue
    [bool]$IsBool

    PSAnsiblePlaybookParam($ParamName,$ParamValue,$IsBool){
        $this.ParamName = $ParamName
        if(!$IsBool){
            $this.ParamValue = $ParamValue
        }
    }
}
Class PSAnsiblePlaybookRunResult {
    $RunResult

    PSAnsiblePlaybookRunResult($JSON){
        $obj = $JSON | convertfrom-json

        $ComputerList = ($obj.stats | gm | ?{$_.MemberType -eq "NoteProperty"}).Name
        $arr = @()

        Foreach($item in $ComputerList){

            $TaskArray = @()

            foreach($Task in $obj.plays.tasks){
                $TaskObj = [PSCustomObject]@{
                    TaskName= $Task.task.Name
                    TaskDetails= $Task.hosts.$item
                }
                $TaskArray += $TaskObj
            }

            $CustObj = [PSCustomObject]@{
                hostname= $item
                summary= $obj.stats.$item
                tasks = $TaskArray
            }
            $arr += $CustObj
        }

        $this.RunResult = $arr
    }

}
Class PSAnsiblePlaybook {
    [String]$Playbook
    [PSAnsiblePlaybookParam[]]$Param
    [String]$ExcecutionString
    [PSAnsiblePlaybookRunResult]$RunResult

    PSAnsiblePlaybook($Playbook){
        $this.Playbook = $Playbook
    }

    AddParam($ParamName,$ParamValue,$IsBool){
        $PSAnsibleParam = [PSAnsiblePlaybookParam]::new($ParamName,$ParamValue,$IsBool)
        $this.Param += $PSAnsibleParam
    }

    GenerateExcecutionString(){
        $PSAnsibleExcecutionString = "ansible-playbook $($this.Playbook)"

        Foreach($Param in $this.Param){
            if($Param.IsBool){
                $PSAnsibleExcecutionString = "$($PSAnsibleExcecutionString) $($Param.ParamName)"
            }else{
                $PSAnsibleExcecutionString = "$($PSAnsibleExcecutionString) $($Param.ParamName) $($Param.ParamValue)"
            }
        }

        $this.ExcecutionString = $PSAnsibleExcecutionString
    }

    InvokePSAnsiblePlaybook(){
        $Result = invoke-expression $this.ExcecutionString
        $PSAnsiblePlaybookRunResult = [PSAnsiblePlaybookRunResult]::new($Result)
        $this.RunResult = $PSAnsiblePlaybookRunResult
    }

}
function Set-PSAnsiblePlaybookParam {
    param(
        [String]$ParamName,
        [String]$ParamValue,
        [Switch]$IsBool
    )
}
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
