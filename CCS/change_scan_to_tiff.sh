#!/bin/bash
## PDF in Einzelseiten zerlegen
#pdfseparate BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf Changing_Canadian_Schools-%d.pdf

## Liste erstellen
#ls Changing_Canadian_Schools-*.pdf > ls.txt

## umwandeln in Grafikdatei
#while read line
#do
#mogrify -density 600x600 -monochrome -format tiff $line
#echo $line
#done < ls.txt

## nochmal Liste erstellen
#ls Changing_Canadian_Schools-*.tiff > ls.txt

## Text extrahieren
#while read line
#do
#tesseract $line -l eng Text/$line
#echo $line
#done < ls.txt

##umbennen
#mmv "*-[1-9].pdf" "#1-00#2.pdf"
#mmv "*-[1-9][0-9].pdf" "#1-0#2#3.pdf"

