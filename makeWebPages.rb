#!/usr/bin/ruby
# encoding: utf-8
require_relative 'flipPages'
require 'fileutils'
require 'asciidoctor'

unless ARGV.length < 3
 puts "Please do not enter more than two parameter!"
 puts "Bitte geben Sie nicht mehr als zwei Parameter an!"
 puts "Notation: <Dateiname> <Language> <Page>"
 puts "Example: #{__FILE__} EN 329"
 exit
end

i = ARGV[0].upcase.to_s         # 1. Parameter
a = ARGV[1].to_f                # 2. Parameter


if (i.length != 2 or a == 0)    # i hat mehr oder weniger als beide Werte 0, z.B. keine Parameterangabe
 puts "Bitte geben Sie zwei Parameter wie folgt an!" 
 puts "Please enter two parameter as follows!"
 puts "Notation: <Dateiname> <Sprache> <Seite>"
 puts "Beispiel: #{__FILE__} DE 12"
 exit
end

until i == "EN" || i== "DE"
 puts "###########"
 puts "At this time there are only english [EN] and german [DE] versions." 
 puts "if you like to start a translation into other languages, you are welcome."
 puts "If you are comfortable with git and github you could"
 puts ""
 puts "fork the repository on https://github.com/MaWiMa/CCS and send a pull request"
 puts "like it is described on https://help.github.com/articles/fork-a-repo."
 puts ""
 puts "If you do not know what this github thing is, no problem,"
 puts "just write me an email, we find a solution your comfortable with."
 puts "WilliV109@gMail.com"
 puts ""
 puts "Norbert Reschke"
 puts "###########"
 exit 
end


flip = Flip.new(i,a)

# CCS hat 329 Seiten, die HTML-Seiten sollen durchlaufen
# we need the next four lines only if a == 0 is not used (look for -> i.length != 2 or a == 0)
# if flip.page < 1
#   puts "The number of pages should be greater 0!"
#   puts "Die Seitenzahl sollte größer 0 Seiten sein!"
#   exit
 if flip.page > 329
   puts "There should only be 329 pages!"
   puts "Es sollte nur 329 Seiten geben!"
   exit
  end
 if flip.nextPageNumber > 329
  flip.nextPageNumber = 1
  puts "Last page is reached, we go back to page 1!"
  puts "Die letzte Seite ist erreicht, wir gehen wieder zu Seite 1!"
  flip.nextPage = flip.lang + flip.thesePageNames + "%03d" % flip.nextPageNumber.to_s
 end 
 if flip.backPageNumber < 1
  flip.backPageNumber = 329
  puts "First page is reached, we goto page 329"
  puts "Die erste Seite ist erreicht, wir gehen zu Seite 329!"
  flip.backPage = flip.lang + flip.thesePageNames + flip.backPageNumber.to_s
 end 

# backup file
#FileUtils.ln_s('../CCSdocres.txt', '_tmp/CCSdocres.txt') # this must be done better
org = flip.lang.downcase+"/"+flip.thisPage+".txt"
new = "_tmp/"+flip.thisPage+".ad" # Problem with including files see CCSdocres
FileUtils.cp(org,new)

footer = case flip.lang
# EN
 when "EN" then 
 f = File.open(new, "a")
    f.write " \n"
    f.write "link:/index{ext-relative}[home] + \n"
    f.write "link:/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward] + \n"
    f.write "link:/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[back] + \n"
    f.write "link:/copies-from-original/CCS"+"%03d" % flip.page+".png[	copy from original page] + \n"
    f.write " \n"
    f.write flip.thisPage+" \n"
 f.close
# DE
 when "DE" then 
 f = File.open(new, "a")
    f.write " \n"
    f.write "link:/index{ext-relative}[home] + \n"
    f.write "link:/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward] + \n"
    f.write "link:/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[back] + \n"
    f.write "link:/en/EN"+flip.thesePageNames+"%03d" %flip.page+"{ext-relative}[the original version] + \n"
    f.write " \n"
    f.write flip.thisPage+" \n"
 f.close
# other Language 
end

# HTML output
Asciidoctor.render_file new, :to_dir => '_site/'+flip.lang.downcase, :safe => 'unsafe'
# DOCBOOK output
#Asciidoctor.render_file org, :to_dir => '_tmp/', :backend => 'docbook',:safe => 'unsafe'

