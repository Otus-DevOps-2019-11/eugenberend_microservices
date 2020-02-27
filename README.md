# eugenberend_microservices

eugenberend microservices repository

Answers:

- [X] ```ifconfig``` outputs from the docker machine and from the first docker container are identical
- [X] Host driver is used. It is not possible to run multiple nginx container as they listening the same http port. Thus, all nginx containers except the first one exit with error code 1:

```log
2020/02/27 07:18:06 [emerg] 1#1: bind() to 0.0.0.0:80 failed (98: Address already in use)
nginx: [emerg] bind() to 0.0.0.0:80 failed (98: Address already in use)
```

- [X] ```docker-compose``` assigns a prefix for resources. If it isn't explicitly specified using ```-p``` arg, it defaults to the directory name

Done:

- [X] Parametrized docker-compose created
- [X] docker-compose.override.yml created

Run:

- [X] docker-compose up -d
