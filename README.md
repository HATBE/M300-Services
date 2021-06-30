# Einleitung allgemein
Einleitung allgemein (Erklärungen zum ganzen M300-Projekt)

Aufgaben: https://github.com/mc-b/M300/tree/master/10-Toolumgebung

# 10-Toolumgebungen

## 10.01 - Git
### 10.01.1 - Github Account


1. Auf www.github.com ein Benutzerkonto erstellen (Angabe von Username, E-Mail und Passwort)
2. E-Mail zur Verifizierung des Kontos bestätigen und anschliessend auf GitHub anmelden


Github account erstellt: https://github.com/AaronGen

### 10.01.2 - Repository

Repository erstellen
1. Anmelden unter www.github.com
2. Innerhalb der Willkommens-Seite auf Start a project klicken
3. Unter Repository name einen Name definieren (z.B. M300-Services)
4. Optional: kurze Beschreibung eingeben
5. Radio-Button bei Public belassen
6. Haken bei Initialize this repository with a README setzen
7. Auf Create repository klicken

<b>Name</b>: M300-Services\
<b>Description:</b> Microservices / Containerumgebung\
<b>Status:</b> Private

Repository Klonen
```Shell
$ git clone <Repository>
```
Pullen
```Shell
$ git pull
```
Status prüfen
```Shell
$ git status
```
Status pushen
```Shell
$ git add .
$ git commit -m "<nachricht>"
$ git push
```
### 10.01.3 - SSH-KEY

Zuerst muss in der Konsole einen SSH Key erstellt werden

```Shell 
$ ssh-keygen -t rsa -b 4096

Generating public/private rsa key pair.
Enter a file in which to save the key (~/.ssh/id_rsa): ~/.ssh/M300_key
Enter passphrase (empty for no passphrase): [Passwort]
Enter same passphrase again: [Passwort wiederholen]
```

Nachdem der Key erstellt wurde, muss er im Terminal angezeigt werden, dies muss mit folgendem Befehl getan werden.\
<img src="images/y2RjRN1.png">\
Wenn der Public key nun in der Konsole angezeigt wird, diesen Kopieren.\
<img src="images/yMGMdSe.png">

<img src="images/92RsF4D.png">\
Den zuvor kopierten Public Key hier unter KEY Pasten.\
Der Name kann frei gewählt werden.\
<img src="images/Rzy4krY.png">

Wenn der Key nun in Github eingetragen ist, muss er auf dem Lokalen PC noch mit dem Repository verbunden werden.

```Shell 
$ ssh git@github.com -T -i ~/.ssh/<dein KEY>
Hi User! Youve successfully authenticated, but GitHub does not provide shell access.
Connection to github.com closed.

$ cd /pfad/zu/repository
$ git init
$ git remote add origin https://github.com/<dein Username>/<dein GIT Repository>
$ git remote set-url git@github.com:<dein Username>/<dein GIT Repository>
$ git pull origin master
```

### 10.01.4 - Git
<b>Installieren</b>\
<b>Linux</b>

```Shell 
apt install git
```
<b>Windows</b>

Wenn Git unter Windows Installiert werden soll "Would not recommend", hier downloaden\
https://git-scm.com/downloads

<b>Konfiguration</b>

```Shell 
$ git config --global user.name "<username>"
$ git config --global user.email "<e-mail>"
```
## 10.02 - Virtualbox
### 10.02.1 - Installation
<b>Linux</b>
```Shell 
$ apt install virtualbox
```
<b>Windows</b>

Folgendes File Installieren und dem Wizard folgen\
https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1.22-144080-Win.exe

### 10.02.2 - VM erstellen
Daten: 
Name: M300_Ubuntu_20.04_Desktop\
Typ: Linux x64\
RAM: 2048 MB\
Festplatte: 10 GB\
Festplatten Typ: VMDK → dynamisch alloziert

### 10.02.3 VM Konfigurieren
Updaten und Upgraden
```Shell 
$ apt update
$ apt upgrade -y
```
Synaptic Installieren
```Shell 
$ apt install synaptic
```

## 10.03 - Vagrant
### 10.03.1 - Installation
<b>Linux</b>

```Shell 
$ apt install vagrant
```

