### Create SSH keys
```sh
ssh-keygen -t rsa -b 4096
ssh-keygen -t dsa 
ssh-keygen -t ecdsa -b 521
ssh-keygen -t ed25519
```

### Copying the Public Key to the Server
To use public key authentication, the public key must be copied to a server and installed in an authorized_keys file. This can be conveniently done using the ssh-copy-id tool. Like this:
```sh
ssh-copy-id -i .ssh/id_rsa.pub root@192.168.0.23
```
Once the public key has been configured on the server, the server will allow any connecting user that has the private key to log in. During the login process, the client proves possession of the private key by digitally signing the key exchange.


### Sending files by SSH
```sh
scp  project.zip root@192.168.0.15:/home/
```


### Creating TLS certificates with OPENSSL

#### Generating Keys
```sh
openssl genrsa -out ca.key 2048

openssl req -x509 -new -nodes -key ca.key -sha256 -days 1825 -out ca_cert.pem

openssl genrsa -out tls.key 2048

openssl req -new -key tls.key -out tls.csr
```

#### Creating Extensions file for certificates
```sh
touch /opt/vault/certs/client_cert_ext.cnf
echo "Editing the Extensions file for certificates"

tee /opt/vault/certs/client_cert_ext.cnf <<EOF

authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = $standalone
DNS.2 = $node1
DNS.3 = $node2
DNS.4 = $node3
DNS.5 = $replication
DNS.6 = $recovery

EOF
```
#### Signing the certificates
```sh
openssl x509 -req -in tls.csr -CA ca_cert.pem -CAkey ca.key -CAcreateserial -out tls.crt -days 825 -sha256 -extfile client_cert_ext.cnf
```


### Change hosts
We use this feature when we need to stablish a communication between machines using a name instead of ip address. 
```sh
sudo nano  /etc/hosts
```

Example
```sh
127.0.0.1   localhost localhost.localdomain localhost4 localhost4.localdomain4
::1         localhost localhost.localdomain localhost6 localhost6.localdomain6
localhost vaultserver
192.168.0.8 vault-node1
192.168.0.11 vault-node2
```

Change /etc/hosts and /etc/hostname
```sh
echo "vault-node5" > /etc/hostname
echo " 192.168.0.15        vault-node5" >> /etc/hosts
shutdown -r now
```

### Solving a port is being used
```sh
netstat -nlp | grep 8200
```


It'll show processing running at this port, then kill that process using PID (look for a PID in row) of that process.
```sh
kill PID
```
**Example** :
