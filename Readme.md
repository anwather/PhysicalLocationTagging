# Physical Location Tagging.

This policy will add the physical location as a tag to a virtual machine. If the machine is built in a zone where availability zones are not present it will be tagged with "No Zone Available" (momdify in script.ps1)

## Pre-requisites

- A user assigned managed identity with Contributor rights (assigned at management group level) - this is used to create the deploymment scripts. There is also a custom role you can create to limit this identities privileges - https://learn.microsoft.com/en-us/azure/azure-resource-manager/templates/deployment-script-template#configure-the-minimum-permissions
- Subscriptions need the Microsoft.ContainerInstance resource provider registered.

## Deployment

- Create a new policy and add the contents of ```policyRule.json```
- Assign the policy to a testing scope
- Use a remediation task to fix any non-compliant resources
- New machines should automatically launch the remediation after 5-15 minutes and add the tag.

## Caveats

- Will only work in regions where Azure Container Instances is available. 