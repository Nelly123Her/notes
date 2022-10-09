### Create  VM Azure
```sh
 az vm create \  
    --resource-group nelly-hernandez \
    --name vm-vault \
    --image UbuntuLTS \
    --public-ip-sku Standard \
    --admin-username azureuser \
    --generate-ssh-keys
```

### Get public ip
```sh
 az vm show -d -g nelly-hernandez -n vm-vault --query publicIps -o tsv 
##Output                              
52.171.227.84
```