<b>Windows</b>\
Auf folgenden Link drücken, Downloaden und dem Wizard folgen:\
https://www.vagrantup.com/downloads

### 10.03.2 - Bedienung
<b>Einfache VM Erstellen</b>
1. Verzeichniss erstellen

```Shell 
$ mkdir ~/vagrant/box1
```
2. VM Initialisieren\
**Wichtig, dieser befehl muss im eben erstellten Verzeichniss ausgeführt werden

```Shell 
$ vagrant init <user>/<box>
    Beispiel für box:
        vagrant init ubuntu/xenial64
```
3. Vagrant VM starten\
**Wichtig, dieser befehl muss im eben erstellten Verzeichniss ausgeführt werden
```Shell 
$ vagrant up
```
<b>Vagrant Befehle und Konfiguraionen</b>

Vagrant box herunterladen
```Shell 
$ vagrant box add <user>/<Box>
```
Die Boxen könenn hier gefunden werden: https://app.vagrantup.com/boxes/search

Box Initialisieren
```Shell 
$ vagrant init <user>/<box>
```

Box Starten
```Shell 
$ vagrant up
oder: vagrant up (<boxname>) (wenn mehrere boxen im Vagantfile vorhanden sind)
```

Box Stoppen
```Shell 
$ vagrant halt
oder: vagrant halt (<boxname>) (wenn mehrere boxen im Vagantfile vorhanden sind)
```

Box Anhalten
```Shell 
$ vagrant suspend
oder: vagrant suspend (<boxname>) (wenn mehrere boxen im Vagantfile vorhanden sind)
```

Box Löschen
```Shell 
$ vagrant destroy
```

Direkt ssh verbindung zu Box
```Shell 
$ vagrant ssh 
oder: vagrant ssh (<boxname>) (wenn mehrere boxen im Vagantfile vorhanden sind)
``` 
mit "exit" kommt man wieder aus der SSH Session

Um den Status einer Box herauszufinden.
```Shell 
$ vagrant status
oder: vagrant status (<boxname>) (wenn mehrere boxen im Vagantfile vorhanden sind)
```

Dies gibt folgenden output

```Shell 
Current machine states:

default                   running (virtualbox)
```

oder 

```Shell 
Current machine states:

default                   poweroff (virtualbox)
```

oder 

```Shell 
Current machine states:

default                   saved (virtualbox)
```

| Befehl                    | Beschreibung                                                      |
| ------------------------- | ----------------------------------------------------------------- | 
| `vagrant init`            | Initialisiert im aktuellen Verzeichnis eine Vagrant-Umgebung und erstellt, falls nicht vorhanden, ein Vagrantfile |
| `vagrant up`              |  Erzeugt und Konfiguriert eine neue Virtuelle Maschine, basierend auf dem Vagrantfile |
| `vagrant ssh`             | Baut eine SSH-Verbindung zur gewünschten VM auf                   |
| `vagrant status`          | Zeigt den aktuellen Status der VM an                              |
| `vagrant port`            | Zeigt die Weitergeleiteten Ports der VM an                        |
| `vagrant halt`            | Stoppt die laufende Virtuelle Maschine                            |
| `vagrant destroy`         | Stoppt die Virtuelle Maschine und zerstört sie.                   |

<br><br>
<b>Vagrantfile</b>
Das Vagrantfile befindet sich in dem Ordner in dem man den Befehl vagrant init ausgeführt hat, es sieht ohne weitere Optionen folgendermassen aus.

```Shell 
Vagrant.configure("2") do |config|
  config.vm.box = "user/box"
end
```
Die vagrant VMs werden standartmässig in Virtualbox laufen gelassen, solange man dies im Vagrantfile nicht ändert.

<img src="images/Gh5bjp2.png">

Nach dem Editieren des vagrantfiles, muss folgender befehl ausgeführt werden
```Shell 
$ vagrant reload
``` 

Um ein Hostname zu geben, muss man das Vagrantfile folgendermasen editieren
unter config.vm.box = ""
```Shell 
config.vm.hostname = "dein Hostname"
```

Um eine IP Adresse zu setzen, muss man das Vagrantfile folgendermasen editieren
```Shell 
config.vm.network "private_network", ip: "10.9.8.7"
```

