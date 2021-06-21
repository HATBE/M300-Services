# Einleitung
Einleitung zum LB2 Projekt (Erklärungen)

# Inhaltsverszeichnis

## Service-Aufbau 
Text

## Umsetzung
Text

## Testing
Text

## Quellen
Text




apt install docker.io

docker login --username=aarongen

mkdir TEMP_Docker
cd TEMP_Docker
git clone https://gitlab.com/ser-cal/Container-CAL-webapp_v1.git 
cd Container-CAL-webapp-v1/
cd APP 

docker image build -t aarongen/webapp_one:1.0 .
docker image push aarongen/webapp_one:1.0

docker container run -d --name aar-web -p 8080:8080 aarongen/webapp_one:1.0
