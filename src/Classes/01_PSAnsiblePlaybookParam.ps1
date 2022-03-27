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