<b>Mehrere Vms erstellen</b>\
Mit Vagrant ist es möglich mehrere Vms mit nur einem File zu erstellen, dies Zeige ich hier anhand eines Beispieles.

```Shell 
$ cd /path/to/vmstorage
$ mkdir multivm
$ cd multivm
$ vagrant init ubuntu/xenial64
$ nano Vagrantfile
```
```Shell 
FilePath: /path/to/vmstorage/multivm/Vagrantfile

-------------------------------------------------

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64" #Select box Image

  # Define Box 1
  config.vm.define "box1" do |box1|
   box1.vm.hostname = "box1"
   box1.vm.network "private_network", ip: "10.9.8.1"
  end

  # Define Box 2
  config.vm.define "box2" do |box2|
   box2.vm.hostname = "box2"
   box2.vm.network "private_network", ip: "10.9.8.2"
  end

end
```
Um die VMs zu starten
```Shell 
$ vagrant up
umd nur eine der beiden zu starten: vagrant up box1 oder box2
```
Nun laufen die beiden VMs und sie können auch miteinander kommunizieren.\
<img src="images/IAxxDO5.png">

Um eine der beiden VMs zu **kontrollieren**
```Shell 
$ vagrant ssh box1
oder
$ vagrant ssh box2
```

<img src="images/5Nii12Y.png">

<b>Automatisch bash befehle beim erstellen ausführen</b>

Folgender Punkt muss auskommentiert weden, und die Befehle können dazwischen geschrieben werden, in desem Beispiel werde ich einen Apache Server installieren und das System updaten
```Shell
config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   apt-get install -y apache2
SHELL
```

### 10.03.3 - Webserver

Um mit Vagrant einen Webserver zu installieren, kann das Vagrantfile folgendermassen konfiguriert werden

```Shell 
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64" # Install Ubuntu (Xenial = 16.04)
  config.vm.network "forwarded_port", guest:80, host:8080, auto_correct: true # Port 80 von VM zu port 8080 Host weiterleiten
  config.vm.synced_folder ".", "/var/www/html"   # den Pfad in dem das Vagrant file ist, zum webverzeichnis weiterleiten
config.vm.provider "virtualbox" do |vb|
  vb.memory = "512"  # Server mit einem Halben gb ram ausstatten
end
config.vm.provision "shell", inline: <<-SHELL
  # Packages vom lokalen Server holen
  # sudo sed -i -e"1i deb {{config.server}}/apt-mirror/mirror/archive.ubuntu.com/ubuntu xenial main restricted" /etc/apt/sources.list 
  sudo apt-get update # System Updaten
  sudo apt-get -y install apache2  # apache2 Installieren
SHELL
end
```

Dieses vagrantfile ist bereits im Git Repo von MC-B vorhanden.\
https://github.com/tbz-it/M300/tree/master/vagrant/web
```Shell 
cd ~/gitrep/M300/vagrant/web
vagrant up
```
<img src="images/RRCqf3f.png">

## 10.04 - VSCode
### 10.04.1 - Installation
<b>Linux</b>

```Shell 
snap install --classic code
```

<b>Windows</b>

Auf dem folgenden Linux drücken und dem Wizard folgen.\
https://code.visualstudio.com/

# 20 - Infrastruktur
## 20.01 - Arten von Cloudcomputing

<b>Infrastruktur – Infrastructure as a Service (IaaS)</b>\
Die Infrastruktur (auch "Cloud Foundation") stellt die unterste Schicht im Cloud Computing dar. Der Benutzer greift hier auf bestehende Dienste innerhalb des Systems zu, verwaltet seine Recheninstanzen (virtuelle Maschinen) allerdings weitestgehend selbst.

<b>Plattform – Platform as a Service (PaaS)</b>\
Der Entwickler erstellt die Anwendung und lädt diese in die Cloud. Diese kümmert sich dann selbst um die Aufteilung auf die eigentlichen Verarbeitungseinheiten. Im Unterschied zu IaaS hat der Benutzer hier keinen direkten Zugriff auf die Recheninstanzen. Er betreibt auch keine virtuellen Server.

