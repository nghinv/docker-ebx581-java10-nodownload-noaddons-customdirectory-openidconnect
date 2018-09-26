# docker-ebx581-java10-nodownload-noaddons-customdirectory-openidconnect

works with Azure

## build

```
docker build -t ebx5.8.1-azure-openidconnect .
docker run -p 9090:8080 -e "CATALINA_OPTS=-DebxLicense=XXXXX-XXXXX-XXXXX-XXXXX" ebx5.8.1-azure-openidconnect
docker ps
docker exec -it dazzling_roentgen /bin/bash
```
