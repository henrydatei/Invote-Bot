#!/usr/bin/env bash

umfrageid=$1
start=$(echo $RANDOM)

link=$(echo "https://tud.invote.de/$umfrageid")
curl $link >> seite.txt

ueberschrift=$(cat seite.txt | ~/bin/hxselect -s "\n" h2 | head -n 1 | ~/bin/hxselect -c h2)

frage=$(cat seite.txt | ~/bin/hxselect -s "\n" -c p.mc | ~/bin/hxselect -c strong | head -n 2 | tail -n 1 | sed -e 's/^[[:space:]]*//')

curl $link | ~/bin/hxselect -s "\n" -c p.antwort.mc >> antworten.txt
anzahl=$(cat antworten.txt | wc -l | tr -d '[:space:]')
declare -a antwortbuchstabe
declare -a antwortArray
declare -a values
for (( i = 1; i <= $anzahl; i++ )); do
  antwortbuchstabe[$i]=$(cat antworten.txt | head -n $i | tail -n 1 | ~/bin/hxselect -c strong)
  values[$i]=$(cat antworten.txt | head -n $i | tail -n 1 | grep "antwort" | awk -F"\"" '{print $6}')
  antwortArray[$i]=$(cat antworten.txt | head -n $i | tail -n 1 | ~/bin/hxselect -c label | cut -d " " -f2)
done

clear

echo "================================= Invote - Bot ================================="
echo "written by: Henry Haustein"
echo "version: 2.0"
echo ""
echo "Umfrage-ID: $umfrageid, Link: $link"
echo ""
echo "Frage: $frage"
echo ""
for (( i = 1; i <= $anzahl; i++ )); do
  echo "$i: ${antwortArray[$i]}"
done
echo ""

echo "Für welche Antwort soll gestimmt werden?"
read spamZahl
echo "Wie viele sollen abstimmen?"
read spamAnzahl

antwort=$(echo ${values[$spamZahl]})

echo "Es wird für ${antwortbuchstabe[$spamZahl]}: ${antwort[$spamZahl]} $spamAnzahl mal gestimmt."

for (( i = $start; i < $start+$spamAnzahl; i++ )); do
  curl --data "antwort=$antwort" --data "antwortort+senden" https://tud.invote.de/$umfrageid -H "Cookie: invoteSession=$i;invote=$i" -s -o /dev/null
  echo "Fake-Antwort Nummer $(($i-$start+1)) abgegeben."
done



rm antworten.txt
rm seite.txt
