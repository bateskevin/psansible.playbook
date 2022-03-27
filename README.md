# psansible.playbook
PSAnsible is a list of modules to help powershell users pilot the ansible executables in a more "powershellesque" way.

This means, for example, instead of <ANSIBLE OUTPUTFORMAT NAME> in a console, we can get object back, which we then in turn
can use further programmatically. This enables things like building reports based on Powershell objects from a CLI, easier debugging
of playbook runs or even pester tests for ansible playbooks.

This module basically enables you to run an ansible playbook from within a Powershell Session/Script and continue your process with the 
result of the playbook run, whatever that may be.

