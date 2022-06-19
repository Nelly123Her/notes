### Configuration File
1. Vault servers are configured using a file
1. Written in HCL or JSON
1. The configuration file includes different stanzas and parameters to define a variety of configuration options
1. Configuration file is specified when starting Vault using the – config flag
1. Usually stored somewhere in /etc (doesn’t have to be)
1. I store mine at /etc/vault.d/vault.hcl
```sh
 vault server –config <location>
```
```sh
$ vault server –config /etc/vault.d/vault.hcl
```

### Create a server on linux
```sh
ui = true

#mlock = true
#disable_mlock = true

storage "file" {
  path = "/opt/vault/data"
}

#storage "consul" {
#  address = "127.0.0.1:8500"
#  path    = "vault"
#}

# HTTP listener
#listener "tcp" {
#  address = "127.0.0.1:8200"
#  tls_disable = 1
#}

# HTTPS listener
listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_disable = true
}
```

### Auto Unseal AWS

```sh
seal "awskms" {
  region     = "us-east-1"
  access_key = "AKIAIOSFODNN7EXAMPLE"
  secret_key = "wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY"
  kms_key_id = "19ec80b0-dfdd-4d97-8164-c6examplekey"
  endpoint   = "https://vpce-0e1bb1852241f8cc6-pzi0do8n.kms.us-east-1.vpce.amazonaws.com"
}
```

### Auto Unseal Azure

```sh
seal "azurekeyvault" {
  tenant_id      = "46646709-b63e-4747-be42-516edeaf1e14"
  client_id      = "03dc33fc-16d9-4b77-8152-3ec568f8af6e"
  client_secret  = "DUJDS3..."
  vault_name     = "hc-vault"
  key_name       = "vault_key"
}
```

### Auto Unseal Google

```sh
seal "gcpckms" {
  credentials = "/usr/vault/vault-project-user-creds.json"
  project     = "vault-project"
  region      = "global"
  key_ring    = "vault-keyring"
  crypto_key  = "vault-key"
}
```

### Auto-transit

```sh
seal "transit" {
  address            = "https://vault:8200"
  token              = "s.Qf1s5zigZ4OX6akYjQXJC1jY"
  disable_renewal    = "false"

  // Key configuration
  key_name           = "transit_key_name"
  mount_path         = "transit/"
  namespace          = "ns1/"

  // TLS Configuration
  tls_ca_cert        = "/etc/vault/ca_cert.pem"
  tls_client_cert    = "/etc/vault/client_cert.pem"
  tls_client_key     = "/etc/vault/ca_cert.pem"
  tls_server_name    = "vault"
  tls_skip_verify    = "false"
}
```

```sh
api_addr          = "https://vault:8200"
cluster_addr      = "https://vault:8201"
#cluster_name      = "vault"
disable_mlock     = "true"
log_level         = "Info"
plugin_directory  = "/var/vault/plugins/"
ui                = "true"



listener "tcp" {
  address       = "0.0.0.0:8200"
  tls_cert_file = "/opt/vault/certs/tls.crt"
  tls_key_file  = "/opt/vault/certs/tls.key"
}

storage "raft" {
  path            = "/var/vault/storage/"
  #node_id         = "hostname"
}
```

```sh
storage "raft" {
path = "/opt/vault/data"
node_id = "node-a-us-east-1.example.com"
retry_join {
auto_join = "provider=aws region=us-east-1 tag_key=vault tag_value=us-east-1"
}
}
listener "tcp" {
address = "0.0.0.0:8200"
cluster_address = "0.0.0.0:8201"
tls_disable = 0
tls_cert_file = "/etc/vault.d/client.pem"
tls_key_file = "/etc/vault.d/cert.key"
tls_disable_client_certs = "true"
}
seal "awskms" {
region = "us-east-1"
kms_key_id = "12345678-abcd-1234-abcd-123456789101",
endpoint = "example.kms.us-east-1.vpce.amazonaws.com"
}
api_addr = "https://vault-us-east-1.example.com:8200"
cluster_addr = " https://node-a-us-east-1.example.com:8201"
cluster_name = "vault-prod-us-east-1"
ui = true
log_level = "INFO"
```


