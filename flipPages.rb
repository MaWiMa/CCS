#!/usr/bin/ruby
# encoding: utf-8

thisPage = ARGV[0]

if ARGV.length < 1
puts "Bitte geben Sie eine Datei an!"
puts "Beispiel: #{__FILE__} EN-Changing_Canadian_Schools-159.txt"
exit
elsif ARGV.length > 1
puts "Bitte geben Sie nur eine Datei an!"
puts "Beispiel: #{__FILE__} EN-Changing_Canadian_Schools-159.txt"
exit
elsif thisPage[2..28] != "-Changing_Canadian_Schools-"
puts "Das scheint nicht der richtige Dateiname zu sein!"
puts "Beispiel: #{__FILE__} EN-Changing_Canadian_Schools-159.txt"
exit
elsif thisPage.gsub(/[^0-9]/,'').to_i > 329
puts "Es sollte nur 329 Seiten geben!"
puts "Beispiel: #{__FILE__} EN-Changing_Canadian_Schools-159.txt"
exit

end

thesePageNames = thisPage.gsub(/[0-9].*/,'')
thisPageNumber = thisPage.gsub(/[^0-9]/,'').to_i
nextPageNumber = thisPageNumber+1
if nextPageNumber > 329
nextPageNumber = 1
puts "Die letzte Seite ist erreicht, die nächste Seite ist Seite 1!"
end 
backPageNumber = thisPageNumber-1

nextPage = thesePageNames + "%03d" % nextPageNumber.to_s
backPage = thesePageNames + "%03d" % backPageNumber.to_s


puts thisPageNumber
puts nextPage
puts backPage
