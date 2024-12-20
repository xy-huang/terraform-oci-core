variable "terraform_version" {
  description = "terraform version, run source ./pre_init.sh in shell before running terraform"
  default     = "undefined"
}
variable "region" {
  description = "name of region"
}
variable "compartment_id" {
  description = "ocid of the compartment"
}
variable "domain" {
  description = "value of domain"
  default     = "Automation"
}
variable "group" {
  description = "value of group"
  default     = "Command_Line_Interface_Operators"
}
variable "user_name" {
  description = "value of user"
  default     = "terraform"
}
variable "user_email" {
  description = "value of user email"
}
variable "user_recovery_email" {
  description = "value of user recovery email"
}
variable "excluding_bucket" {
  description = "value of excluding bucket"
}
