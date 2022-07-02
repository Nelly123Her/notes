```sh
kubectl delete daemonsets,replicasets,services,deployments,pods,rc,ingress --all --all-namespaces
```

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
echo $secret                                                                                                                
02MV4UU43BK5HGYYTOJZWFQMTMNNEWU33JJZDU2MCNNJMXQTSENN2E43KVGNNGSMD2J5LVU2CMKRATKWSUJV2E4RCBGNNG2SJRLJVE26KPKRVXUSLJO5UVSM2WPJSEOOLULJMEUZTBK5IWST3JJE2E2RCNO5NFOUTMJZJTANKONVNG2TCUIV4E42SBORHUOVTMJ5BTAMKPIRJGYWSUMM2E42TDGJHHUVLJJRBUU4DCNZHDAWKXPBZVSWCSOBRDENLGMFLVC2KPNFEXCSLJO5UWCWCOPJSFOVTGMRDWY5C2KNETMSLKJF3U22SJORGUIY3UJVCEUVKNKRRTMTSUIU3E2RDDOVHVIY3ZJZ5E2M2ONJKXUV3JJFZUS3SOGBMVQSRQLAZVE4DCK5KWST3JJF4U2RCJPFGFIQJTJRKEC6KWIRCTGT3KKV4E62SBGNLWSSLTJFWVMNDDI5WHSWKYKJYGEMRVMZSEO3DULJJUSNSJNJEXOTLKJF2E2RDHORGUIRSVJVKGGNSOKRCTMTKEMRQUS2LXNFSEOVTZMJLWY5KZLBJHAYRSGVTGIR3MORNFGSJWJFVES52NNJEXITKEM52E2RCKKVGVIYZWJZKEKNSNIRSGCSLJO5UWGSCKOZNEQVTKMRBUSNSJNZNGQZCXPAYES2LXNFNG26DILIZU22KPNZZWSYSXHFVWIV3YNRRXSSJWK54UU5DEK54DAYKTGFVVS6JRPJMTERTTLJJUS42JNVSHMZDNKZ4WE3KGOVMTEVLUMNDTS43BK5HDKSLJO5UVSV2SGJMVONLKLJLVC5C2I5DDAWKTGF3WG3JZGBNFOTRQMFLTS5KJNQYTSZSRHU6S4SSDNJXHQZJVGFGE23CKOFDTC32RIV2FAOKNGRZWET3YOFZWETCGNU4TET3VKJ4GUWCZIZVG6MCWK4VUENBTIZ4HAVBXNZJFUZCSJNBXGZ22OZATOQKJJJHW2TKZHBWXU5TFGBWUCNJRMRAWWY3BGRSFMMBTGM4FA53NKZWGC5SKKA2HASTYJFETSRBWKVDEYVLBKZIGU22XJJ2GGRBWOBQWYNTPJ5TEO3SLGJ5FAS2KKJWUOSCWGNSVU53RIZSSW3ZXNMXXGK2BKRHGQUC2M5JS6S2WLFTS6SZLNRDVA52MG5VEE6CJG5DU6YLLGZKWC2LBJBXWK2ZQKJKG6NZSIRIT2PI
```
```sh
$kubectl create secret generic vault-ent-license --from-literal="license=${secret}"
secret/vault-ent-license created
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
kubectl exec -ti vault-0 -- vault license get                                                                                                                               ──(Sat,Jul02)─┘

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