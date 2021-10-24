sops -d -i ../helm-values/values-postgres.yaml
sops -d -i ../data.tf
sops -d -i ../helms.tf
sops -d -i ../input_variable.tfvars
sops -d -i ../main.tf
sops -d -i ../network.tf
sops -d -i ../output.tf
sops -d -i ../provider.tf
sops -d -i ../variables.tf

