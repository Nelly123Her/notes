
# Comandos de Docker

Instalar Docker en MacOS: 
**brew install docker-compose** 
- Descargamos e instalamos docker en nuestro ordenador. 
## Contenedores en Docker: 

 

**docker create “N.I.”** 
- Creamos el contenedor en docker. 

**ocker start “N.I.”**  
- Arrancamos el contenedor, pasa a “running”. 

**docker start –a “N.I.”** 
- Nos muestra el inicio del contenedor. 

**docker run “N.I.”** 
- Función entre el “create” y el “start”, crea e inicia el contenedor que pusimos. 

**docker run –d “N.I.”** 
- Crea y corre el contenedor en segundo plano. 

**docker run “N.I” --name “N.C”** 
- Le asigna un nombre específico al contenedor que creamos. 

**docker ps** 
- Muestra los contenedores que se encuentren activos (running). 

**docker ps -a** 
- Muestra todos los contenedores que corrieron y/o corren actualmente. 

**docker stop “N.C.”** 
- Envía una señal al contenedor de trabajo para que se detenga con un timing de 10s. 

**docker kill “N.C.”** 
- Envía una señal al contenedor para que se detenga de tajo. 

**docker logs “N.C.”** 
- Nos muestra todo lo que se impirme dentro de los contenedores. 

**docker exec “N.C.” “comando”** 
- Nos ayuda a introducir comandos dentro del contenedor 

**docker exec –it “N.C.” “comando”** 
- La bandera “-i" redirecciona la salida del comando a nuestra terminal, mientras que la “-t” le da un formato para poder trabajar. 

**docker rm “N.C.”** 
- Borra el contenedor (y solo el contenedor) que le escribamos. 

**docker rm –f “N.C.”** 
- Elimina el contenedor de forma forzada, esto por si el contenedor en cuestión está corriendo. 

 

 

## Imagenes en Docker: 

 

**docker images** 
- No muestra las imágenes que tengamos en nuestro equipo 

**docker pull “N.I.”:”Version”** 
- Nos descarga las imágenes a nuestro equipo, estas pueden ser visualizadas previamente en el repo de docker: https://hub.docker.com/ 

**docker image rm “N.I.”:”version”** 
- Nos permite borrar la imagen. 

**docker rmi -f “N.I.”** 
- Nos ayuda a borrar de manera forzada la imagen. 

**docker build** 
- Se ejecuta en la carpeta con nuestros archivos “Dockerfile” y adicionales. 

**docker build –tag “N.A./Version” “Path”** 
- La bandera “--tag” No ayuda a asignarle un nombre/tag a nuestra imagen. 

**docker tag “N.I.” “dockerusername/N.I:Version”**  
- El comando tag, nos ayuda a la publicación de nuestra imagen, primero debemos haber creado una cuenta en el repo de docker. 

**docker push “dockerusername/N.I.:Version”** 
- Envía al repo de docker la imagen que preparamos para publicar. 

## Volúmenes en Docker: 

**docker run –v “path_absoluto” : ”Directorio de la data”** 
- Creamos el Mounted Volume, después de haber creado un directorio para almacenar la info del contenedor, y revisar donde se almacena la data de nuestra imagen en el repo de docker. 

**docker volume create “N.V.”** 
- Crear el Named Volume en docker. 

**docker run –v “N.V.”: “Directorio de la data” --name “N.C.” “N.I.”** 
- Asignar el directorio ya creado al contenedor. 

**docker rm –fv “N.C.”** 
- Elimina el contenedor, y la bandera “-v” elimina también los Anonymous Volumes relacionados al contenedor. 

**docker volume ls** 
- Nos mostrará información acerca de los volúmenes que tenemos en docker pero solo de los Named y Anonymous, los Mounted NO serán mostrados ya que esos no los administra docker. 

**docker container inspect “N.C.”** 
- Nos mostrará información acerca del contenedor en cuestión, tales como: variables de entorno, redes, volúmenes relacionados, etc. 

**docker volume rm “N.V.”** 
- Nos elimina el volumen. 

 

## Redes en Docker 

 

**docker network ls** 
- Nos muestra todas las networks que tenemos en docker. 

**docker network create “N.R.”** 
- Creamos una red en docker con el driver bridge. 

**docker network connect “N.R” “N.C”** 
- Conectamos un contenedor a la network que especifiquemos. 

**docker network disconnect “N.R” “N.C”** 
- Desconectamos un contenedor a la red que especifiquemos. 

**docker network rm “N.N”** 
- Eliminamos una red. 

**docker network prune** 
- Eliminamos todas las redes que no estén siendo usadas en contenedores que tengamos. 

 

 

### Create a namespace 
```sh
kubectl create ns (Name of namespace)
```

### Delete a namespace
```sh
kubectl delete ns develope
```

### Apply a file yaml -n tag is the namespace -f file tag
```sh
kubectl -n test apply -f 01-basic-pod.yaml
```

