### 📌 **README.md**  

```md
# 🚀 Multicloud DevOps + IA - Criando Infraestrutura com Terraform  

![Terraform](https://img.shields.io/badge/Terraform-623CE4?style=for-the-badge&logo=terraform&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Kubernetes](https://img.shields.io/badge/Kubernetes-326CE5?style=for-the-badge&logo=kubernetes&logoColor=white)

Este repositório contém o projeto **CloudMart**, onde utilizamos **Terraform** para provisionar infraestrutura na **AWS**, focando em **Multicloud, DevOps e IA**.

---

## 📂 Estrutura do Projeto

```
📦 MULTICLOUD-DEVOPS-AI
├── 📂 challenge-day2
│   ├── 📂 backend                 # Código e Dockerfile do backend
│   ├── 📂 frontend                # Código e Dockerfile do frontend
│
├── 📂 database                    # Infraestrutura do DynamoDB
│   ├── .terraform/                # Arquivos do Terraform
│   ├── .terraform.lock.hcl
│   ├── terraform.tfstate
│   ├── main.tf                     # Código Terraform para criar o DynamoDB
│
├── 📂 server                      # Infraestrutura da EC2
│   ├── main.tf                     # Código Terraform para criar EC2
│   ├── README.md                    # Documentação do projeto
```

---

## 📌 O que foi feito?

✅ Instalamos e configuramos **AWS CLI** e **Terraform**  
✅ Criamos um **DynamoDB** via código Terraform  
✅ Provisionamos uma **instância EC2** com Terraform  
✅ Instalamos e configuramos **Docker** na EC2  
✅ Criamos **containers Docker** para backend e frontend  
✅ Configuramos **regras de segurança** para acesso remoto  

---

## 🛠️ **Pré-requisitos**
Antes de começar, você precisa ter instalado:

- **[Terraform](https://developer.hashicorp.com/terraform/downloads)**
- **[AWS CLI](https://aws.amazon.com/cli/)**
- Uma conta **AWS** configurada

---

## 🚀 **Instalação**

### **1️⃣ Instalando o AWS CLI**
📌 No **Ubuntu/Debian**, execute:
```sh
sudo apt install awscli -y
```
📌 No **MacOS**, use:
```sh
brew install awscli
```
📌 No **Windows**, baixe o instalador [aqui](https://awscli.amazonaws.com/AWSCLIV2.msi).

Verifique a instalação:
```sh
aws --version
```

### **2️⃣ Configurando Credenciais da AWS**
```sh
aws configure
```
Informe:
- **AWS Access Key ID**: 🔑 Sua chave de acesso
- **AWS Secret Access Key**: 🔒 Chave secreta
- **Região Padrão**: Ex: `us-east-1`
- **Formato de saída**: Pode ser `json`

Para testar:
```sh
aws s3 ls
```

### **3️⃣ Instalando o Terraform**
📌 No **Ubuntu/Debian**:
```sh
sudo apt update && sudo apt install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform -y
```

📌 No **MacOS**:
```sh
brew tap hashicorp/tap
brew install hashicorp/tap/terraform
```

📌 No **Windows**, baixe [aqui](https://developer.hashicorp.com/terraform/downloads).

Verifique:
```sh
terraform -v
```

---

## ⚙️ **Provisionando Infraestrutura com Terraform**
### **Criar as Tabelas DynamoDB**
```sh
cd database
terraform init
terraform apply -auto-approve
```

### **Criar a Instância EC2**
```sh
cd ../server
terraform init
terraform apply -auto-approve
```

### **Obter o IP da EC2**
```sh
aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output text
```

---

## **2️⃣ Configurar a Instância EC2**
Acesse via SSH:
```sh
ssh -i chave-ssh.pem ec2-user@<IP-PUBLICO-EC2>
```

Instale o Docker:
```sh
sudo yum update -y
sudo yum install docker -y
sudo systemctl enable --now docker
docker --version
```

---

## **3️⃣ Criar as Imagens Docker do CloudMart**
### **Backend**
```sh
cd challenge-day2/backend
wget https://tcb-public-events.s3.amazonaws.com/mdac/resources/day2/cloudmart-backend.zip
unzip cloudmart-backend.zip
nano .env
```

📌 **Adicione ao `.env`:**
```ini
PORT=5000
AWS_REGION=us-east-1
```

📌 **Construir e rodar o container:**
```sh
docker build -t cloudmart-backend .
docker run -d -p 5000:5000 --env-file .env cloudmart-backend
```

---

### **Frontend**
```sh
cd ../frontend
wget https://tcb-public-events.s3.amazonaws.com/mdac/resources/day2/cloudmart-frontend.zip
unzip cloudmart-frontend.zip
nano .env
```

📌 **Adicione ao `.env`:**
```ini
VITE_API_BASE_URL=http://<IP-PUBLICO-EC2>:5000/api
```

📌 **Construir e rodar o container:**
```sh
docker build -t cloudmart-frontend .
docker run -d -p 5001:5001 cloudmart-frontend
```

---

## **4️⃣ Configurar Firewall e Acessar CloudMart**
📌 **Abrir portas no grupo de segurança da EC2:**
```sh
aws ec2 authorize-security-group-ingress --group-id <seu-sg-id> --protocol tcp --port 5000 --cidr 0.0.0.0/0
aws ec2 authorize-security-group-ingress --group-id <seu-sg-id> --protocol tcp --port 5001 --cidr 0.0.0.0/0
```

📌 **Acesse no navegador:**
- **Backend**: `http://<IP-PUBLICO-EC2>:5000`
- **Frontend**: `http://<IP-PUBLICO-EC2>:5001`

---

## **📌 Próximos Passos**
✅ Implementar **CI/CD** para deploy automatizado  
✅ Monitoramento e logs via **CloudWatch**  
✅ Deploy em **Kubernetes (EKS)**  

📢 **Vamos juntos nessa jornada!** 🚀  

#DevOps #Multicloud #Terraform #AWS #Docker #InfraAsCode
```