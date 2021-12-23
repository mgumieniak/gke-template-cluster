# Install cluster GKE on your own

## How to run?

1. Generate IAM for terraform in GKE console. 
2. Downland created key in json format and put in known places. 
3. Set key location in **input_variable.tfvars** under value:
**credentials_file_path** etc. credentials_file_path="~/keys/terraform-ca.json"

Apply changes:
`terraform apply -var-file="input_variable.tfvars"`

## How to connect?
Use output from terraform to connect cluster.


#### Example terraform output:
gcloud container clusters get-credentials my-owncloud --zone us-central1-c --project oval-replica-xxx



Get all contexts:
`kubectl config get-contexts`

Use given context:
`kubectl config use-context CONTEXT_NAME`

Delete unused context: 
`kubectl config delete-context CONTEXT_NAME`

## Protect Sensitive data
In case working with sensitive data use sops: https://github.com/mozilla/sops


---

**Project based on:** https://github.com/Neutrollized/free-tier-gke

---