<b>Anwendung – Software as a Service (SaaS)</b>\
Die Anwendungssicht stellt die abstrakteste Sicht auf Cloud-Dienste dar. Hierbei bringt der Benutzer seine Applikation weder in die Cloud ein, noch muss er sich um Skalierbarkeit oder Datenhaltung kümmern. Er nutzt eine bestehende Applikation, die ihm die Cloud nach aussen hin anbietet.

Mit dem Advent von Docker (Containierisierung) hat sich zwischen IaaS und PaaS eine neue Ebene geschoben:

<b>CaaS (Container as a Service)</b>\
Diese Ebene ist dafür zuständig, containerisierten Workload auf den Ressourcen auszuführen, die eine IaaS-Cloud zur Verfügung stellt. Die Technologien dieser Ebene wie Docker, Kubernetes oder Mesos sind allesamt quelloffen verfügbar. Somit kann man sich seine private Cloud ohne Gefahr eines Vendor Lock-ins aufbauen.

Beispiele:

    Public Cloud
        AWS, Azure, Digital Ocean, Google, exoscale
    Private Cloud
        CloudStack, OpenStack, VMware vCloud
    Lokale Virtualisierung
        Oracle VirtualBox, Hyper-V, VMware Player
    Hyperkonvergente Systeme
        Rechner die die oben beschriebenen Eigenschaften in einer Hardware vereinen

Beispiele:
 
    Programmierbar
        Ein Userinterface ist zwar angenehm und viele Cloud Anbieter haben ein solches, aber für IaC muss die Plattform via Programmierschnittstelle (API) ansprechbar sein.
    On-demand
        Ressourcen (Server, Speicher, Netzwerke) schnell erstellen und vernichtet.
    Self-Service
        Ressourcen anpassen und auf eigene Bedürfnisse zuschneiden.
    Portabel
        Anbieter von Ressourcen (z.B. AWS, Azure) müssen austauschbar sein.
    Sicherheit, Zertifizierungen (z.B. ISO 27001), etc.

Ziele von Infrastructure as a Code (IaC) sind:

- IT-Infrastruktur wird unterstützt und ermöglicht Veränderung, anstatt Hindernis oder Einschränkung zu sein.
- Änderungen am System sind Routine, ohne Drama oder Stress für Benutzer oder IT-Personal.
- IT-Mitarbeiter verbringen ihre Zeit für wertvolle Dinge, die ihre Fähigkeiten fördern und nicht für sich wiederholende Aufgaben.
- Fachanwender erstellen und verwalten ihre IT-Ressourcen, die sie benötigen, ohne IT-Mitarbeiter
- Teams sind in der Lage, einfach und schnell, ein abgestürztes System wiederherzustellen.
- Verbesserungen sind kontinuierlich und keine teuren und riskanten "Big Bang" Projekte.
- Lösungen für Probleme sind durch Implementierung, Tests, und Messen institutionalisiert, statt diese in Sitzungen und Dokumente zu erörtern.

Definitionen
- Versionsverwaltung - Version Control Systems (VCS)
- Testgetriebene Entwicklung - Testdriven Development (TDD)
- Kontinuierliche Integration - Continuous Integration (CI)
- Kontinuierliche Verteilung - Continuous Delivery (CD)

## 20.02 Packer

Packer ist ein Tool zur Erstellung von Images bzw. Boxen für eine Vielzahl von Dynamic Infrastructure Platforms mittels einer Konfigurationsdatei.

# 25 - Sicherheit 1
Ausgabe von allen offenen ports 

```Shell 
$ apt install net-tools
$ netstat -tulpn
```

## UFW
### Installation
```Shell 
apt install ufw
```

Bedienen
```Shell 
$ sudo ufw status
$ sudo ufw enable
$ sudo ufw disable
```

Regeln öffnen
```Shell 
# Port 80 (HTTP) öffnen für alle
$ ufw allow 80/tcp

# Port 22 (SSH) nur für den Host (wo die VM laufen) öffnen
$ ufw allow from [Meine-IP] to any port 22

# Port 3306 (MySQL) nur für den web Server öffnen
$ ufw allow from [IP der Web-VM] to any port 3306
```

Regeln schliessen
```Shell 
# Port 80 (HTTP) öffnen für schliessen
$ ufw deny 80/tcp
```

