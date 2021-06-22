<span style="font-size:40px">LB2 - M300</span>

<span style="font-size:25px">Aaron Gensetter</span>

<br>

# Inhalt

# Einleitung
Für die LB1 vom Modul 300 habe ich mich für ein Projekt entschieden dass in Kapitel __make link__ weiter beschrieben wird.

Da ich auf einem Ubuntu 20.04 arbeite, werde ich nur die Installations- und Konfigurationsmethoden dafür erklären.

# 1 - Docker
## 1.1 - Installation
```shell
apt install docker.io
```

## 1.2 - Bedienung

```shell
$ docker run <container>
```

Mit __docker run__ kann ein Container auf verschiedene art und weisen gestartet werden, je nach argument.

```shell
$ docker ps
```

__docker ps__ gibt eine Liste der aktuellen Container aus.

```shell
$ docker images
```

__docker images__ gibt eine Liste der aktuellen lokalen images aus.

```shell
$ docker [container/image] rm <container>
```

Mit __docker rm__ können container und/oder Images gelöscht werden.

```shell
$ docker start <container>
```

Mit __docker start__ können container gestartet werden.

```shell
$ docker stop <container>
```

Mit __docker stop__ können container gestoppt werden.

```shell
$ docker kill <container>
```

Bei __docker kill__ wird der hauptprozess gekillt und der Container gestoppt.

## 1.3 - Dockerfile


# 800 - Projekt
## 800.1 - Projekt Umfang
xxxxx

### Ziele:
xxxx

## 800.2 - Umgebung vorbereiten
xxx

## 800.3 - Dockerfile



## 800.800 Testing
# 900 - Reflexion

Ich habe in diesem Modul das erste mal mit docker gerabeitet

# 1000 - Quellen

- MC-B github: https://github.com/mc-b/M300/tree/master [22.06.2021]
- Inhaltsverzeichnis: https://ecotrust-canada.github.io/markdown-toc/ [22.06.2021]
- Nextcloud über occ Installieren: https://docs.nextcloud.com/server/latest/admin_manual/installation/command_line_installation.html [22.06.21]
- Netcloud occ: https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/occ_command.html [22.06.21]

<br><br>

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">
<img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/3.0/ch/88x31.png" />
</a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">Creative Commons Namensnennung - Nicht-kommerziell - Weitergabe unter gleichen Bedingungen 3.0 Schweiz Lizenz</a>








# NOTES (TEMp)
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




Version 1
    self build (dockerfile)

Version 2 
    container from dockerhub