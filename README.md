# psansible.playbook
PSAnsible is a list of modules to help powershell users pilot the ansible executables in a more "powershellesque" way.

This means, for example, instead of <ANSIBLE OUTPUTFORMAT NAME> in a console, we can get object back, 
which we then in turn can use further programmatically. This enables things like building reports 
based on Powershell objects from a CLI, easier debugging of playbook runs or even pester tests for ansible playbooks.

This module basically enables you to run an ansible playbook from within a Powershell Session/Script and continue your process with the result of the playbook run, whatever that may be.

## Example Usage

### Prerequisites

You have to excecute this code on a system where ansible is installed. Also you will have to include the following snippet
in your ansible.cfg file:

```
[defaults]
stdout_callback = json
```

### run a playbook

In my example I use the following inventory file:

```
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
invoke-PSAnsiblePlaybook -Playbook /etc/ansible/ps.yml
```