Testen
```Shell 
$ curl -f 192.168.55.101
$ curl -f 192.168.55.100:3306
```

Regeln Löschen
```Shell 
$ sudo ufw status numbered
$ sudo ufw delete 1
```

## Revere Proxy Apache
## Installation

```Shell 
$ apt install apache2
$ apt install libapache2-mod-proxy-html
$ apt install libxml2-dev

$ a2enmod proxy
$ a2enmod proxy_html
$ a2enmod proxy_http 
```
## Konfiguration
Die Datei /etc/apache2/apache2.conf wie folgt ergänzen:
```Shell 
ServerName localhost 
```

Apache Server neustarten
```Shell 
$ sudo service apache2 restart
```

Um eine Weiterleitung zu kreiren, das File sites-enabled/001-reverseproxy.conf erstellen / bearbeiten
```Shell 
    # Allgemeine Proxy Einstellungen
    ProxyRequests Off
    <Proxy *>
        Order deny,allow
        Allow from all
    </Proxy>

    # Weiterleitungen master
    ProxyPass /master http://master
    ProxyPassReverse /master http://master
```

## benutzer

| Benutzername  | Funktion                                             |
| ------------- | ---------------------------------------------------- | 
| `root`        | Der Systemverwalter unter Linux                      |
| `nobody`      | Wird von Prozessen als Benutzererkennung verwendet, wenn nur ein Minimum an Rechten vergeben werden soll  |
| `cupsys`      | Benutzer des Druckdienstes CUPS                      |
| `www-data`    | Benutzer des Webservers Apache                       |

Die Benutzer stehen in der Datei /etc/passwd. Die Passwörter in der Datei /etc/shadow.

Die Gruppen stehen in der Datei /etc/group.

Das Homeverzeichnis setzt sich aus /home und dem jeweiligen Benutzernamen zusammen (z.B. /home/myaccount).

mit ls -al können alle Berechtigungen angezeigt werden, die user/gruppen auf Files haben.

## Apache sichern

HTTPS
```shell
# Default Konfiguration in /etc/apache2/sites-available freischalten (wird nach sites-enabled verlinkt)
sudo a2ensite default-ssl.conf

# SSL Modul in Apache2 aktivieren
sudo a2enmod ssl

# Optional HTTP deaktivieren
sudo a2dissite 000-default.conf 

# Datei /etc/apache2/ports.conf editieren und <Listen 80> durch Voranstellen von # deaktivieren
sudo nano /etc/apache2/ports.conf

# Apache Server frisch starten
sudo service apache2 restart
```

Passwort
```shell
 # .htpasswd Datei erzeugen (ab dem zweiten User ohne -c), Password wird verlangt                        
sudo htpasswd -c /etc/apache2/.htpasswd guest

# /etc/apache2/sites-enabled/default-ssl.conf Editieren und vor </VirtualHost> folgendes Einfügen
<Directory "/var/www/html">
        AuthType Basic
        AuthName "Restricted Content"
        AuthUserFile /etc/apache2/.htpasswd
        Require valid-user
</Directory>
```
# 30 - Container

Merkmale

    Container teilen sich Ressourcen mit dem Host-Betriebssystem
    Container können im Bruchteil einer Sekunde gestartet und gestoppt werden
    Anwendungen, die in Containern laufen, verursachen wenig bis gar keinen Overhead
    Container sind portierbar --> Fertig mit "Aber bei mir auf dem Rechner lief es doch!"
    Container sind leichtgewichtig, d.h. es können dutzende parallel betrieben werden.
    Container sind "Cloud-ready"!

## Docker

### Architektur

Docker Deamon

- Erstellen, Ausführen und Überwachen der Container
- Bauen und Speichern von Images

Der Docker Daemon wird normalerweise durch das Host-Betriebssystem gestartet.

Docker Client

- Docker wird über die Kommandozeile (CLI) mittels des Docker Clients bedient
- Kommuniziert per HTTP REST mit dem Docker Daemon

Da die gesamte Kommunikation über HTTP abläuft, ist es einfach, sich mit entfernten Docker Daemons zu verbinden und Bindings an Programmiersprachen zu entwickeln.

Images

