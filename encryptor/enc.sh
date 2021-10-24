sops -e -i ../helm-values/values-postgres.yaml
sops -e -i ../data.tf
sops -e -i ../helms.tf
sops -e -i ../input_variable.tfvars
sops -e -i ../main.tf
sops -e -i ../network.tf
sops -e -i ../output.tf
sops -e -i ../provider.tf
sops -e -i ../variables.tf

