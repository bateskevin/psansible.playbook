# Importing Module
Import-Module $PSScriptRoot\..\psansible.playbook\psansible.playbook.psd1 -Force

Describe "Testing Parameter" {
    BeforeAll {
        # Run Ansible Playbook
        $res = invoke-PSAnsiblePlaybook -Playbook /etc/ansible/ps.yml -i /etc/ansible/hosts
    }
    
    It "[PSAnsiblePlaybook][Function][Invoke-PSAnsiblePlaybook][Parameter] Playbook" {
        $res.playbook | should -be "/etc/ansible/ps.yml"
    }
    
    It "[PSAnsiblePlaybook][Function][Invoke-PSAnsiblePlaybook][Parameter] ParamName" {
        $res.param.ParamName | should -be "-i"
    }
    
    It "[PSAnsiblePlaybook][Function][Invoke-PSAnsiblePlaybook][Parameter] ParamValue" {
        $res.param.ParamValue | should -be "/etc/ansible/hosts"
    }
    
    It "[PSAnsiblePlaybook][Function][Invoke-PSAnsiblePlaybook][Parameter] IsBool" {
        $res.param.IsBool | should -be $false
    }
    
    It "[PSAnsiblePlaybook][Function][Invoke-PSAnsiblePlaybook][Parameter] ExcecutionString" {
        $res.param.ExcecutionString | should -be "ansible-playbook /etc/ansible/ps.yml -i /etc/ansible/hosts"
    }
}
