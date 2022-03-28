# psansible.playbook
PSAnsible is a list of modules to help powershell users pilot the ansible executables in a more "powershellesque" way.

## CI Status
| OS | Powershell Version | status |
| ----------- | ----------- | ----------- |
| CentOS | Powershell Core 7.2.2       | [![Build Status](https://dev.azure.com/KevinBates0726/PSAnsible.Playbook/_apis/build/status/bateskevin.psansible.playbook?branchName=main)](https://dev.azure.com/KevinBates0726/PSAnsible.Playbook/_build/latest?definitionId=2&branchName=main)       |
## Summary

This means, for example, instead of <ANSIBLE OUTPUTFORMAT NAME> in a console, we can get object back, 
which we then in turn can use further programmatically. This enables things like building reports 
based on Powershell objects from a CLI, easier debugging of playbook runs or even pester tests for ansible playbooks.

This module basically enables you to run an ansible playbook from within a Powershell Session/Script and continue your process with the result of the playbook run, whatever that may be.

## Documentation (TODO)
| Topic      | link |
| ----------- | ----------- |
| How to set up the module       | [Docs How To setup](./Docs/HowToSetUpTheModule.MD)       |
| How to use the module   | [Docks how to use](./Docs/HowToUseTheModule.MD)        |
| Advanced sample usecases   | [Docs advanced usecases](./Docs/SampleUseCases.MD)        |

## Quick Guide

### Prerequisites

You have to excecute this code on a system where ansible is installed. Also you will have to include the following snippet
in your ansible.cfg file:

```ini
[defaults]
stdout_callback = json
```

### run a playbook

In my example I use the following inventory file:

```yml
---
win:
  hosts:
    waap:
      ansible_host: localhost
    woop:
      ansible_host: localhost 
    weep:
      ansible_host: localhost
    wuup:
      ansible_host: localhost
```

Create a playbook in my case I used "ps.yml" with some dummy echo tasks and then call the module:

```
invoke-PSAnsiblePlaybook -Playbook /etc/ansible/ps.yml -i /etc/ansible/hosts
```

The output you will get is a structured object where you will have the information on what ran exactly, 
and what you had as a result. 

```
Playbook            Param ExcecutionString                                           RunResult
--------            ----- ----------------                                           ---------
/etc/ansible/ps.yml {-i}  ansible-playbook /etc/ansible/ps.yml -i /etc/ansible/hosts PSAnsiblePlaybookRunResult
```

You will find the playbook you executed, the parameters you attached with their values, the whole excecution string 
(call of ansible excecutable) and also in the "RunResult" property you will have a detailed summary of the playbook 
run for all the hosts in your inventory.

```
hostname summary                                                                        tasks
-------- -------                                                                        -----
waap     @{changed=0; failures=0; ignored=0; ok=8; rescued=0; skipped=0; unreachable=0} {@{TaskName=Gathering Facts; TaskDetails=}, @{TaskName=First Echo of the day; TaskDetails=}, @{TaskName=I like trains; TaskDetails=}…
weep     @{changed=0; failures=0; ignored=0; ok=8; rescued=0; skipped=0; unreachable=0} {@{TaskName=Gathering Facts; TaskDetails=}, @{TaskName=First Echo of the day; TaskDetails=}, @{TaskName=I like trains; TaskDetails=}…
woop     @{changed=0; failures=0; ignored=0; ok=8; rescued=0; skipped=0; unreachable=0} {@{TaskName=Gathering Facts; TaskDetails=}, @{TaskName=First Echo of the day; TaskDetails=}, @{TaskName=I like trains; TaskDetails=}…
wuup     @{changed=0; failures=0; ignored=0; ok=8; rescued=0; skipped=0; unreachable=0} {@{TaskName=Gathering Facts; TaskDetails=}, @{TaskName=First Echo of the day; TaskDetails=}, @{TaskName=I like trains; TaskDetails=}…

```
