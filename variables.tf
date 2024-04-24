variable "cidrs" {
  default = [22, 8080, 8888, 9999, 7777, 4444, 5555, 6666, 1111, 2222, 3333]
}
variable "ami" {
  default = "ami-0cd59ecaf368e5ccf"
}
variable "instance-type" {
  default = "t2.micro"
}