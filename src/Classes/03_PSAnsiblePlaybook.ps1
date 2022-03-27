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