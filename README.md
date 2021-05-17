# Einleitung allgemein
Einleitung allgemein (Erklärungen zum ganzen M300-Projekt)

Aufgaben: https://github.com/mc-b/M300/tree/master/10-Toolumgebung

#  <span style="color:#3c52c1">10-Toolumgebungen </span>

## <span style="color:#3c52c1">01 - GitHub</span>
### <span style="color:#3c52c1">01.1 Account</span>


1. Auf www.github.com ein Benutzerkonto erstellen (Angabe von Username, E-Mail und Passwort)
2. E-Mail zur Verifizierung des Kontos bestätigen und anschliessend auf GitHub anmelden


Github account erstellt: https://github.com/AaronGen

### <span style="color:#3c52c1">01.2 Repository</span>

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


### <span style="color:#3c52c1">01.3 SSH-KEY</span>
<br>
    Zuerst muss in der Konsole einen SSH Key erstellt werden
</br>

```Shell 
$ ssh-keygen -t rsa -b 4096

Generating public/private rsa key pair.
Enter a file in which to save the key (~/.ssh/id_rsa): ~/.ssh/M300_key
Enter passphrase (empty for no passphrase): [Passwort]
Enter same passphrase again: [Passwort wiederholen]
```
<br>
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

# <span style="color:#3c52c1">20-Infrastruktur</span>
Text

# <span style="color:#3c52c1">35-Sicherheit 1</span>
Text

# <span style="color:#3c52c1">30-Container</span>
Text

# <span style="color:#3c52c1">35-Sicherheit 2</span>
Text

# <span style="color:#3c52c1">40-Container-Orchestrierung</span>
Text

# <span style="color:#3c52c1">50-Add-ons</span>
Eigene Ergänzungen erwünscht

# <span style="color:#3c52c1">60-Reflexion</span>
Lernprozess festgehalten, Form frei wählbar)


- - -
<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/"><img alt="Creative Commons Lizenzvertrag" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/3.0/ch/88x31.png" /></a><br />Dieses Werk ist lizenziert unter einer <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/3.0/ch/">Creative Commons Namensnennung - Nicht-kommerziell - Weitergabe unter gleichen Bedingungen 3.0 Schweiz Lizenz</a>

- - -