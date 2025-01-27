# Here we are defining the resource variables
variable "aws_cidr_block" {
  description = "The CIDR block for the VPC. So please define the CIDR block for the VPC. EX: 10.0.0.0/16 and 192.168.10.0/16"
  type        = number
  # default     = conditional(var.aws_cidr_block == " ", " ", var.aws_cidr_block) # Here we are defining the default value for the variable, so that it will ask for the value while running the code
  sensitive   = false                                                           # Here we are defining the variable as sensitive, so that it will not show the value while running the code, it will ask for the value and if we provide the value as  false then it will show the value while running the code
  nullable    = false                                                           # Here we are defining the variable as non-nullable as it is mandatory to provide the value, and if we provide to true then it will not ask for the value
  validation {
    condition     = contains(["10.0.0.0/16", "192.168.10.0/16"], var.aws_cidr_block) # Here we are defining the condition for the variable, so that it will validate the cidr block as per the condition
    error_message = "Please enter the valid CIDR block."                             # Here we are defining the error message, so that it will show the error message if the cidr block is not valid
  }
}
variable "aws_vpc_name" {
  description = "The name of the VPC. So please define the name for the VPC. EX: my-vpc"
  type        = string
  sensitive   = false # Here we are defining the variable as sensitive, so that it will not show the value while running the code, it will ask for the value and if we provide the value as  false then it will show the value while running the code
  nullable    = false # Here we are defining the variable as non-nullable as it is mandatory to provide the value, and if we provide to true then it will not ask for the value as it is mandatory to provide the value
  validation {
    condition     = length(var.aws_vpc_name) > 5       # Here we are defining the condition for the variable, so that it will validate the vpc name as per the condition
    error_message = "Please enter the valid VPC name." # Here we are defining the error message, so that it will show the error message if the vpc name is not valid
  }

}