# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Configured blackbox_exporter and mongodb_exporter for Prometheus
- [X] Written Makefile
- [X] Integrated container build and deployment into the pipeline

How to run:

- Run `make`
- Then, `cd docker && docker-compose up -d`
- Check <http://IP:9090> for Prometheus web page
