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
### Expondo a aplicação local com o nginx atuando como um proxy reverso
* Esta configuração permite que vocês acesse o **Host** (*que executa o cluster kind*) na porta **80** e o nginx manda a requisição para um DNS interno _kubenews.com.br:30000_ (*que configurei no arquivo hosts do server ubuntu na AWS apontando para o endereço IP de um dos containers do kind*)

* Não sei se todos sabem mas, quando subimos um cluster no **KIND** ele sobe os Nodes em containers, então, quando criamos um **Service:NodePort**, ele tá expondo a port *30000* do aplicativo para os containers e não para o **Host**, ou seja, "_curl http://127.0.1:30000/_" não vai rolar. Isoso ocorre porque a porta *30000* está exposta nos containers (*atuando como Worker Nodes do cluster*) isolados na rede docker do host (*em uma  instância EC2 na AWS para este caso*). Então você deve estar se perguntando: - **Como irei cessar esta aplicação que está expondo a porta 30000 para um container (rodando na rede docker do host) e não para o host ?**

* __Primeiro achando uma maneira de acessar este container através do host__:
"_docker network inspect kind_" aqui você irá pegar o IP de um dos containers "*atuando como Node Worker*" ouvindo na porta **30000** (*na rede docker criada pelo kind*) e iriá criar uma entrada _DNS_ no arquivo _hosts_ do servidor, por exemplo: **_172.18.0.4 kubenews.com.br_**. Agora você já tem acesso ao APP pelo host, onde ele irá redirecionar a requisição **_http://kubenews.com.br:30000/_** para a interface virtual **bridge** (*da rede docker do kind*) que mandará para o container com IP **_172.18.0.4_** desta rede. 
 
* __Próximo passo é garantir uma forma externa de acessar este container__:
O DNS _kubenews.com.br_ só resolve o endereço do container internamente, então, utilizaremos o **nginx** para atuar como um **_proxy reverso_** escutando na porta 80 do host e redirecionando para o **DNS** configurado localmente **_ttp://kubenews.com.br:30000_**. O nginx resolve e conecta no container na porta *30000*, este responde a página da aplicação para o nginx que retornará para o cliente efetivo da requisição (você neste caso).
