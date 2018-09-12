# Invote-Bot
ein Bot für das Invote-System der TU Dresden (http://tud.invote.de)

Dieser Bot kann automatisch beliebig viele Antworten an eine Invote-Umfrage schicken. Das ist ist in der Regel ziemlich lustig, wenn es so aussieht, als wenn der ganze Hörsaal keine Ahnung von der richtigen Antwort hat und der Professor deswegen ziemlich verzeifelt.

## Benutzung
Ich habe den Bot für OSX geschrieben, er sollte eigentlich aber auch auf Linux funktionieren. Er braucht zwingend das Programm `hxselect`, was von [https://www.w3.org/Tools/HTML-XML-utils/](https://www.w3.org/Tools/HTML-XML-utils/) heruntergeladen und kompiliert werden kann.

Hat man `hxselect` kompiliert, so muss man es nach `~/bin` kopieren (oder einfach das Skript anpassen).

Das Skript erwartet als erstes Argument die Umfrage-ID. Wenn die Umfrage unter https://tud.invote.de/36492 erreichbar ist, dann ist 88915 die Umfrage-ID, und das Skript kann dann im Terminal mit  `sh invote_bot.sh 36492` gestartet werden.