- Images sind gebuildete Umgebungen welche als Container gestartet werden können
- Images sind nicht veränderbar, sondern können nur neu gebuildet werden.
- Images bestehen aus Namen und Version (TAG), z.B. ubuntu:16.04.
- Wird keine Version angegeben wird automatisch :latest angefügt.

Container

- Container sind die ausgeführten Images
- Ein Image kann beliebig oft als Container ausgeführt werden
- Container bzw. deren Inhalte können verändert werden, dazu werden sogenannte Union File Systems verwendet, welche nur die Änderungen zum original Image speichern.

Docker Registry

- In Docker Registries werden Images abgelegt und verteilt

Die Standard-Registry ist der Docker Hub, auf dem tausende öffentlich verfügbarer Images zur Verfügung stehen, aber auch "offizielle" Images.

Viele Organisationen und Firmen nutzen eigene Registries, um kommerzielle oder "private" Images zu hosten, aber auch um den Overhead zu vermeiden, der mit dem Herunterladen von Images über das Internet einhergeht.

### befehle

docker run

- Ist der Befehl zum Starten neuer Container.
- Der bei weitem komplexesten Befehl, er unterstützt eine lange Liste möglicher Argumente.
- Ermöglicht es dem Anwender, zu konfigurieren, wie das Image laufen soll, Dockerfile-Einstellungen zu überschreiben, Verbindungen zu konfigurieren und Berechtigungen und Ressourcen für den Container zu setzen.

Standard-Test:
```shell
    $ docker run hello-world
```
Startet einen Container mit einer interaktiven Shell (interactive, tty):
```shell
    $ docker run -it ubuntu /bin/bash
```
Startet einen Container, der im Hintergrund (detach) läuft:
```shell
    $ docker run -d ubuntu sleep 20
```
Startet einen Container im Hintergrund und löscht (remove) diesen nach Beendigung des Jobs:
```shell
    $ docker run -d --rm ubuntu sleep 20
```
Startet einen Container im Hintergrund und legt eine Datei an:
```shell
    $ docker run -d ubuntu touch /tmp/lock
```
Startet einen Container im Hintergrund und gibt das ROOT-Verzeichnis (/) nach STDOUT aus:
```shell
    $ docker run -d ubuntu ls -l
```
docker ps

- Gibt einen Überblick über die aktuellen Container, wie z.B. Namen, IDs und Status.

Aktive Container anzeigen:
```shell
    $ docker ps
```
Aktive und beendete Container anzeigen (all):
```shell
    $ docker ps -a
```
Nur IDs ausgeben (all, quit):
```shell
    $ docker ps -a -q
```
docker images

- Gibt eine Liste lokaler Images aus, wobei Informationen zu Repository-Namen, Tag-Namen und Grösse enthalten sind.

Lokale Images ausgeben:
```shell
    $ docker images
```
Alternativ auch mit ... image ls:
```shell
    $ docker image ls
```
docker rm und docker rmi

- docker rm
  - Entfernt einen oder mehrere Container. Gibt die Namen oder IDs erfolgreich gelöschter Container zurück.
- docker rmi
  - Löscht das oder die angegebenen Images. Diese werden durch ihre ID oder Repository- und Tag-Namen spezifiziert.

Docker Container löschen:
```shell
    $ docker rm [name]
```
Alle beendeten Container löschen:
```shell
    $ docker rm `docker ps -a -q`
```
Alle Container, auch aktive, löschen:
```shell
    $ docker rm -f `docker ps -a -q`
```
Docker Image löschen:
```shell
    $ docker rmi ubuntu
```
Zwischenimages löschen (haben keinen Namen):

```shell
    $ docker rmi `docker images -q -f dangling=true`
```

docker start

- Startet einen (oder mehrere) gestoppte Container.
  - Kann genutzt werden, um einen Container neu zu starten, der beendet wurde, oder um einen Container zu starten, der mit docker create erzeugt, aber nie gestartet wurde.

Docker Container neu starten, die Daten bleiben erhalten:
```shell
    $ docker start [id]
```
Container stoppen, killen

- docker stop
  - Stoppt einen oder mehrere Container (ohne sie zu entfernen). Nach dem Aufruf von docker stop für einen Container wird er in den Status »exited« überführt.
