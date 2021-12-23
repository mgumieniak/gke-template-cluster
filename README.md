Generate IAM for terraform in conosole. 
Downland keys in json format and put in known places. 
Set in input_variable.tfvars: 
**credentials_file_path = "(FILE_LOCATION)~/keys/terraform-ca.json"**

Apply changes:
`terraform apply -var-file="input_variable.tfvars"`


---
Example terraform output:
connect_to_zonal_cluster = "gcloud container clusters get-credentials my-owncloud --zone us-central1-c --project oval-replica-xxx"

Get all contexts:
`kubectl config get-contexts`

Use given context:
`kubectl config use-context CONTEXT_NAME`

Delete context: 
`kubectl config delete-context CONTEXT_NAME`


