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