- docker kill
  - Schickt ein Signal an den Hauptprozess (PID 1) in einem Container. Standardmässig wird SIGKILL gesendet, womit der Container sofort stoppt.

Informationen zu Containern

- docker logs
  - Gibt die "Logs" für einen Container aus. Dabei handelt es sich einfach um alles, was innerhalb des Containers nach STDERR oder STDOUT geschrieben wurde.
- docker inspect
  - Gibt umfangreiche Informationen zu Containern oder Images aus. Dazu gehören die meisten Konfigurationsoptionen und Netzwerkeinstellungen sowie Volumes-Mappings.
- docker diff
  - Gibt die Änderungen am Dateisystem des Containers verglichen mit dem Image aus, aus dem er gestartet wurde.
- docker top
  - Gibt Informationen zu den laufenden Prozessen in einem angegebenen Container aus.

### Dockerfile

Ein Dockerfile ist eine Textdatei mit einer Reihe von Schritten, die genutzt werden können, um ein Docker-Image zu erzeugen.

Dazu wird zuerst ein Verzeichnis erstellt und darin eine Datei mit Namen "Dockerfile".

Anschliessend kann das Image wie folgt gebuildet werden:
```shell
    $ docker build -t mysql .
```
Starten:
```shell
    $ docker run --rm -d --name mysql mysql
```
Funktionsfähigkeit überprüfen:
```shell
    $ docker exec -it mysql bash
```
Überprüfung im Container:
```shell
    $ ps -ef
    $ netstat -tulpen
```

Anweisungen im Dockerfile

`FROM`

Welches Base Image von hub.docker.com verwendet werden soll, z.B. ubuntu:16.04

`ADD`

Kopiert Dateien aus dem Build Context oder von URLs in das Image.

`CMD`

Führt die angegebene Anweisung aus, wenn der Container gestartet wurde. Ist auch ein ENTRYPOINT definiert, wird die Anweisung als Argument für ENTRYPOINT verwendet.

`COPY`

Wird verwendet, um Dateien aus dem Build Context in das Image zu kopieren. Es gibt die zwei Formen COPY src dest und COPY ["src", "dest"]. Das JSON-Array-Format ist notwendig, wenn die Pfade Leerzeichen enthalten.

`ENTRYPOINT`

Legt eine ausführbare Datei (und Standardargumente) fest, die beim Start des Containers laufen soll.
Jegliche CMD-Anweisungen oder an docker run nach dem Imagenamen übergebenen Argumente werden als Parameter an das Executable durchgereicht.
ENTRYPOINT-Anweisungen werden häufig genutzt, um "Start-Scripts" anzustossen, die Variablen und Services initialisieren, bevor andere übergebene Argumente ausgewertet werden.

`ENV`

Setzt Umgebungsvariablen im Image.

`EXPOSE`

Erklärt Docker, dass der Container einen Prozess enthält, der an dem oder den angegebenen Port(s) lauscht.

`HEALTHCHECK`

Die Docker Engine prüft regelmässig den Status der Anwendung im Container.
HEALTHCHECK --interval=5m --timeout=3s \ CMD curl -f http://localhost/ || exit 1`

`MAINTAINER`

Setzt die "Autor-Metadaten" des Image auf den angegebenen Wert.

`RUN`

Führt die angegebene Anweisung im Container aus und bestätigt das Ergebnis.

`SHELL`

Die Anweisung SHELL erlaubt es seit Docker 1.12, die Shell für den folgenden RUN-Befehl zu setzten. So ist es möglich, dass nun auch direkt bash, zsh oder Powershell-Befehle in einem Dockerfile genutzt werden können.

`USER`

Setzt den Benutzer (über Name oder UID), der in folgenden RUN-, CMD- oder ENTRYPOINT-Anweisungen genutzt werden soll.

`VOLUME`

Deklariert die angegebene Datei oder das Verzeichnis als Volume. Besteht die Datei oder das Verzeichnis schon im Image, wird sie bzw. es in das Volume kopiert, wenn der Container gestartet wird.

`WORKDIR`

Setzt das Arbeitsverzeichnis für alle folgenden RUN-, CMD-, ENTRYPOINT-, ADD oder COPY-Anweisungen.