### 
```sh
kubectl -n test get all 
```


```sh
kubectl -n test exec -it nginx -- sh
```



### Delete a pod with the file we created it
```sh
kubectl -n test delete -f 01-basic-pod.yaml 
```


```sh
kubectl -n test get all 
```

```sh
kubectl - test delete (name)
```


```sh
kubectl -n test apply -f 03-deployment.yaml 
```



```sh
kubectl -n test exec -it pod/nginx-deployment-764fb85c6f-27c6w -- sh 
```


```sh
helm install bitnami/wordpress --generate-name --create-namespace --namespace wordpress
```


```sh
 helm install stable/nginx-ingress --generate-name --create-namespace --namespace nginx-controller
```



```sh
kubectl delete daemonsets,replicasets,services,deployments,pods,rc,ingress --all --all-namespaces
```
### https://www.hashicorp.com/products/vault/trial
### Installing Vault enterprise in Kubernetes
####  Creating a file called config.yaml
```yml
# config.yaml
server:
  image:
    repository: hashicorp/vault-enterprise
    tag: 1.10.3-ent
  enterpriseLicense:
    secretName: vault-ent-license
volumeClaimTemplates:
  - metadata:
      creationTimestamp: null
      name: data
    spec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 10Gi
      volumeMode: Filesystem
```
### Set our secret
```sh
nano license.hclic
```
```sh
secret=$(cat license.hclic)
```
```sh
echo $secret                                                                                                                
02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JJZDU2MCNNJMXQTSENN2E43KVGNNGSMD2J5LVU2CMKRATKWSUJV2E4RCBGNNG2SJRLJVE26KPKRVXUSLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJE2E2RCNO5NFOUTMJZJTANKONVNG2TCUIV4E42SBORHUOVTMJ5BTAMKPIRJGYWSUMM2E42TDGJHHUVLJJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SJORGUIY3UJVCEUVKNKRRTMTSUIU3E2RDDOVHVIY3ZJZ5E2M2ONJKXUV3JJFZUS3SOGBMVQSRQLAZVE4DCK5KWST3JJF4U2RCJPFGFIQJTJRKEC6KWIRCTGT3KKV4E62SBGNLWSSLTJFWVMNDDI5WHSWKYKJYGEMRVMZSEO3DULJJUSNSJNJEXOTLKJF2E2RDHORGUIRSVJVKGGNSOKRCTMTKEMRQUS2LXNFSEOVTZMJLWY5KZLBJHAYRSGVTGIR3MORNFGSJWJFVES52NNJEXITKEM52E2RCKKVGVIYZWJZKEKNSNIRSGCSLJO5UWGSCKOZNEQVTKMRBUSNSJNZNGQZCXPAYES2LXNFNG26DILIZU22KPNZZWSYSXHFVWIV3YNRRXSSJWK54UU5DEK54DAYKTGFVVS6JRPJMTERTTLJJUS42JNVSHMZDNKZ4WE3KGOVMTEVLUMNDTS43BK5HDKSLJO5UVSV2SGJMVONLKLJLVC5C2I5DDAWKTGF3WG3JZGBNFOTRQMFLTS5KJNQYTSZSRHU6S4SSDNJXHQZJVGFGE23CKOFDTC32RIV2FAOKNGRZWET3YOFZWETCGNU4TET3VKJ4GUWCZIZVG6MCWK4VUENBTIZ4HAVBXNZJFUZCSJNBXGZ22OZATOQKJJJHW2TKZHBWXU5TFGBWUCNJRMRAWWY3BGRSFMMBTGM4FA53NKZWGC5SKKA2HASTYJFETSRBWKVDEYVLBKZIGU22XJJ2GGRBWOBQWYNTPJ5TEO3SLGJ5FAS2KKJWUOSCWGNSVU53RIZSSW3ZXNMXXGK2BKRHGQUC2M5JS6S2WLFTS6SZLNRDVA52MG5VEE6CJG5DU6YLLGZKWC2LBJBXWK2ZQKJKG6NZSIRIT2PI
```
```sh
$kubectl create secret generic vault-ent-license --from-literal="license=${secret}"
secret/vault-ent-license created
```
```sh
helm repo add hashicorp https://helm.releases.hashicorp.com
```
### Installing vault
```sh
$ helm install vault hashicorp/vault -f config.yaml                                                            
NAME: vault
LAST DEPLOYED: Sat Jul  2 14:06:14 2022
NAMESPACE: default
STATUS: deployed
REVISION: 1
NOTES:
Thank you for installing HashiCorp Vault!

Now that you have deployed Vault, you should look over the docs on using
Vault with Kubernetes available here:

https://www.vaultproject.io/docs/


Your release is named vault. To learn more about the release, try:

  $ helm status vault
  $ helm get manifest vault
```
```sh
kubectl exec -ti vault-0 -- vault license get                                                                                                                    

Error retrieving license: Error making API request.

URL: GET http://127.0.0.1:8200/v1/sys/license/status
Code: 503. Errors:

* Vault is sealed
command terminated with exit code 2
```
```sh
kubectl get pod
NAME                                   READY   STATUS    RESTARTS   AGE
vault-0                                0/1     Running   0          2m3s
vault-agent-injector-f59c7f985-mrkp4   1/1     Running   0          2m4s
```
```sh
kubectl exec -ti vault-0 -- vault operator init
Unseal Key 1: kPkUjZievOpZuAVqtsmmBSLhx2Uf5ctCliL4fsNfABs/
Unseal Key 2: dblPJq777xstqwZCTK3p86y984NuunIxBhMZqa5zO53h
Unseal Key 3: b6oyIHeJui+jvjWitFzQkODLzokGPSA5ly1Fy4G69mke
Unseal Key 4: KFMjocKZinyS/CQJcEkeCn8aXxEFVk0yDXr78YtdsBjC
Unseal Key 5: W++lVFmv/5/p68tKCtGRtJU1fBUG5nHSOELG/Ocmx8v/

Initial Root Token: hvs.mlxrX0wLDUtjMpiZ6Zxr4PK1

Vault initialized with 5 key shares and a key threshold of 3. Please securely
distribute the key shares printed above. When the Vault is re-sealed,
restarted, or stopped, you must supply at least 3 of these keys to unseal it
before it can start servicing requests.

Vault does not store the generated root key. Without at least 3 keys to
reconstruct the root key, Vault will remain permanently sealed!

It is possible to generate new unseal keys, provided you have a quorum of
existing unseal keys shares. See "vault operator rekey" for more information.
```
```sh
kubectl exec -ti vault-0 -- vault operator unseal     
Unseal Key (will be hidden):
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    1/3
Unseal Nonce       de0acfea-ee20-400d-5121-f7900c52e88e
Version            1.10.3+ent
Storage Type       file
HA Enabled         false
```
```sh
kubectl exec -ti vault-0 -- vault operator unseal                                                                                                                           ──(Sat,Jul02)─┘
Unseal Key (will be hidden):
Key                Value
---                -----
Seal Type          shamir
Initialized        true
Sealed             true
Total Shares       5
Threshold          3
Unseal Progress    2/3
Unseal Nonce       de0acfea-ee20-400d-5121-f7900c52e88e
Version            1.10.3+ent
Storage Type       file
HA Enabled         false
```

