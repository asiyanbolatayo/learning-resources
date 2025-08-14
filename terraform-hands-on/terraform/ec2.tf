resource "aws_instance" "web_server" {
  ami           = "ami-123456789"
  instance_type = "t2.micro"
}

module "main_vpc {
    source = "terrafor/vpc"
    version = "1.0.0"
    vpc_name = "main_vpc"
    cidr_block = "244.178.44.111/16"
}

module "new_product" {
    source = "./webisite"
    new_product = "example_product"
}

module "new_product" {
    source = "./webisite"
    new_product = "example_product"
}

module "new_product" {
    source = "./webisite"
    new_product = "example_product"
}

resource "type" "name" {
  buckent_name = module.new_product.bucket_name
}