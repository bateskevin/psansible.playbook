# Basic Usage of PSAnsible.Playbook

PSAnsible.Playbook enables you to run ansible playbooks from within a powershell session. It wraps
the "ansible-playbook" excecutable in to powershell functions, which you can call and you will get
Objects back as return values as we are used to using powershell.

# Setting up a testcase

## Prerequisites

First of all you should follow the [Setup Guide](./HowToSetUpTheModule.MD). 

## Setup an ansible test environment

Ansible needs a few things in place in order for you to run your first playbook.

We need:

- an Inventory
- hosts to fill your inventory
- a playbook

### Setup your test inventory

Ansible usually provides you with a first inventory file at /etc/ansible/hosts. In our example
we are going to use this file. You can create a different one at any location if you like.

### Fill up your inventory with hosts

Now that you have created your inventory file you will need to add some hosts for your playbook
to eventually target. Set the following as content for your inventory file that you have created:

```yml
---
win:
  hosts:
    host1:
      ansible_host: localhost
    host2:
      ansible_host: localhost 
    host3:
      ansible_host: localhost
    host4:
      ansible_host: localhost
```

*PROTIP:* If you have no lab environment to excecute ansible against you can add "ansible_host: localhost"
to each host as shown above. This will let ansible think you target multiple hosts in your inventory, where
ansible will execute all actions on localhost. 

## Create your Playbook

Create a yml file and set its content to this:

```yml
---
  - name: PSTest
    hosts: win
    connection: local
    gather_facts: no
 
    tasks:
    - name: This is a debug message
      debug:
        msg: I am a debug message
```

# Running your testcase

In order to run your testcase run the following steps:

## Import the module

Import the module, either point it to the PSD1 if you cloned the repo:

```powershell
Import-Module /<PathToRepo>/psansible.playbook.psd1 -force
```

or if you installed the module from the gallery

```powershell
Import-Module psansible.playbook -force
```

## Run Invoke-PSAnsiblePlaybook

Now you are ready to run your first playbook. Excecute the following command:

```powershell
$result = invoke-PSAnsiblePlaybook -Playbook /etc/ansible/ps.yml -i /etc/ansible/hosts
```

in $result you will get back an object that contains the information about what you ran at its root,
as well as the information on the ansible playbook run in the "RunResult" property.

```powershell
Playbook            Param ExcecutionString                                           RunResult
--------            ----- ----------------                                           ---------
/etc/ansible/ps.yml {-i}  ansible-playbook /etc/ansible/ps.yml -i /etc/ansible/hosts PSAnsiblePlaybookRunResult
```

If you look in to "RunResult" you will find a summary for every task in the playbook for every host in your inventory:

```powershell
> $result.RunResult.RunResult

hostname summary                                                                        tasks
-------- -------                                                                        -----
host1     @{changed=0; failures=0; ignored=0; ok=1; rescued=0; skipped=0; unreachable=0} {@{TaskName=This is a debug message; TaskDetails=}}
host2     @{changed=0; failures=0; ignored=0; ok=1; rescued=0; skipped=0; unreachable=0} {@{TaskName=This is a debug message; TaskDetails=}}
host3     @{changed=0; failures=0; ignored=0; ok=1; rescued=0; skipped=0; unreachable=0} {@{TaskName=This is a debug message; TaskDetails=}}
host4     @{changed=0; failures=0; ignored=0; ok=1; rescued=0; skipped=0; unreachable=0} {@{TaskName=This is a debug message; TaskDetails=}}

```