### Docker stopping container
```sh
docker rm -vf $(docker ps -aq)                                                                                            
```
### Docker deleting all images  
```sh
docker rmi -f $(docker images -aq)                                                                                   
```
---
## Run  a postgresql database  with pgadmin
```sh
version: "3.1"

services:

  db:
    restart: always
    image: postgres
    container_name: demo-postgres #you can change this
    environment:
      - POSTGRES_USER=demo
      - POSTGRES_PASS=demo
      - POSTGRES_DB=demo
      - POSTGRES_PORT=5432
    ports:
      - "5432:5432"
    volumes:
      - postgres_data:/var/lib/postgresql/data/

  pgadmin:
      image: dpage/pgadmin4
      container_name: demo-pgadmin #you can change this
      depends_on:
        - db
      ports:
        - "5051:80"
      environment:
        PGADMIN_DEFAULT_EMAIL: pgadmin4@pgadmin.org
        PGADMIN_DEFAULT_PASSWORD: root
      restart: always


volumes:
  postgres_data:

```


### Pushing docker images just in three simple steps:
```sh
docker login --username username
```
```sh
docker tag my-image username/my-repo

docker push username/my-repo
```

### Get into a container in docker
```sh
docker exec -it postgres bash
psql -U root
select * from tokens;
```