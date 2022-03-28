# Setup Guide for PSAnsible.Playbook

There are 3 main prerequisites before you can use this module.

1. Install the Module
2. Install Ansible on your System
3. Change your ansible.cfg file to output json

## Install the Module

For now clone this repo and import the module like following:

```
Set-Location <ClonedRepoRoot>
Import-Module ./psansible.playbook/psansible.playbook.psd1
```

In the future this module will be available from the gallery, which in turn means
you can install it using the following command:

```
Install-Module psansible.playbook
```

## Install Ansible on your System

In order for this module to work ansible itself needs to be installed. This means
this module is only compatible with systems where ansible can be installed (aka linux).
In order to install ansible please follow the official documentation for your system: [Ansible Installation Docs](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

## Configure ansible.cfg

Last but not least you will need to add an entry to your ansible config file. This entry makes sure ansible spits out json and not "nicely formatted" text. This is a crucial change, since the logic of this module banks on the fact
that it gets a json object back out of an ansible run.

### Where is this file located?

in order to find out where this file is run:

```
ansible --version
```

on the second line of the output you will find the path to your file:
```
ansible [core 2.12.2]
  config file = /etc/ansible/ansible.cfg
```
The example shown is the default location for this file.

### setting stdout_callback

In the ansible.cfg file you will find a number of settings you can configure. There is a section in this file marked
as "[defaults]". In this section define "stdout_callback" and set it to "json" like so:

```ini
[defaults]
stdout_callback = json
```