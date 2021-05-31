# Einleitung
Einleitung zum LB1 Projekt (Erklärungen)

Info
- Ich arbeite in Ubuntu 21.04
- 

# 1 - Virtualbox
## 1.1 - Installation
Da ich auf Linux arbeite, kann ich dies mit nur einem befehl Installieren.

```Shell
$ apt install virtualbox
```
# 2 - Vagrant
## 2.1 - Installation
Um Vagrant zu Installieren muss folgendes gemacht werden.

```Shell
$ apt install Vagrant
```

### 2.2 - Einfache Bedienung

Übersicht der Befehle
| Befehl                    | Beschreibung                                                      |
| ------------------------- | ----------------------------------------------------------------- |
| `vagrant init`            | Initialisiert im aktuellen Verzeichnis eine Vagrant-Umgebung und erstellt, falls nicht vorhanden, ein Vagrantfile |
| `vagrant up`              |  Erzeugt und Konfiguriert eine neue Virtuelle Maschine, basierend auf dem Vagrantfile |
| `vagrant ssh`             | Baut eine SSH-Verbindung zur gewünschten VM auf                   |
| `vagrant status`          | Zeigt den aktuellen Status der VM an                              |
| `vagrant port`            | Zeigt die Weitergeleiteten Ports der VM an                        |
| `vagrant halt`            | Stoppt die laufende Virtuelle Maschine                            |
| `vagrant destroy`         | Stoppt die Virtuelle Maschine und zerstört sie.                   |

### 2.3 - Enfache VM Erstellen
Um eine einfache VM zu erstellen, muss folgendes getan werden.

Als erstes, muss die Box heruntergeladen und hinzugefügt werden.
```Shell 
$ vagrant box add ubuntu/hirsute64 # Ubuntu 21.04 hinzufügen
```
Um die Box zu Initialisieren.
```Shell
$ mkdir ~/vagrant/box1
$ vagrant init ubuntu/hirsute64 # Ubuntu 21.04 box Initialisieren
$ vagrant up
```
Die Boxen könenn hier gefunden werden: https://app.vagrantup.com/boxes/search

### 2.4 - Vagrantfile
Das Vagrantfile befindet sich in dem Verzeichnis in dem der Befehl "vagrant init <box>" ausgeführt wurde.\
Ohne Weitere Konfiguration sieht es folgendermassen aus.
```Shell 
Vagrant.configure("2") do |config|
  config.vm.box = "user/box"
end
```
Die vagrant VMs werden standartmässig in Virtualbox laufen gelassen, solange man dies im Vagrantfile nicht ändert.\
<img src="images/Gh5bjp2.png">

Nach dem Editieren des vagrantfiles, muss folgender befehl ausgeführt werden
```Shell 
$ vagrant reload
``` 

Um der VM einen Hostname zu geben, muss das vagrantfile folgendermassen editiert werden.\
unter config.vm.box = ""
```Shell 
config.vm.hostname = "deinHostname"
```

Um der VM eine IP Adresse zu geben,  muss das vagrantfile folgendermassen editiert werden.
```Shell 
config.vm.network "private_network", ip: "10.9.8.7"
```

Um bei der Installation einer VM automatisch Befehle ausführen zu lassen, muss folgender Bereich auskommentert werden.\
Die einzelnen bash Befehle, können dann dazwischen geschrieben werden.
```Shell
config.vm.provision "shell", inline: <<-SHELL
   apt-get update
   apt-get install -y apache2
SHELL
```
### 2.5 - Mehrere Vms erstellen
Um mit einem Vagrantfile mehrere Vms zu erstellen, muss folgenes unternommen werden.

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
# 1000 - Quellen

















## Service-Aufbau 
Text

## Umsetzung
Text

## Testing
Text

## Quellen
Text