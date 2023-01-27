### Provisionando cluster com KIND
* Instalação simples do docker
```
curl fsSL https://get.docker.com | bash
```
* Instalação o binário kubectl
```
curl -LO https://dl.k8s.io/release/v1.26.0/bin/linux/amd64/kubectl
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
kubectl version --client --output=yaml    
```
* Instalando o kind a partir do binários
```
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.17.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```
### Configurando seu cluster kind
* Multi-node clusters
```
# a cluster with 3 control-plane nodes and 3 workers
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: control-plane
- role: control-plane
- role: worker
- role: worker
- role: worker
```
* Crinado cluster com a configuração acima
```
kind create cluster --config kind-example-config.yaml --name devops
``` 
