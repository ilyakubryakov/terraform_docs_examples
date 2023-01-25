variable "region" {
    type = string
    default = "eu-central"
}
variable "project" {
    type = string
}
variable "user" {
    type = string
}
variable "email" {
    type = string
}
variable "privatekeypath" {
    type = string
    default = "~/.ssh/github.prv"
}
variable "publickeypath" {
    type = string
    default = "~/.ssh/github.pub"
}