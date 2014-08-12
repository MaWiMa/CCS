#!/usr/bin/ruby
# encoding: utf-8
require_relative 'flipPages'
require 'fileutils'
require 'asciidoctor'

unless ARGV.length < 4
 puts "Please do not enter more than three parameter, third parameter is optional!"
 puts "Bitte geben Sie nicht mehr als drei Parameter an, der dritte Parameter ist optional!"
 puts "Notation: <filename> <language> <first Page> <last Page>"
 puts "Example: #{__FILE__} EN 329"
 exit
end

i = ARGV[0].upcase.to_s         # 1. Parameter language
a = ARGV[1].to_i                # 2. Parameter first page
b = ARGV[2].to_i                # 3. Parameter last page

if (i.length != 2 or a == 0)    # i hat mehr oder weniger als zwei Buchstaben, a ist 0, z.B. keine Parameterangabe
 puts "Bitte geben Sie mindestens zwei Parameter wie folgt an!" 
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

if b == 0
 b = a
end 

for m in a..b
 puts "Language = #{i}, Page = #{m}"
 flip = Flip.new(i,m)

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
puts "got   : .... #{org}"

# make first line of header to get the right extension
File.write(new,":ext-relative: {outfilesuffix}\n")
puts "make  : .. #{new} part1"
#file = File.read(org)
 f = File.open(new, "a")
    f.write File.read(org)
 f.close
puts "append: .... #{org} to part1"


#FileUtils.cp(org,new)

footer = case flip.lang
# EN
 when "EN" then 
 f = File.open(new, "a")
    f.write " \n"
    f.write "[userinput2]#link:/CCS/index{ext-relative}[home] . . . . . . . . . . . \n"
    f.write "link:/CCS/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward] . . . . . . . . . . . \n"
    f.write "link:/CCS/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[back] + \n"
    f.write "link:/CCS/copies-from-original/CCS"+"%03d" % flip.page+".png[copy from original page]# \n"
    f.write "[userinput1]#"+flip.thisPage+"# \n"
 f.close
# DE
 when "DE" then 
 f = File.open(new, "a")
    f.write " \n"
    f.write "[userinput2]#link:/CCS/index{ext-relative}[home] . . . . . . . . . . . \n"
    f.write "link:/CCS/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[weiter] . . . . . . . . . . . \n"
    f.write "link:/CCS/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[zurück] + \n"
    f.write "link:/CCS/en/EN"+flip.thesePageNames+"%03d" % flip.page+"{ext-relative}[die Buchseite des Originals]# \n"
    f.write "[userinput1]#"+flip.thisPage+"# \n"
 f.close
# other Language 
end
puts "made  : .. #{new}"

# HTML output
Asciidoctor.render_file new, :to_dir => '_site/CCS/'+flip.lang.downcase, :safe => 'unsafe', :attributes => 'linkcss stylesdir=/CCS stylesheet=adoc.css' 
#to take original asciidoctor.css just use following line instead the one obove
#Asciidoctor.render_file new, :to_dir => '_site/CCS/'+flip.lang.downcase, :safe => 'unsafe', :attributes => 'linkcss' 

puts "made  : . _site/#{flip.thisPage}.html"

# DOCBOOK output
#Asciidoctor.render_file org, :to_dir => '_tmp/', :backend => 'docbook',:safe => 'unsafe'
end
