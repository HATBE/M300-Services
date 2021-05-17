# Einleitung allgemein
Einleitung allgemein (Erklärungen zum ganzen M300-Projekt)

Aufgaben: https://github.com/mc-b/M300/tree/master/10-Toolumgebung

# 10-Toolumgebungen

## 01 - GitHub
### 01.1 Account


1. Auf www.github.com ein Benutzerkonto erstellen (Angabe von Username, E-Mail und Passwort)
2. E-Mail zur Verifizierung des Kontos bestätigen und anschliessend auf GitHub anmelden


Github account erstellt: https://github.com/AaronGen

### 01.2 Repository

Repository erstellen
1. Anmelden unter www.github.com
2. Innerhalb der Willkommens-Seite auf Start a project klicken
3. Unter Repository name einen Name definieren (z.B. M300-Services)
4. Optional: kurze Beschreibung eingeben
5. Radio-Button bei Public belassen
6. Haken bei Initialize this repository with a README setzen
7. Auf Create repository klicken

<b>Name</b>: M300-Services
<br>
<b>Description:</b> Microservices / Containerumgebung
<br>
<b>Status:</b> Private
<br>

Reposoory Klonen
```Shell
$ git clone <Repository>
```


### 01.3 SSH-KEY

Zuerst muss in der Konsole einen SSH Key erstellt werden
</br>

```Shell 
$ ssh-keygen -t rsa -b 4096

Generating public/private rsa key pair.
Enter a file in which to save the key (~/.ssh/id_rsa): ~/.ssh/M300_key
Enter passphrase (empty for no passphrase): [Passwort]
Enter same passphrase again: [Passwort wiederholen]
```

Nachdem der Key erstellt wurde, muss er im Terminal angezeigt werden, dies muss mit folgendem Befehl getan werden.
<br>
<img src="images/y2RjRN1.png">
<br>
Wenn der Public key nun in der Konsole angezeigt wird, diesen Kopieren.
<br>
<img src="images/yMGMdSe.png">

<img src="images/92RsF4D.png">
<br>
Den zuvor kopierten Public Key hier unter KEY Pasten.<br>
Der Name kann frei gewählt werden.
<br>
<img src="images/Rzy4krY.png">

Wenn der Key nun in Github eingetragen ist, muss er auf dem Lokalen PC noch mit dem Repository verbunden werden.

```Shell 
$ ssh git@github.com -T -i ~/.ssh/<dein KEY>
Hi User! You've successfully authenticated, but GitHub does not provide shell access.
Connection to github.com closed.

$ cd /pfad/zu/repository
$ git init
$ git remote add origin https://github.com/<dein Username>/<dein GIT Repository>
$ git remote set-url git@github.com:<dein Username>/<dein GIT Repository>
$ git pull origin master
```

### 01.4 Git Installieren
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