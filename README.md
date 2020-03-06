# eugenberend_microservices

eugenberend microservices repository

Done:

- [X] Configured alertmanager for Prometheus, added Slack alerts
- [X] Added Grafana dashboards
- [X] Updated Makefile

How to run:

- Run `make`
- Then, `cd docker && docker-compose up -d`
- Import Grafana dashboards from `monitoring/grafana/dashboards` directory
- Shut down any service. I'll receive an alert :)
