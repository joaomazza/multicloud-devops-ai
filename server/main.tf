# Configuração do provedor AWS
provider "aws" {
  region = "us-east-1"
}

# Criar uma instância EC2
resource "aws_instance" "workstation" {
  ami           = "ami-0c55b159cbfafe1f0" # AMI Amazon Linux (verifique na sua região)
  instance_type = "t2.micro"

  tags = {
    Name = "Servidor-Terraform"
  }
}