#!/usr/bin/ruby
# encoding: utf-8

#unless ARGV.length < 1
#puts "Bitte geben Sie eine Datei an!"
#puts "Beispiel: #{__FILE__} EN-Changing_Canadian_Schools-159.txt"
#exit
#end

#unless ARGV.length > 1
#puts "Bitte geben Sie nicht mehr eine Datei an!"
#puts "Beispiel: #{__FILE__} EN-Changing_Canadian_Schools-159.txt"
#exit
#end

thisPage = ARGV[0]

=begin
lang = "EN"
here = "-Changing_Canadian_Schools-159.txt"
base = here[0 .. 26]
nextPageNumber = here[27..29].to_i+1
backPageNumber = here[27..29].to_i-1

nextPage = lang+base+nextPageNumber.to_s
backPage = lang+base+backPageNumber.to_s
=end

#thisPage = "file"
thesePageNames = thisPage.gsub(/[0-9].*/,'')
thisPageNumber = thisPage.gsub(/[^0-9]/,'').to_i
nextPageNumber = thisPageNumber+1
backPageNumber = thisPageNumber-1

nextPage = thesePageNames + nextPageNumber.to_s
backPage = thesePageNames + backPageNumber.to_s 

puts backPage
puts thisPage
puts nextPage
