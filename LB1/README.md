<span style="font-size:40px">LB1 - M300</span>

<span style="font-size:25px">Aaron Gensetter</span>

<br>

# Inhalt

- [Inhalt](#inhalt)
- [Einleitung](#einleitung)
- [1 - Virtualbox](#1---virtualbox)
  - [1.1 - Installation](#11---installation)
- [2 - Vagrant](#2---vagrant)
  - [2.1 - Installation](#21---installation)
    - [2.2 - Bedienung](#22---bedienung)
    - [2.3 - Enfache VM Erstellen](#23---enfache-vm-erstellen)
    - [2.4 - Vagrantfile](#24---vagrantfile)
    - [2.5 - Mehrere VMs erstellen](#25---mehrere-vms-erstellen)
    - [2.6 - Json](#26---json)
- [3 - Visual Studio Code](#3---visual-studio-code)
  - [3.1 - Installation](#31---installation)
  - [3.2 - Konfiguration](#32---konfiguration)
    - [3.2.1 - Addons](#321---addons)
    - [3.2.2 - Markdown](#322---markdown)
- [4 - GIT](#4---git)
  - [4.1 - Github Account](#41---github-account)
  - [4.2 - Installation](#42---installation)
  - [4.3 - Bedienung (Konsole)](#43---bedienung-konsole)
  - [4.4 - Repository erstellen](#44---repository-erstellen)
  - [4.5 - SSH Key](#45---ssh-key)
- [5 - Projekt](#5---projekt)
  - [5.1 - Projekt Umfang](#51---projekt-umfang)
    - [Ziele:](#ziele)
  - [5.2 - Umgebung vorbereiten](#52---umgebung-vorbereiten)
  - [5.3 - Vagrantfile](#53---vagrantfile)
    - [5.2.1 - Json file](#521---json-file)
  - [5.4 Control Script](#54-control-script)
  - [5.5 Installations Scripts](#55-installations-scripts)
    - [5.5.1 Datenbank Server](#551-datenbank-server)
    - [5.5.2 Nextcloud Server](#552-nextcloud-server)
  - [5.6 - Funktion](#56---funktion)
    - [5.6.1 - Control script](#561---control-script)
    - [init](#init)
    - [deploy](#deploy)
    - [Start / Stop](#start--stop)
    - [list](#list)
    - [destroy](#destroy)
  - [5.7 - Testing](#57---testing)
    - [5.7.1 - Vorbereitung](#571---vorbereitung)
    - [5.7.2 - Init](#572---init)
    - [5.7.3 - Deploy](#573---deploy)
    - [5.7.4 - Start / Stop](#574---start--stop)
    - [5.7.4 - List](#574---list)
    - [5.7.5 - Destroy](#575---destroy)
- [6 - Quellen](#6---quellen)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>


# Einleitung
Da ich auf einem Ubuntu 21.04 arbeite, werde ich nur die Installations- und Konfigurationsmethoden dafür erklären.
# 1 - Virtualbox
## 1.1 - Installation
Um Virtualbox zu installieren, muss nur dieser Befehl ausgeführt werden.
```Shell
$ apt install virtualbox
```
# 2 - Vagrant
## 2.1 - Installation
Um Vagrant zu installieren, muss nur dieser Befehl ausgeführt werden.
```Shell
$ apt install Vagrant
```
### 2.2 - Bedienung
Übersicht der Befehle
| Befehl                    | Beschreibung                                                      |
| ------------------------- | ----------------------------------------------------------------- |
| `vagrant init`            | Initialisiert im aktuellen Verzeichnis eine Vagrant-Umgebung und erstellt, falls nicht vorhanden, ein Vagrantfile |
| `vagrant up`              | Erzeugt und Konfiguriert eine neue Virtuelle Maschine, basierend auf dem Vagrantfile |
| `vagrant ssh`             | Baut eine SSH-Verbindung zur gewünschten VM auf                   |
| `vagrant status`          | Zeigt den aktuellen Status der VM an                              |
| `vagrant port`            | Zeigt die Weitergeleiteten Ports der VM an                        |
| `vagrant halt`            | Stoppt die laufende Virtuelle Maschine                            |
| `vagrant destroy`         | Stoppt die Virtuelle Maschine und zerstört sie.                   |
### 2.3 - Enfache VM Erstellen
Um eine einfache VM zu erstellen, muss folgendes getan werden.\
Zuerst muss die Box heruntergeladen und hinzugefügt werden.
```Shell 
$ vagrant box add ubuntu/hirsute64 # Ubuntu 21.04 hinzufügen
```
Um die Box zu Initialisieren.
```Shell
$ mkdir ~/vagrant/box1
$ vagrant init ubuntu/hirsute64 # Ubuntu 21.04 box initialisieren
$ vagrant up # Box starten
```
Die Boxen könenn hier gefunden werden: https://app.vagrantup.com/boxes/search
### 2.4 - Vagrantfile
Das Vagrantfile befindet sich in dem Verzeichnis in dem der Befehl "__vagrant init \<box\>__" ausgeführt wurde.\
Ohne weitere Konfiguration sieht das Vagrantfile folgendermassen aus. (wenn alle Kommentare entfernt wurden).
```ruby 
Vagrant.configure("2") do |config|
  config.vm.box = "user/box"
end
```
Die vagrant VMs werden standartmässig in Virtualbox gestartet, solange man dies im Vagrantfile nicht ändert.

![img](images/Gh5bjp2.png)

Nach dem Editieren des Vagrantfiles, sollte folgender Befehl ausgeführt werden.

```Shell 
$ vagrant reload
``` 
Um der VM einen Hostname zu geben, muss das Vagrantfile folgendermassen editiert werden.\
(unter config.vm.box = "")

```ruby
config.vm.hostname = "deinHostname"
```

Um der VM eine IP Adresse zu geben, muss das Vagrantfile folgendermassen editiert werden.

```ruby
config.vm.network "private_network", ip: "10.9.8.7"
```

Um dinge wie z. B. RAM oder CPU einstellen zu können, muss dies in folgendem Block getan werden.

```ruby
config.vm.provider "virtualbox" do |vb|
  vb.name = "VM-NAME"
  vb.memory = 2048
  vb.cpus = 2
end
```

Um einen Port auf den Host weiter zu leiten, kann folgenes getan werden.\
In diesem Beispiel wird der Guest Port 80 auf den Host Port 8080 umgeleitet.

```ruby
config.vm.network "forwarded_port", guest:80, host:8080
```

Um ein Host Folder dem Guest zur verfügung zu stellen, kann folgendes in die Konfiguration geschrieben werden.\
Hier wird nun der Ordner "__data__", der sich im "__vagrant__" Verzeichnis befindet, auf "__/home/vagrant/data__" gemapt.

```ruby
config.vm.synced_folder "./data", "/home/vagrant/data"
```

Um bei der Installation einer VM automatisch Befehle ausführen zu lassen,\
muss folgender Bereich auskommentiert oder erstellt werden.\
Die einzelnen bash Befehle, können dann dazwischen geschrieben werden.

```ruby
config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   apt-get install -y apache2
SHELL
```

Um ganze Scripts auszuführen, kann folgender Befehl genutzt werden.

```ruby
config.vm.provision "shell", path: "script.sh"
```

### 2.5 - Mehrere VMs erstellen
Mit Vagrant ist es möglich mehrere Vms mit nur einem File zu erstellen, dies Zeige ich hier anhand eines Beispieles.

```shell
$ cd /path/to/vmstorage
$ mkdir multivm
$ cd multivm
$ vagrant init ubuntu/xenial64
```
```Shell
$ nano /path/to/vmstorage/multivm/Vagrantfile
```
```ruby
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64" # Select Boximage
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

Um die VMs zu starten.

```Shell 
$ vagrant up
$ vagrant up box1 # um nur eine der beiden zu starten
```

Nun laufen die beiden VMs und sie können auch miteinander kommunizieren.

![img](images/IAxxDO5.png)

Um eine der beiden VMs zu __kontrollieren__.

```Shell 
$ vagrant ssh box1
```

![img](images/5Nii12Y.png)

### 2.6 - Json
Das Vagrantfile kann Json files einlesen und damit viel dynamischer konfiguriert werden.

Hier ein Kleines Beispiel.

```shell
nano /path/to/vmstorage/multivm/Vagrantfile
```
```ruby
nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']
Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/focal64"
  nodes_config.each do |node| 
    node_name = node[0]
    node_values = node[1]
    config.vm.define node_name do |config|
      config.vm.hostname = node_name
      config.vm.network :private_network, ip: node_values['ip']
      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values['memory']] 
        vb.customize ["modifyvm", :id, "--name", node_name]
        vb.cpus = node_values['cpu']
      end
      config.vm.provision :shell, :path => node_values['script']
    end
  end
end
```

Das JSON file könnte folgendermassen aussehen.

```shell
nano /path/to/vmstorage/multivm/nodes.json
```
```json
{
  "nodes":{
    "node1":{
      "ip":"10.9.8.11",
      "memory":3072,
      "cpu":2,
      "script":"script1.sh",
    },
    "node2":{
      "ip":"10.9.8.12",
      "memory":1024,
      "cpu":1,
      "script":"script2.sh",
    }
  }
}
```

# 3 - Visual Studio Code
## 3.1 - Installation
Um VScode zu Installieren, muss folgendes getan werden.

```Shell 
snap install --classic code
```

## 3.2 - Konfiguration
### 3.2.1 - Addons
Um VScode für Markdown und GIT ready zu machen, habe ich folgende Addons installiert.
- __GitLens__ (Mit GitLens kann in einem File angezeigt werden wann was von wem und in welchem commit geändert oder hinzugefügt wurde.)

![img](images/uEKAgPI.png)

- __Markdown All in One__ (Markdown All in One fügt einige kleine shortcuts und optische verschönerungen zum README.md hinzu).
- __Code Spell checker__ German und English (Code Spell checker ist ein Grammatik und Rechtschreib überprüfung für vscode)<<w>><w>
  
### 3.2.2 - Markdown
Die Dokumentation ist als README.md gespeichert, so kann Github sie direkt im "root" path von "LB1" anzeigen.

![img](images/IAM67HJL.png)

Um diese mit Markdown geschriebene Dokumentation als ganzes anzuzeigen, bietet VSCode eine Funktion an.

![img](images/KMI89T5G.png)
# 4 - GIT
## 4.1 - Github Account
Um sich einen Github Account anzulegen, muss auf die Internetseite "github.com" navigiert werden.\
Hier kann dann oben rechts auf "Sign up" gedrückt werden.

![img](images/KvYvv17.png)

Jetzt müssen die Accountdaten angegeben werden.

![img](images/zkUnDB6.png)

Nun ist der Account erstellt.
## 4.2 - Installation
Git kann folgendermassen installiert werden.

```Shell 
$ apt install git
```
## 4.3 - Bedienung (Konsole)
```Shell 
$ git --version # Aktielle Git Version anzeigen
```
```Shell 
$ git config --global user.name "git_username" # Usernamen Setzen
```
```Shell 
$ git config --global user.email "e@mail.adresse" # E-Mail setzen
```
```Shell 
$ git clone <repository> # Repository Herunterladen / Klonen
```
```Shell 
$ git status # Status des aktuellen git Repository anzeigen.
```
```Shell 
$ git remote add <repository> <remote> # fügt einen Remote Git Server hinzu (beispiel: Github)
```
```Shell 
$ git pull <remote> <branch> # dateien von Remote Server pullen
```
```Shell 
$ git add . # Alle Dateien für den nächsten commit hinzufügen
```
```Shell 
$ git commit -m "commit Nachricht" # Dateien commiten
```
```Shell 
$ git push <remote> <branch> # dateien auf Remote Server pushen
```
## 4.4 - Repository erstellen
Um ein GitHub Repository zu erstellen, muss auf github.com navigiert werden.

Dort angekommen, kann oben rechts auf das "__+__" und dann "__New repository__" gedrückt werden.

![img](images/KI89JH6F.png)

![img](images/KM9864FG.png)

## 4.5 - SSH Key
Zuerst muss in der Konsole einen SSH Key erstellt werden.
```Shell 
$ ssh-keygen -t rsa -b 4096 # erstellt einen 4096 bytes langen RSA (SSH) key
Generating public/private rsa key pair.
Enter a file in which to save the key (~/.ssh/id_rsa): ~/.ssh/M300_key
Enter passphrase (empty for no passphrase): [Passwort]
Enter same passphrase again: [Passwort wiederholen]
```
Nachdem der Key erstellt wurde, muss er im Terminal mit folgendem Befehl angezeigt werden.

![img](images/y2RjRN1.png)
  
Der nun in der Konsole angezeigten Public Key muss kopiert werden.

Ist dieser Kopiert, kann auch schon auf GitHub fortgefahren werden.
  
![img](images/yMGMdSe.png)

![img](images/92RsF4D.png)

Den zuvor kopierten Public Key hier unter "__KEY__" Einfügen.\
Der Name kann frei gewählt werden.

![img](images/Rzy4krY.png)

Wenn der Key nun in Github eingetragen ist, muss er auf dem Lokalen PC noch mit dem Repository verbunden werden.

```Shell 
$ ssh git@github.com -T -i ~/.ssh/<dein KEY>
Hi User! Youve successfully authenticated, but GitHub does not provide shell access.
Connection to github.com closed.
```

Um deinen PC schonmal auf die Zukunft vorzubereiten, kann ein eintrag in der SSH Config gemacht werden.\
Diese befindet sich unter folgendem pfad.

```Shell 
nano ~/.ssh/config
```

Jetzt kann einfach folgender eintrag hinzugefügt werden.

```Shell 
Host github
    Hostname github.com
    User git
    IdentityFile ~/.ssh/keyfile
    IdentitiesOnly yes
```

Um nun das Git Repository lokal zu Spiegeln, muss folgendes gemacht werden.

```Shell
$ cd /pfad/zu/repository/
$ git init
$ git remote add origin https://github.com/<dein Username>/<dein GIT Repository>
$ git remote set-url github:<dein Username>/<dein GIT Repository> # github darf nur geschrieben werden, wenn der ssh config Eintrag gemacht wurde, sonnst git@github.com.
$ git pull origin master
```

# 5 - Projekt
## 5.1 - Projekt Umfang
Für die LB1 vom Modul 300 habe ich mich dafür entschieden, eine art Cloud für SaaS zu erstellen, mit der per Befehl automatisch Nextcloud Server deployed werden.

Da ich schon lange vor hatte, mich tiefer in Bash/Shellscript einzuarbeiten, habe ich diese möglichkeit direkt genutzt, und mich dazu entschieden, die "Cloud" mit Bash und Vagrant umzusetzen.

### Ziele:

- Es soll ein Bash Script erstellt werden, mit dem "die Cloud" über argumente gesteuert werden kann.
- Es soll einen "__init__" Befehl geben, mit diesem soll "die Cloud" erstellt werden.
- Es soll ein "__deploy__" Befehl geben, mit diesem soll "die Cloud" eine (oder mehrere) Nextcloud instanzen deployen.
- Es soll einen "__start__" und einen "__stop__" Befehl geben, mit diesem soll eine instanz gestoppt oder gestartet werden.
- Es soll einen "__destroy__" Befehl geben, mit diesem soll eine instanz oder die ganze Cloud zerstört/deinstalliert werden können.
- Es soll einen "__list__" Command geben, mit dem alle instanzen aufgelistet werden können.
## 5.2 - Umgebung vorbereiten
Zuerst habe ich das projekt Verzeichnis erstellt. 

```Shell 
$ mkdir ~/M300/LB1/Project/
$ cd ~/M300/LB1/Project/
$ vargrant box add ubuntu/focal64
$ vagrant init ubuntu/focal64
```

## 5.3 - Vagrantfile
Für dieses Projekt, werde ich ein Json file erstellen, indem alle Informationen über alle Nodes und Vms vorhanden sind.\
Durch dieses Json file kann sich das Vagrantfile die node Informationen von selbst eintragen, und mit diesen arbeiten.

```shell
$ nano ~/M300/LB1/Project/Vagrantfile
```
```ruby
# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

nodes_config = (JSON.parse(File.read("nodes.json")))['nodes'] # Select nodes

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/focal64" # Ubuntu 20.04

  nodes_config.each do |node| # Loop through all Nodes
    node_name = node[0] # name of node 
    node_values = node[1] # content/meta of node

    config.vm.define node_name do |config|
      # configures all forwarding ports in JSON array
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port, host:  port['host'], guest: port['guest'], id: port[':id']
      end

      config.vm.hostname = node_name
      config.vm.network :private_network, ip: node_values['ip'] # IP Adress

      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values['memory']] # set VM memory
        vb.customize ["modifyvm", :id, "--name", node_name] # set VM Name
        vb.cpus = node_values['cpu']
      end

      config.vm.provision :shell, :path => node_values['script'], args: node_values['args'] # set installation script
    end
  end
end
```
### 5.2.1 - Json file
Das Json file sieht direkt nach dem der Befehl "__./control init__" ausgeführt wurde, so aus.
```json 
{
  "nodes":{
    "dbs":{
      "description": "Database Server",
      "ip": "10.9.8.101",
      "ports":[],
      "memory": 3072,
      "cpu": 2,
      "script": "scripts/dbinstall.sh",
      "args":""
    }
  }
}
```
Nachdem mit dem Befehl "__./control deploy__" eine oder mehrere nodes erstellt wurden, könnte das Json File so aussehen.
```json
{
  "nodes": {
    "dbs": {
      "description": "Database Server",
      "ip": "10.9.8.101",
      "ports": [],
      "memory": 3072,
      "cpu": 2,
      "script": "scripts/dbinstall.sh",
      "args": ""
    },
    "node11": {
      "description": "nextcloud frontend",
      "ip": "10.9.8.11",
      "ports": [
        {
          "guest": 80,
          "host": 8011
        }
      ],
      "memory": 1024,
      "cpu": 2,
      "script": "scripts/ncinstall.sh",
      "args": "node11"
    },
    "node12": {
      "description": "nextcloud frontend",
      "ip": "10.9.8.12",
      "ports": [
        {
          "guest": 80,
          "host": 8012
        }
      ],
      "memory": 1024,
      "cpu": 2,
      "script": "scripts/ncinstall.sh",
      "args": "node12"
    }
  }
}
```
## 5.4 Control Script
Mit dem control script, wird die ganze "Cloud" kontrolliert, es können nodes erstellt, zerstört, gestartet und gestoppt werden.

__Wichtig__ ist noch zusagen, dass ich vor diesem Projekt nicht viel bash Erfahrung hatte, und ich dieses Projekt dazu genommen habe, um mich tiefer in bash einzuarbeiten. Es ist daher gut möglich das einige Konventionen oder best practice nicht umgesetzt wurden.
```bash
#!/bin/bash

# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

# Define Variables
JSONFILE="nodes.json"
DBS_IP="10.9.8.101"
DBS_USER="root"
DBS_PW="Password123"

# Define Shell colors
RED=`tput setaf 1`
GREEN=`tput setaf 2`
YELLOW=`tput setaf 3`
BLUE=`tput setaf 6`
RESET=`tput sgr0`

USAGE="${YELLOW}Usage: ${0} <init:deploy [amount]:destroy [node]:start <node>:stop <node>:list>${RESET}"
FRESHJSON="{\"nodes\":{\"dbs\":{\"description\":\"Database Server\",\"ip\":\"${DBS_IP}\",\"ports\":[],\"memory\":3072,\"cpu\":2,\"script\":\"scripts/dbinstall.sh\",\"args\":\"\"}}}"


# check if user is Root user
if [[ $UID -eq 0 ]]; then
    echo "${RED}You cant't be root, to use this script!${RESET}"
    exit 1
fi

####################################################################
# FUNCTIONS
####################################################################
# Check Node
checkNodeStatus () {
    NODE="$1" # Get node from argument 1
    TEST=$(vagrant status ${NODE}) # get the Vagrant status message
    # Define REGEX vars for the status
    REGEX1="${NODE} *running"
    REGEX2="${NODE} *poweroff"
    REGEX3="${NODE} *not *created"

   # Check the Status of the Nodes
    if [[ $TEST =~ $REGEX3 ]]; then 
	    return 3 # not created
    elif [[ $TEST =~ $REGEX2 ]]; then 
	    return 2 # poweroff
    elif [[ $TEST =~ $REGEX1 ]]; then 
	    return 1 # running
    else
	    return 0 # down / not found
    fi
}

# Stop Node
stopNode () {
    NODE=$1 # Get node from argument 1
    checkNodeStatus $NODE
    STATUS=$?
    if [[ $STATUS -ne 0 && $STATUS -ne 2 && $STATUS -ne 3 ]]; then # if node is running
        echo "${GREEN}Stopping node \"${NODE}\"${RESET}"
        vagrant halt $NODE
        exit 0 # success
    else 
        echo "${YELLOW}Node \"${NODE}\" is already stopped or does not exist.${RESET}"
        exit 1 # no success
    fi

}

# Start Node
startNode () {
    NODE=$1 # Get node from argument 1
    checkNodeStatus $NODE
    if [[ $? -eq 1 ]]; then # if node is not running
        echo "${YELLOW}Node \"${NODE}\" is already running.${RESET}"
        exit 1 # no success
    else 
        echo "${GREEN}Starting node \"${NODE}\"${RESET}"
        vagrant up $NODE
        exit 0 # success
    fi
}

# Deploy Nextcloud
deployNode () {
    AMOUNT=$1 # get Loop amount from argument 1
    REGEX='^[1-9]+$'
    if ! [[ $AMOUNT =~ $REGEX ]]; then # check if Amount is a numeric number
        AMOUNT=1 # else, set amount to 0
    fi
    echo "${BLUE}Deploying ${AMOUNT} Nodes${RESET}"
    OUTPUTARRAY=()
    COUNTER=0
    while [ $COUNTER -lt $AMOUNT ]; do # Loop Amount times through deployment
        IP_PREFIX="10.9.8." # make IP prefix
        PORT_PREFIX="80" # make Port Prefix

        NODES=($(jq '.nodes | keys | .[]' $JSONFILE)) # Get all active nodes from json

        NODES=("${NODES[@]:1}") # cut the first (Database Server) from array
        
        if [[ ${NODES[@]} != "" ]]; then # check if any node is in the json file
            NODEARRAY=()
            for string in ${NODES[@]}; do # loop through nodes
                OUTPUT=${string:5:1} # Cut node away and leve number
                NODEARRAY+=("${OUTPUT}") # Add node number to array
            done
            NUM=1
            EXITER=0
            while [[ NUM -eq 1 ]]; do # Loop through until new node number is found
                if [[ $EXITER -eq 0 ]]; then # check if new node number is found
                    NUMBER=$(shuf -i 11-99 -n 1) # Generate random number between 11 and 99
                    for NODE in ${NODEARRAY[@]}; do # Loop through nodes array
                        EXITER=0
                        if [[ $NUMBER -eq $NODE ]]; then # check if random number matches current node number
                            break # does match (BAD)
                        else 
                            EXITER=1 # does not match (GOOD)
                        fi
                    done
                else
                    NUM=0 # Found new not used node number
                fi
            done
        else
            # If no old VM is in the json file, generate a complete new id
            NUMBER=$(shuf -i 11-99 -n 1) # Generate random number between 11 and 99
        fi

        echo "${GREEN}Deploying...${RESET}"
        
        checkNodeStatus dbs
        STATUS=$?
        if [[ STATUS -eq 1 ]]; then # check if Database Server is Online

            # Define variables (Add new found node number to prefixes)
            IP="${IP_PREFIX}${NUMBER}"
            PORT="${PORT_PREFIX}${NUMBER}"
            NODE="node${NUMBER}"

            mysql -h $DBS_IP -u $DBS_USER -p$DBS_PW -e "CREATE DATABASE ${NODE};" # create new db for node
            echo "${GREEN}Created Database for ${NODE}"
            NEWNODE="{
                \"${NODE}\":{
                    \"description\":\"nextcloud frontend\",
                    \"ip\":\"${IP}\",
                    \"ports\":[
                        {
                            \"guest\":80,
                            \"host\":${PORT}
                        }
                    ],
                    \"memory\":1024,
                    \"cpu\":2,
                    \"script\":\"scripts/ncinstall.sh\",
                    \"args\":\"${NODE}\"
                }
            }" # generating new node json object
            echo $(jq --argjson NEWNODE "$NEWNODE" '.nodes += $NEWNODE' $JSONFILE) > $JSONFILE # overwriting  old json file with new informations

            vagrant up $NODE # start new node up

            echo "${GREEN}Deployed ${NODE}${RESET}"

            OUTPUTARRAY+=("${NODE}: http://localhost:${PORT} Username: ${BLUE}admin${RESET} Passwort: ${BLUE}Password123${RESET}") # Add information to Output array
        else
            # DB Server is not Online
            echo "${YELLOW}Warning! DB Server is Offline${RESET}"
            echo "${YELLOW}- Please do ${0} start dbs, or ${0} init.${RESET}"
            echo "${RED}Error! cant create new node"
        fi
        ((COUNTER++)) # increase counter +1
    done
    echo "${GREEN}All Nodes Deployed!${RESET}}"
    for NODE in ${OUTPUTARRAY[@]}; do
        echo "${NODE}"
    done
}

# Remove Nextcloud node
destroyNode () {
    NODE2=$1 # Get node from argument 1
    if [[ $NODE != "dbs" ]]; then # check if node is not the Database Server
        checkNodeStatus $NODE2
        STATUS=$?
        if [[ $STATUS -eq 1 || $STATUS -eq 2 || $STATUS -eq 3 ]]; then # check if node exists (cant destroy not existing node)
            echo "${GREEN}destroying ${NODE2}...${RESET}"
            checkNodeStatus "dbs"
            STATUS=$?
            if [[ STATUS -eq 1 ]]; then # Check if the Database server is Online
                mysql -h $DBS_IP -u $DBS_USER -p$DBS_PW -e "DROP DATABASE ${NODE2};" # Remove Database from node
            else
                echo "${YELLOW}DB Server is Offline${RESET}"
                echo "${YELLOW}cant remove ${NODE2}s Databse${RESET}"
            fi

            vagrant destroy $NODE2 # Destroy node
                
            FILTER=".nodes.${NODE2}" # adding node as jq filter
            echo $(jq "del($FILTER)" $JSONFILE) > $JSONFILE # Remove node from json file

            echo "${GREEN}Destroy Successful${RESET}"

        else
            echo "${RED}${NODE2} is not online.${RESET}"
        fi  
    else
        echo "${RED}Can't destroy ${NODE}${RESET}"
    fi
}

####################################################################
# SCRIPT
####################################################################

# Check if user is really in the Vagrant Folder
FOLDER=$(pwd)
read -p "${BLUE}Are you in the correct folder? \"${FOLDER}\". y or n: ${RESET}" ACCEPT # ask user if he is in the right folder
ACCEPT=$(echo $ACCEPT | tr a-z A-Z) # make $accept to uppercase
if [[ "${ACCEPT}" != "Y" ]]; then # check if user accepts
    echo "${RED}you have exited the script${RESET}"
    exit 1 # exit script if user don't says "Y"
fi

# Check if arguments are set
if [[ ${#} -eq 0 ]]; then
    echo "${RED}Not enough arguments. ${USAGE}${RESET}"
    exit 1
fi

# Init -----------------------------------------------------------------------------
if [[ "${1}" ==  "init" ]]; then
    # Only start init things
    echo "${GREEN}Create Init vagrant...${RESET}"
    echo $FRESHJSON > $JSONFILE  # restore nodes json file to defauts (just db Server)
    vagrant destroy -f # destroy all existant 
    checkNodeStatus dbs
    STATUS=$?
    if [[ $STATUS -eq 3 ]] # check if Database is not created
    then
        vagrant up dbs
    fi
# Start -----------------------------------------------------------------------------
elif [[ "${1}" ==  "start" ]]; then
# make option to start only the nodes or the nodes with db
    if [[ $# -ge 2 ]]; then
        startNode $2 # use specified node name to start
    else
        # if no node is given, exit
        echo "${RED}Not enough arguments. ${USAGE}${RESET}"
        exit 1
    fi
# Stop -----------------------------------------------------------------------------
elif [[ "${1}" ==  "stop" ]]; then
    # make option to stop only the nodes or the nodes with db
    if [[ $# -ge 2 ]]; then
        stopNode $2 # use specified node name to stop
    else
        # if no node is given, exit
        echo "${RED}Not enough arguments. ${USAGE}${RESET}"
        exit 1
    fi
# Deploy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "deploy" ]]; then
    if [[ $# -ge 2 ]]; then
        deployNode $2 # if a number is specified, use it
    else 
        deployNode 1 # if no number is specified, use 1
    fi
# Destroy -----------------------------------------------------------------------------
elif [[ "${1}" ==  "destroy" ]]; then
    if [[ $# -ge 2 ]]; then
        # if a node is specified, destroy this node
        destroyNode $2
    else
        # if no args, destoy all
        vagrant destroy -f # Destroy all machines and nodes
        echo $FRESHJSON > $JSONFILE # restore nodes json file to defauts (just db Server)
    fi
# List -----------------------------------------------------------------------------
elif [[ "${1}" ==  "list" ]]; then
    echo "${GREEN}listing items...${RESET}"
    NODES=($(jq '.nodes | keys | .[]' $JSONFILE)) # Select all nodes
    NODES=("${NODES[@]:1}") # cut the first (Database Server) from array
    if [[ ${#NODES[@]} -eq 0 ]]; then
        echo "${RED}No Nodes found!${RESET}"
        exit 1
    fi
    echo "${GREEN}There are ${BLUE}${#NODES[@]}${GREEN} nodes${RESET}" # List amount of nodes
    for NODE in ${NODES[@]}; do # Loop through all elements
        # Get Elements from json file
        DESCRIPTION=$(jq -r ".nodes.${NODE}.description" $JSONFILE)
        IP=$(jq -r ".nodes.${NODE}.ip" $JSONFILE)
        PORT=$(jq -r ".nodes.${NODE}.ports | .[].host" $JSONFILE )
        
        # Get Status of node
        NODE=${NODE:1:6} # cut away '"'
        checkNodeStatus $NODE name
    	STATUS=$?
    	if [[ $STATUS -eq 3 ]]; then 
	        STATUS="${YELLOW}not created${RESET}"
        elif [[ $STATUS -eq 2 ]]; then 
            STATUS="${RED}poweroff${RESET}"
        elif [[ $STATUS -eq 1 ]]; then 
            STATUS="${GREEN}running${RESET}"
        else
            STATUS="${RED}unknown${RESET}"
        fi
        
        # Display Node
        echo "${BLUE}${NODE}${RESET}"
        echo "${BLUE}Status: ${YELLOW}${STATUS}${RESET}"
        echo "${BLUE}Description: ${YELLOW}${DESCRIPTION}${RESET}"
        echo "${BLUE}IP: ${YELLOW}${IP}:${PORT}${RESET}"
        echo "${BLUE}Local: ${YELLOW}http://localhost:${PORT}${RESET}"
        echo "------------------------------------------------------------------"
    done
# Else -----------------------------------------------------------------------------
else
    # Display this message if no argument matches
    echo "${RED}Wrong arguments. ${USAGE}${RESET}"
fi
```

## 5.5 Installations Scripts
### 5.5.1 Datenbank Server
Mit diesem script wird der Datenbankserver gestartet.
```bash
#!/bin/bash

# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

## Define vars
MYSQL_ROOT_PW="Password123"

## Installation
apt update -y
#apt upgrade -y

apt install mariadb-server mariadb-client -y

sed -e '/bind-address            = 127.0.0.1/ s/^#*/#/' -i /etc/mysql/mariadb.conf.d/50-server.cnf # comment out the bind adress, to open it to public
systemctl restart mariadb

## Install / Configure MariaDB
mysql -e "UPDATE mysql.user SET plugin='mysql_native_password' WHERE User='root';" # make shure the user can login, with the right plugin
mysql -e "UPDATE mysql.user SET Password = PASSWORD('${MYSQL_ROOT_PW}') WHERE User = 'root';" # Set a password for The root user
mysql -e "DROP USER IF EXISTS ''@'localhost';" # Remove the Anonymous User
mysql -e "DROP USER IF EXISTS ''@'$(hostname)';"
mysql -e "DROP DATABASE IF EXISTS test;" # Remove the Demo database
mysql -e "UPDATE mysql.user SET Host='%' WHERE User='root';"

mysql -e "FLUSH PRIVILEGES;"
```
### 5.5.2 Nextcloud Server
Mit diesem script werden die Nextcloud Server gestartet.
```bash
#!/bin/bash

# (c) Aaron Gensetter, 2021
# Part from "Ultra Bad Cloud (UBC)"

## Check if some args are given
if [[ $# -eq 0 ]]
then
    echo "exit"
    exit 1
fi

## Define vars
# Nextcloud
NEXTCLOUD_LINK="https://download.nextcloud.com/server/releases/nextcloud-21.0.2.zip"
NEXTCLOUD_ADMIN_USER="admin"
NEXTCLOUD_ADMIN_PW="Password123"

# Database
MYSQL_HOST="10.9.8.101"
MYSQL_USER="root"
MYSQL_PW="Password123"

## Installation
apt update -y 
#apt upgrade -y

apt install unzip -y
apt install apache2 apache2-utils -y
systemctl start apache2
systemctl enable apache2
apt install imagemagick php-imagick libapache2-mod-php7.4 php7.4-common php7.4-mysql php7.4-fpm php7.4-gd php7.4-json php7.4-curl php7.4-zip php7.4-xml php7.4-mbstring php7.4-bz2 php7.4-intl php7.4-bcmath php7.4-gmp -y # Install needed PHP modules
a2enmod php7.4 # enable php
systemctl restart apache2
rm /var/www/html/index.html
wget "${NEXTCLOUD_LINK}" # Download Nextcloud
unzip nextcloud*.zip -d /var/www/html # Unpack Nextcloud
cp /var/www/html/nextcloud/* /var/www/html -R
rm /var/www/html/nextcloud -R
chown www-data:www-data /var/www/html/ -R

su -l www-data -s /bin/bash -c "php /var/www/html/occ maintenance:install --database 'mysql' --database-host '${MYSQL_HOST}' --database-name '${1}' --database-user '${MYSQL_USER}' --database-pass '${MYSQL_PW}' --admin-user '${NEXTCLOUD_ADMIN_USER}' --admin-pass '${NEXTCLOUD_ADMIN_PW}'" # Configure/Install Nextcloud

```

## 5.6 - Funktion
### 5.6.1 - Control script
Funktionen des Control Scripts.
### init
```shell
./control.sh init
```
Wenn der "__init__" Befehl ausgeführt wird, passiert folgendes.

1. Das __nodes.json__ file wird zurückgesetzt (so dass nur der Datenbank Server eingetragen ist).
2. Alle laufenden VMs werden zerstört.
3. Der Datenbankserver wird erstellt und hochgefahren.

Nach dem ausführen des init Befehls, ist mit dem "__vagrant status__" command folgendes zu sehen:

![img](images/ESy4krL.png)

### deploy
```shell
./control.sh deploy
```

Wenn der "__deploy__" Befehl ausgeführt wird, passiert folgendes.

1. Da keine anzahl mitgegeben wurde, wird nur eine instanz erstellt.
2. Es wird eine zufallszahl zwischen 11 und 99 erstellt (es wird darauf überprüft dass diese node nicht schon vorhanden ist).
3. Es wird auf dem Datanbank Server eine Datenbank erstellt.
4. Die Node wird in das json file eingetragen.
5. Die instanz wird gestartet.
6. Die Instanz informationen werden ausgegeben.

```shell
./control.sh deploy 3
```

Wenn der "__deploy__" Befehl mit einer anzahl ausgeführt wird, passiert folgendes.

1. Da eine anzahl mitgegeben wurde, werden so viele instanzen erstellt wie angegeben.
   1. Es wird eine zufallszahl zwischen 11 und 99 erstellt (es wird darauf überprüft dass diese node nicht schon vorhanden ist).
   2. Es wird auf dem Datanbank Server eine Datenbank erstellt.
   3. Die Node wird in das json file eingetragen.
   4. Die instanz wird gestartet.
2. Die Instanz informationen werden ausgegeben.

Am ende des deployen, werden nochmals alle Daten der gerade erstellten instanzen augegeben.

![img](images/4MKF04K.png)
### Start / Stop
```shell
./control.sh stop node1
```

Wenn der "__stop__" Befehl ausgeführt wird, passiert folgendes.

1. Es wird überpfüft ob die VM läuft.
2. Falls sie läuft, wird sie gestoppt.

```shell
./control.sh start node1
```

Wenn der "__start__" Befehl ausgeführt wird, passiert folgendes.

1. Es wird überpfüft ob die VM gestoppt ist, oder nicht erstellt wurde.
2. Falls sie nicht läuft oder noch nicht erstellt wurde, wird sie gestartet.
### list
```shell
./control.sh list
```

Wenn der "__list__" Befehl ausgeführt wird, passiert folgendes.

1. Alle nodes werden vom json file ausgelesen.
2. Der Datenbankserver wird ausgelassen.
3. Die Nodes werden ausgegeben.

Das ganze sieht dann folgendermassen aus.

![img](images/MK879Lp0.png)

Bei virtualbox sieht dass dann so aus.

![img](images/JN78F45S.png)

Der "__vagrant status__" output ist folgendermassen.

![img](images/AMK09LOP.png)

Wenn noch keine nodes vorhanden sind, ist der Output folgendermassen.

![img](images/y9G8dSe.png)

### destroy
```shell
./control.sh destroy node1
```

Wenn der "__destroy__" Befehl mit einer node als argument ausgeführt wird, passiert folgendes.

1. Da mit einem argument eine node mitgegeben wurde, wird nur diese zerstört.
2. Es wird überprüft ob die node existiert
3. Wenn die Node existiert, wird die Datenbank gelöscht
4. Die Node wird zerstört
5. Die Node wird aus dem Json file gelöscht

```shell
./control.sh destroy
```

Wenn der "__destroy__" Befehl ausgeführt wird, passiert folgendes.

1. Da keine node mitgegeben wurde, wird alles zerstört inkl. Datanbank Server.
2. Alle Server werden heruntergefahren und gelöscht.
3. Das __nodes.json__ file wird zurückgesetzt (so dass nur der Datenbank Server eingetragen ist).
## 5.7 - Testing
### 5.7.1 - Vorbereitung
Als erstes, muss das Verzeichniss vorbereitet werden.\
Ist das Verzeichnis bereit, kann das Git Repo geklont werden.

```shell
$ cd ~/M300/Vagrant
$ mkdir LB1
$ cd LB1
$ git clone git@github.com:AaronGen/M300-Services.git; cp M300-Services/LB1/UBC/* ./ -R; rm M300-Services -R # Klont das Repo, Kopiert nur das was gebraucht wird, löscht den rest.
```
![img](images/EFG67J8K.png)

Um das Script nun ausführbar zu machen.
```shell
$ chmod +x control.sh 
```

### 5.7.2 - Init
Um die Cloud das erste mal zu Starten, muss folgender Befehl aufgeführt werden.

```shell
$ ./control init
```

![img](images/JM986GH5.png)

Wenn nun mit Vagrant nachgeschaut wird, sieht man, nur die Datenbank VM läuft.

![img](images/LK09H76D.png)

Das gleiche Bild, in VirtualBox.

![img](images/IM6GARE7.png)

### 5.7.3 - Deploy
Um nun endlich Nextcloud Instanzen zu erstellen, brauchen wir den Deploy Befehl.

Zuerst testen wir das Deployen von nur einer Nextcloud.

```shell
$ ./control deploy
```

![img](images/IBD8HM8I.png)

[...]

![img](images/A2S3EXU9.png)

Wenn man mit "__Vagrant status__" nachschaut, sieht man folgendes.

![img](images/LPO98JH5.png)

Die Virtuellen machienen sind auch bei Virtualbox zu sehen.

![img](images/KI985GTF.png)

Wenn jetzt im Browser auf die nach dem deployen angezeigte Adresse navigiert wird, sieht man die Nextcloud.

![img](images/IH9A2T2E.png)

Jetzt können wir auch schon das Deployen von mehreren Nextclouds testen.

```shell
$ ./control deploy 3
```

![img](images/L9JU76G.png)

[...]

![img](images/98JZG6FT.png)

Wenn man mit "__Vagrant status__" nachschaut, sieht man folgendes.

![img](images/LKI96G7H.png)

Die Virtuellen machienen sind auch bei Virtualbox zu sehen.

![img](images/OIKJ89HH.png)

Wenn jetzt im Browser auf die nach dem deployen angezeigten Adressen navigiert wird, sieht man die Nextclouds.

![img](images/NCI89H6G.png)

### 5.7.4 - Start / Stop
Um die einzelnen nodes unabhängig von einander zu starten und stoppen, gibt es die "__Start__ / __Stop__" Befehle.

Bevor eine node gestoppt wurde, sieht der output von "__Vagrant status__" folgendermassen aus.

![img](images/LKI96G7H.png)

Bevor die node gestoppt wurde, sieht es in Virtualbox so aus.

![img](images/OIKJ89HH.png)

```shell
$ ./control stop node97
```

![img](images/ERROR404.png)

Nachdem eine node gestoppt wurde, sieht der output von "__Vagrant status__" folgendermassen aus.

![img](images/17HZN87J.png)

Nachdem die node gestoppt wurde, sieht es in Virtualbox so aus.

![img](images/L0987HZU.png)

Nun können wir die node wieder Starten.

```shell
$ ./control start node97
```

![img](images/KLI8976G.png)

Nachdem die node gestartet wurde, sieht der output von "__Vagrant status__" folgendermassen aus.

![img](images/LKI96G7H.png)

Nachdem die node gestartet wurde, sieht es in Virtualbox so aus.

![img](images/OIKJ89HH.png)

### 5.7.4 - List

Um alle nodes aufzulisten gibt es den Befehl __list__.\
Wenn wir den __list__ Befehl nutzen, werden alle aktiven nodes aus dem json file geladen.

In __VirtualBox__ sieht es so aus.

![img](images/JN78F45S.png)

__Vagrant status__ gibt folgenden Output.

![img](images/AMK09LOP.png)

Wenn wir nun den List Befehl nutzen, gibt er folgendes aus.

```shell
$ ./control list
```

![img](images/MK879Lp0.png)

Sollten Keine nodes vorhanden sein, wird folgendes ausgegeben.

![img](images/y9G8dSe.png)

### 5.7.5 - Destroy

Wenn nun eine oder alle nodes Zerstört werden sollen, kann der Befehl __destroy__ verwendet werden.

Wen man eine node zerstören will, kann man diesen Befehl nutzen.

```shell
$ ./control destroy node97
```

![img](images/LK985G4D.png)

Wenn wir nun mit dem Befehl __list__  nachschauen.

```shell
$ ./control list
```

![img](images/JHR56DR3.png)

Wenn wir nun alls zerstören wollen, können wir diesen Befehl verwenden.

```shell
$ ./control destroy
```

![img](images/0LPO2GH3.png)

Das json file sieht nun wieder frisch aus.

![img](images/KHG65DT7.png)

In der Liste werden nun auch keine mehr angezeigt.

![img](images/y9G8dSe.png)

# 6 - Quellen

- Udemy (Shell script parts): https://www.udemy.com/course/linux-shell-scripting-projects/ [10.06.2021]
- MC-B github: https://github.com/mc-b/M300/tree/master [10.6.2021]
- Inhaltsverzeichnis: https://ecotrust-canada.github.io/markdown-toc/ [11.6.2021]

<br><br>

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">
<img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/3.0/ch/88x31.png" />
</a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">Creative Commons Namensnennung - Nicht-kommerziell - Weitergabe unter gleichen Bedingungen 3.0 Schweiz Lizenz</a>