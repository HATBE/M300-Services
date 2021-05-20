# Einleitung allgemein
Einleitung allgemein (Erklärungen zum ganzen M300-Projekt)

Aufgaben: https://github.com/mc-b/M300/tree/master/10-Toolumgebung

# 10-Toolumgebungen

## 01 - Git
### 01.1 - Github Account


1. Auf www.github.com ein Benutzerkonto erstellen (Angabe von Username, E-Mail und Passwort)
2. E-Mail zur Verifizierung des Kontos bestätigen und anschliessend auf GitHub anmelden


Github account erstellt: https://github.com/AaronGen

### 01.2 - Repository

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
### 01.3 - SSH-KEY

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

### 01.4 - Git
<b>Installieren</b>\
<b>Linux</b>

```Shell 
apt install git
```
<b>Windows</b>

Wenn Git unter Windows Installiert werden soll "Would not recommend", hier downloaden -> https://git-scm.com/downloads

<b>Konfiguration</b>

```Shell 
$ git config --global user.name "<username>"
$ git config --global user.email "<e-mail>"
```
## 02 - Virtualbox
### 02.1 - Installation
<b>Linux</b>
```Shell 
$ apt install virtualbox
```
<b>Windows</b>

Folgendes File Installieren und dem Wizzard folgen\
-> https://download.virtualbox.org/virtualbox/6.1.22/VirtualBox-6.1.22-144080-Win.exe

### 02.2 - VM erstellen
Daten: 
Name: M300_Ubuntu_20.04_Desktop\
Typ: Linux x64\
RAM: 2048 MB\
Festplatte: 10 GB\
Festplatten Typ: VMDK → dynamisch alloziert

### 02.3 VM Konfigurieren
Updaten und Upgraden
```Shell 
$ apt update
$ apt upgrade -y
```
Synaptic Installieren
```Shell 
$ apt install synaptic
```

## 03 - Vagrant
### 03.1 - Installation
<b>Linux</b>

```Shell 
apt install vagrant
```

<b>Windows</b>\
Auf folgenden Link drücken, Downloaden und dem Wizzard folgen:\
d


# 20-Infrastruktur
Text

# 35-Sicherheit 1
Text

# 30-Container
Text

# 35-Sicherheit 2
Text

# 40-Container-Orchestrierung
Text

# 50-Add-ons
Eigene Ergänzungen erwünscht

# 60-Reflexion
Lernprozess festgehalten, Form frei wählbar)


- - -
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/3.0/ch/88x31.png" /></a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">Creative Commons Namensnennung - Nicht-kommerziell - Weitergabe unter gleichen Bedingungen 3.0 Schweiz Lizenz</a>

- - -