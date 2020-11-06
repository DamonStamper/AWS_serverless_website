init: initial

initial:
	terraform init
	echo "ensure that login information is set. For more information on why see  https://registry.terraform.io/providers/hashicorp/aws/latest/docs#authentication \n Use either 'AWS_ACCESS_KEY_ID' and 'AWS_SECRET_ACCESS_KEY environment variables or https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-credentials-file "

plan:
	terraform plan -var-file=vars.tfvar -out plan.tfplan

apply:
	terraform apply plan.tfplan