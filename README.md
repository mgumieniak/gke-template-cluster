Generate IAM for terraform in conosole. 
Downland keys in json format and put in known places. 
Set in input_variable.tfvars: 
**credentials_file_path = "(FILE_LOCATION)~/keys/terraform-ca.json"**

Apply changes:
`terraform apply -var-file="input_variable.tfvars"`