### Netzwerk

Portweiterleitung

```shell
$ docker run --rm -d -p <port>:<port> <image>
```

Netzwerk anzeigen lassen

```shell
$ docker network ls
```

### Volumes

 der -v parameter addet ein Volume.

 Datenverzeichnis /var/lib/mysql vom Container auf dem Host einhängen (mount):
```shell
$ docker run -d -p 3306:3306  -v ~/data/mysql:/var/lib/mysql --name mysql --rm mysql

# Datenverzeichnis
$ ls -l ~/data/mysql
```

# 35 - Sicherheit 2

## Logging

Json logging
```shell
$ docker run --name logtest ubuntu bash -c 'echo "stdout"; echo "stderr" >>2'
```

Syslog
```shell
$ docker run -d --log-driver=syslog ubuntu bash -c 'i=0; while true; do i=$((i+1)); echo "docker $i"; sleep 1; done;'
$ tail -f /var/log/syslog
```

## Absichern
User Setzen
```shell
RUN groupadd -r user_grp && useradd -r -g user_grp user
USER user
```

Speicher begrenzen
```shell
RUN groupad
docker run -m 128m --memory-swap 128m amouat/stress stress --vm 1 --vm-bytes 127m -t 5s
```

# 40 - Container-Orchestrierung

__Load Balancing__

Mittels Lastverteilung (englisch Load Balancing) werden in der Informatik umfangreiche Berechnungen oder große Mengen von Anfragen auf mehrere parallel arbeitende Systeme verteilt.

Insbesondere bei Webservern ist eine Lastverteilung wichtig, da ein einzelner Host nur eine begrenzte Menge an HTTP-Anfragen auf einmal beantworten kann.

Für unsere Zwecke kann Lastverteilung als der Prozess des Verteilens von Anfragen auf verschiedene Container betrachtet werden.

__Cluster__

## Kubernetes

    Immutable (Unveränderlich) statt Mutable.
    Deklarative statt Imperative (Ausführen von Anweisungen) Konfiguration.
    Selbstheilende Systeme - Neustart bei Absturz.
    Entkoppelte APIs – LoadBalancer / Ingress (Reverse Proxy).
    Skalieren der Services durch Änderung der Deklaration.
    Anwendungsorientiertes statt Technik (z.B. Route 53 bis AWS) Denken.
    Abstraktion der Infrastruktur statt in Rechnern Denken.


Pod - Ein Pod repräsentiert eine Gruppe von Anwendungs-Containern und Volumes, die in der gleichen Ausführungsumgebung (gleiche IP, Node) laufen.

ReplicaSet: ReplicaSets bestimmen wieviele Exemplare eines Pods laufen und stellen sicher, dass die angeforderte Menge auch verfügbar ist.

Deployment: Deployments erweitern ReplicaSets um deklarative Updates (z.B. von Version 1.0 auf 1.1) von Container Images.

Service: Ein Service steuert den Zugriff auf einen Pod (IP-Adresse, Port). Während Pods (bzw. Images) ersetzt werden können (z.B. durch Update auf neue Version) bleibt ein Service stabil.

Ingress: Ähnlich einem Reverse Proxy ermöglicht ein Ingress den Zugriff auf einen Service über einen URL.


Ein Rechnerverbund oder Computercluster, meist einfach Cluster genannt (vom Englischen für „Rechner-Schwarm“, „-Gruppe“ oder „-Haufen“), bezeichnet eine Anzahl von vernetzten Computern.

Der Begriff wird zusammenfassend für zwei unterschiedliche Aufgaben verwendet:

    die Erhöhung der Rechenkapazität (HPC-Cluster)
    die Erhöhung der Verfügbarkeit (HA-Cluster, engl. high available - hochverfügbar).

Die in einem Cluster befindlichen Computer (auch Knoten, vom englischen nodes oder Server) werden auch oft als Serverfarm bezeichnet.

# 50 - Quellen

Aufgaben und einige Texte: https://github.com/mc-b/M300/tree/master
- - -
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/3.0/ch/88x31.png" /></a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">Creative Commons Namensnennung - Nicht-kommerziell - Weitergabe unter gleichen Bedingungen 3.0 Schweiz Lizenz</a>

- - -