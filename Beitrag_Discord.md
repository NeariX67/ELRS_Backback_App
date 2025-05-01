# App zur Darstellung von ELRS Telemetriedaten

Nach langer Zeit im Hobby habe ich nun die Entscheidung getroffen auf ELRS umzusteigen. Während der Recherche um ELRS, ist mir ein Feature besonders aufgefallen: ["ELRS Backpack"](https://www.expresslrs.org/hardware/backpack/esp-backpack/).

## Was ist ELRS Backpack?

ELRS Backpack wird dazu genutzt Telemetriedaten die von der Funke empfangen werden, an andere Geräte weiterzuleiten. Genutzt wird sowas Beispielsweise für Analoge Empfänger, wo der Kanal automatisch anhand der Telemetriedaten eingestellt wird. Oder auch eine Groundstation mit automatischer Ausrichtung für maximalen Antennenempfang. Hier wird die GPS Position des UAV genutzt um die Antennen in Richtung des UAVs zu drehen.

## blabla

Ich möchte mir hingegen eine App schreiben, die alle wichtigen Telemetriedaten hübsch und übersichtlich darstellt. Aber für den Anfang reicht es mir erstmal, wenn Informationen wie Beispielsweise Koordinaten, Batteriespannung und Höhe angezeigt werden. Der Rest wird dann nach und nach umgesetzt. Die App werde ich übrigens mit Flutter :flutter: programmieren.

## Wie komme ich an die Telemetriedaten?

Unterstützte ELRS Funken kommunizieren ihre Telemetriedaten über das sogenannte "ESPNOW"-Protokoll. Dies wurde von Espressif entworfen und bentutzt genauso wie WLAN das 2.4GHz Frequenzband zur Kommunikation. Die Kommunikation kann jedoch nur zwischen  ESP8266 oder ESP32 stattfinden. Da die Funke bereits einen dieser Mikrokontroller hat, benötigt man also nur noch einen weiteren Mikrocontroller damit die Telemetriedaten empfangen werden können. Dieser Mikrokontroller muss dann per USB an das Endgerät angeschlossen werden, damit die Daten dann von der App ausgelesen werden können.

## Auf welchen Geräten kann die App laufen?

Prinzipiell kann ich die App für iOS, Android, Windows, MacOS und Linux zur Verfügung stellen (sobald sie fertig ist). Als Apple-Fanboi muss ich jedoch zugeben, dass Apple uns in diesem Falle ein Strich durch die Rechnung macht, da man auf iOS Geräten nicht auf die USB-Schnittstelle zugreifen kann. iPhones und iPads fallen hier also raus. Android, MacOS und Windows bleiben jedoch im Spiel. Für Linux bin ich mir noch unsicher, ob dort die App funktionieren würde.

## Software für den Mikrokontroller (ESP8266/ESP32)

Der Mikrokontroller muss natürlich auch noch programmiert werden. Denn dieser braucht eine "private UID", berechnet aus der MAC-Addresse der Funke und deiner Binding-Phrase. Diese private UID ist 6 Bytes lang und muss dann in der App konfiguriert werden. Diese ermöglicht dann dem Mikrokontroller zu wissen, mit welchem Gerät er sich verbinden muss, um die Telemetriedaten zu empfangen und ist quasi wie das Binding zwischen Funke und Receiver.
Die Software muss dann also einerseits sich mit der Funke verbinden können, als auch dann die empfangenden Telemetriedaten an die App weiterleiten.
