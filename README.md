# psansible.playbook
PSAnsible is a list of modules to help powershell users pilot the ansible executables in a more "powershellesque" way.

Check out this [BLog Post](https://bateskevin.github.io/batesbase/Ansible/2022/03/29/Introducing-PSAnsible.Playbook.md/) for more details on the project.

## CI Status
| OS | Powershell Version | status |
| ----------- | ----------- | ----------- |
| Ubuntu | Powershell Core 7.2.2       | [![Build Status](https://dev.azure.com/KevinBates0726/PSAnsible.Playbook/_apis/build/status/bateskevin.psansible.playbook?branchName=main)](https://dev.azure.com/KevinBates0726/PSAnsible.Playbook/_build/latest?definitionId=2&branchName=main)       |
## Summary

Instead of text in a console, we can get objects back, which we then in turn can use further programmatically. 
This enables things like building reports based on Powershell objects from a CLI, easier debugging of playbook 
runs or even pester tests for ansible playbooks.

This module enables you to run an ansible playbook from within a Powershell Session/Script and continue your process with the result of the playbook run, whatever that may be.

## Documentation
| Topic      | link |
| ----------- | ----------- |
| How to set up the module       | [Docs How To setup](./Docs/HowToSetUpTheModule.MD)       |
| How to use the module   | [Docks how to use](./Docs/HowToUseTheModule.MD)        |
| Advanced sample usecases   | [Docs advanced usecases](./Docs/SampleUseCases.MD)        |