```sh
kubectl exec -ti vault-0 -- vault operator unseal 
Unseal Key (will be hidden):
Key             Value
---             -----
Seal Type       shamir
Initialized     true
Sealed          false
Total Shares    5
Threshold       3
Version         1.10.3+ent
Storage Type    file
Cluster Name    vault-cluster-04282324
Cluster ID      83d6d187-bdcb-a85c-9a55-0bd98a016be1
HA Enabled      false
```
```sh
kubectl exec -ti vault-0 -- vault login     
Token (will be hidden):
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                  Value
---                  -----
token                hvs.mlxrX0wLDUtjMpiZ6Zxr4PK1
token_accessor       YhqiWrUtLOR7DoTz52lpOopj
token_duration       ∞
token_renewable      false
token_policies       ["root"]
identity_policies    []
policies             ["root"]
```
```sh
kubectl exec -ti vault-0 -- vault license get
WARNING! The following warnings were returned from Vault:

  * time left on license is 718h38m30s

Key                          Value
---                          -----
expiration_time              2022-08-01T17:51:07Z
features                     [HSM Performance Replication DR Replication MFA Sentinel Seal Wrapping Control Groups Performance Standby Namespaces KMIP Entropy Augmentation Transform Secrets Engine Lease Count Quotas Key Management Secrets Engine Automated Snapshots]
license_id                   4c426149-6e7f-39fa-09e3-407fb5f32993
performance_standby_count    9999
start_time                   2022-07-02T17:51:07Z
```
```sh
/ $ vault secrets enable transform
Success! Enabled the transform secrets engine at: transform/
/ $ exit
```

### Fowarding our port
```sh
kubectl port-forward vault-0 8200:8200
```

netstat -nlp | grep 8200                                            0|1 ✘ 
(Not all processes could be identified, non-owned process info
 will not be shown, you would have to be root to see it all.)
tcp        0      0 0.0.0.0:8200            0.0.0.0:*               LISTEN      -                   
    ~/learn-vault-agent/vault-agent-k8s-demo    main ?1  sudo netstat -nlp | grep 8200                                           ✔ 
tcp        0      0 0.0.0.0:8200            0.0.0.0:*               LISTEN      9511/vault          
    ~/learn-vault-agent/vault-agent-k8s-demo    main ?1  kill 8511                                                               ✔ 
kill: kill 8511 failed: no such process
    ~/learn-vault-agent/vault-agent-k8s-demo    main ?1  kill 9511                                                             1 ✘ 
    ~/learn-vault-agent/vault-agent-k8s-demo    main ?1  kill 8511      

 sudo pkill -u postgres 