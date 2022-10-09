# What is Terraform?

Terraform is an infrastructure as code (IaC) tool that allows you to build, change, and version infrastructure safely and efficiently.

---

## About the Terraform Language

The main purpose of the Terraform language is declaring resources, which represent infrastructure objects. All other language features exist only to make the definition of resources more flexible and convenient.
The syntax of the Terraform language consists of only a few basic elements:


1. Blocks are containers for other content and usually represent the configuration of some kind of object, like a resource. Blocks have a block type, can have zero or more labels, and have a body that contains any number of arguments and nested blocks. Most of Terraform's features are controlled by top-level blocks in a configuration file.

1. Arguments assign a value to a name. They appear within blocks.

1. Expressions represent a value, either literally or by referencing and combining other values. They appear as values for arguments, or within other expressions.

The **Terraform language is declarative**, describing an intended goal rather than the steps to reach that goal. 

---

### Terraform CLI Documentation
### Initializing working directories
### Command init 
The terraform init command initializes a working directory containing Terraform configuration files. **This is the first command that should be run after writing a new Terraform configuration or cloning an existing one from version control.** It is safe to run this command multiple times.

**Usage**
Usage: **terraform init**  [options]

#### Backend Initialization

During init, the root configuration directory is consulted for backend configuration and the chosen backend is initialized using the given configuration settings.


The **-migrate-state** option will attempt to copy existing state to the new backend, and depending on what changed, may result in interactive prompts to confirm migration of workspace states.

The **-reconfigure option** disregards any existing configuration, preventing migration of any existing state.

---
### Command: get
The terraform get command is used to download and update modules mentioned in the root module.

**Usage**
Usage: 
```tf
terraform get** [options] PATH
```

The modules are downloaded into a .terraform subdirectory of the current working directory. **Don't commit this directory to your version control repository.**

---

### Provisioning infrastructure

### Command: plan
The terraform plan command creates an execution plan, **which lets you preview the changes that Terraform plans to make to your infrastructure.** By default, when Terraform creates a plan it:

1. Reads the current state of any already-existing remote objects to make sure that the Terraform state is up-to-date.
1. Compares the current configuration to the prior state and noting any differences.
1. Proposes a set of change actions that should, if applied, make the remote objects match the configuration.


**Usage**
Usage: 
```tf
terraform plan [options]
```

The plan subcommand looks in the current working directory for the root module configuration.

#### Planning Modes
1. Destroy mode: creates a plan whose goal is to destroy all remote objects that currently exist, leaving an empty Terraform state. It is the same as running terraform destroy. Destroy mode can be useful for situations like transient development environments, where the managed objects cease to be useful once the development task is complete.Activate destroy mode using the -destroy command line option.

1. Refresh-only mode: creates a plan whose goal is only to update the Terraform state and any root module output values to match changes made to remote objects outside of Terraform. This can be useful if you've intentionally changed one or more remote objects outside of the usual workflow (e.g. while responding to an incident) and you now need to reconcile Terraform's records with those changes.

---
### Command: Apply
**Usage**

Usage: 
```tf
terraform apply [options] [plan file]
```

**Automatic Plan Mode**
When you run terraform apply without passing a saved plan file, **Terraform automatically creates a new execution plan as if you had run terraform plan**, prompts you to approve that plan, and takes the indicated actions. You can use all of the planning modes and planning options to customize how Terraform will create the plan.

**You can pass the -auto-approve option to instruct Terraform to apply the plan without asking for confirmation.**

---

### Command: destroy
The terraform destroy command is a convenient way to destroy all remote objects managed by a particular Terraform configuration.

Usage
Usage: 

```tf
terraform destroy [options]
```
This command is just a convenience alias for the following command:
```tf
terraform apply -destroy
```

You can also create a speculative destroy plan, to see what the effect of destroying would be, by running the following command:

```tf
terraform plan -destroy
```

---
## Inspecting infrastructure
### Command: output
The terraform output command is used to extract the value of an output variable from the state file.

---

### Command: show
The terraform show command is used to provide human-readable output from a state or plan file. This can be used to inspect a plan to ensure that the planned operations are expected, or to inspect the current state as Terraform sees it.

Machine-readable output is generated by adding the -json command-line flag.

---
### Manipulating state

### Command: state list
The terraform state list command is used to list resources within a Terraform state.
**Usage:** 
```tf
terraform state list [options] [address...]
```
The command will list all resources in the state file matching the given addresses (if any). If no addresses are given, all resources are listed.

The resources listed are sorted according to module depth order followed by alphabetical. This means that resources that are in your immediate configuration are listed first, and resources that are more deeply nested within modules are listed last.

filtering: all resources
```tf
terraform state list
```
filtering by resource 

```tf
terraform state list aws_instance.bar
```
filtering by module
```tf
terraform state list module.elb
```
---

### Command: state show
The terraform state show command is used to show the attributes of a single resource in the Terraform state.

```tf
terraform state show [options] ADDRESS
```
The command will show the attributes of a single resource in the state file that matches the given address.

for example:
```tf
terraform state show 'packet_device.worker'
# packet_device.worker:
resource "packet_device" "worker" {
    billing_cycle = "hourly"
    created       = "2015-12-17T00:06:56Z"
    facility      = "ewr1"
    hostname      = "prod-xyz01"
    id            = "6015bg2b-b8c4-4925-aad2-f0671d5d3b13"
    locked        = false
}
```
---
### Command: import

The terraform import command imports existing resources into Terraform.

Usage: 
```tf
terraform import [options] ADDRESS ID
```
For example this resource group its imported within terraform configuration. 

terraform import azurerm_resource_group.example /subscriptions/c4774376-bc4c-48e6-93eb-c0ac26c6345d/resourceGroups/nelly-hernandez

---

### State Command
The terraform state command is used for advanced state management. As your Terraform usage becomes more advanced, there are some cases where you may need to modify the Terraform state. Rather than modify the state directly, the terraform state commands can be used in many cases instead.

### Command: state mv
The main function of Terraform state is to track the bindings between resource instance addresses in your configuration and the remote objects they represent. Normally Terraform automatically updates the state in response to actions taken when applying a plan, such as removing a binding for an remote object that has now been deleted.

You can use terraform state mv in the less common situation where you wish to retain an existing remote object but track it as a different resource instance address in Terraform, such as if you have renamed a resource block or you have moved it into a different module in your configuration.


Usage: 
```tf
terraform state mv [options] SOURCE DESTINATION
```

Terraform will look in the current state for a resource instance, resource, or module that matches the given address, and if successful it will move the remote objects currently associated with the source to be tracked instead by the destination.