vault operator raft join https://active_node.example.com:8200

vault operator raft list-peers



###  Auth Methods
The approle auth method allows machines or apps to authenticate with Vault-defined roles.  
Each auth method is enabled at a path
1. You can choose the path name when (and only when) you enable the 
auth method
1. If you do not provide a name, the auth method will be enabled at its 
default path
1. The default path name is equal to the type of auth method (i.e., aws is 
mounted at "aws", approle is mounted at "approle")

#### Enabling an auth method
```sh
$ vault auth enable approle
```

#### Disabling an auth method
```sh
$ vault auth disable approle
```
#### Listing  auth methods
```sh
$ vault auth list
```

#### Enable an Auth Method at the Default Path

```sh
$ vault auth enable approle
Success! Enabled approle auth method at: approle/
Enable an Auth Method using a Custom Path
```
```sh
$ vault auth enable –path=vault-custom approle
Success! Enabled approle auth method at: vault-course/
```

```sh
vault write auth/approle/role/vault-course \
secret_id_ttl=10m \
token_num_uses=10 \
token_ttl=20m \
token_max_ttl=30m \
secret_id_num_uses=40
```
### Configuring Auth methods using cli
```sh
vault auth enable userpass 
Success! Enabled userpass auth method at: userpass/
```

```sh
vault auth list  
Path         Type        Accessor                  Description
----         ----        --------                  -----------
token/       token       auth_token_2860d3d7       token based credentials
userpass/    userpass    auth_userpass_c0227363    n/a
```
 
```sh
 vault auth tune -default-lease-ttl=24h userpass 
Success! Tuned the auth method at: userpass/
```
```sh
vault  write auth/userpass/users/nelly password=vault policies=polisy.hcl                                                                    
Success! Data written to: auth/userpass/users/nelly
```


vualt list auth/userpas/users/nelly


### Policies


List all enabled policies:
```sh
$ vault policy list
```
  Create a policy named "my-policy" from contents on local disk:
```sh
$ vault policy write my-policy ./my-policy.hcl
```
  Delete the policy named my-policy:
```sh
$ vault policy delete my-policy
```
vault list auth/userpass/users/                                                                                                              2 ✘ 
Keys
----
nelly
    ~  vault read auth/userpass/users/nelly                                                                                                           ✔ 
Key                        Value
---                        -----
policies                   [polisy.hcl]
token_bound_cidrs          []
token_explicit_max_ttl     0s
token_max_ttl              0s
token_no_default_policy    false
token_num_uses             0
token_period               0s
token_policies             [polisy.hcl]
token_ttl                  0s
token_type                 default


 vault login -method=userpass username=nelly                                                                                                    ✔ 
Password (will be hidden): 
Success! You are now authenticated. The token information displayed below
is already stored in the token helper. You do NOT need to run "vault login"
again. Future Vault requests will automatically use this token.

Key                    Value
---                    -----
token                  hvs.CAESIGZ4bxcFMMYcUFymGG5BwictmyFwlIXUF1MS4CDE4dpaGh4KHGh2cy5oeEdIZFo1dXBHamo1VnpyM0hiMHJVWEQ
token_accessor         8mD0wM4nL83wOeR28jk1JPi7
token_duration         24h
token_renewable        true
token_policies         ["default" "polisy.hcl"]
identity_policies      []
policies               ["default" "polisy.hcl"]
token_meta_username    nelly




### Install Premium Version on RedHat distros

sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/RHEL/hashicorp.repo
yum --showduplicates list vault-enterprise-hsm
yum --showduplicates list vault-enterprise
sudo yum -y install vault-enterprise-hsm.x86_64
sudo yum -y install vault-enterprise-hsm-1.9.4+ent-1.x86_64
sudo yum -y install vault-enterprise
sudo yum -y install vault
vault version
vault status
systemctl enable vault
systemctl start vault
systemctl status vault.service

export VAULT_ADDR="http://0.0.0.0:8200"

firewall-cmd --zone=public --add-port=8200/tcp --permanent
  573  firewall-cmd --reload
