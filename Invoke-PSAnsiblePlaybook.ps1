function Invoke-PSAnsiblePlaybook {                                                    
 
    param(
        $Playbook,
        $AdditionalParams
    )

    if(!$AdditionalParams){
        $json = invoke-expression "ansible-playbook $Playbook"
    }else{
        $json = invoke-expression ("ansible-playbook $Playbook" + " $AdditionalParams")
    }

    $obj = $json | convertfrom-json

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

    return $arr
}