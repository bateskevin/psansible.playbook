# Importing Module
Import-Module $PSScriptRoot\..\PSAnsible.Playbook\psansible.playbook.psd1 -Force

Describe "[PSAnsiblePlaybook][Function][Invoke-PSAnsiblePlaybook][Basefunctionality]" {
    It "should be true" {
        $res = invoke-PSAnsiblePlaybook -Playbook /etc/ansible/ps.yml -i /etc/ansible/hosts
        $res.playbook | should -be "/etc/ansible/ps.yml"
    }
}
