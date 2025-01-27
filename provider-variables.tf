# THis is a provider variable file, where we define the variables for the provider
# were if will ask for the region name while running the code and it will validate the region name as per the condition.
# Compare this snippet from EC2-Instance-WITH-LB/provider-var.tf:
# # Here we are defining the variables for the provider
# # were if will ask for the region name while running the code and it will validate the region name as per the condition.
variable "region" {
  type        = string                             # Here we are defining the type of the variable as string or number or boolean
  description = "The region name for the provider" # Here we are defining the description of the variable
  nullable    = false                              # Here we are defining the variable as non-nullable as it is mandatory to provide the value, and if we provide to true then it will not ask for the value
  sensitive   = true                               # Here we are defining the variable as sensitive, so that it will not show the value while running the code, it will ask for the value and if we provide the value as  false then it will show the value while running the code
  validation {
    condition     = contains(["us-west-2", "us-east-1", "eu-west-1", "ap-south-1", "ap-northeast-1", "ap-southeast-1"], var.region) # Here we are defining the condition for the variable, so that it will validate the region name as per the condition
    error_message = "Please enter the valid region name."                                                                           # Here we are defining the error message, so that it will show the error message if the region name is not valid
  }
}
output "region" {
  value = var.region
    sensitive = true
}