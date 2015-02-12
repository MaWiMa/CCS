#!/usr/bin/ruby
# encoding: utf-8
require_relative 'flipPages'

require 'fileutils'
require 'asciidoctor'
#require 'date'
require 'asciidoctor-pdf'
require 'asciidoctor-epub3'
require 'git'

ghbase='https://github.com/MaWiMa/CCS/tree/master/'

unless ARGV.length < 5
 puts "Please do not enter more than four parameter, fourth parameter is optional!"
 puts "Notation: <filename> <format> <language> <first Page> <last Page> "
 puts "Example: #{__FILE__} [html, pdf, epub] EN 1 329"
 puts "html will create pages as separate files and one file including all"
 exit
end

o = ARGV[0].downcase.to_s       # 1. Parameter format
i = ARGV[1].upcase.to_s         # 2. Parameter language
a = ARGV[2].to_i                # 3. Parameter first page 
b = ARGV[3].to_i                # 4. Parameter last page [optional]

if (i.length != 2 or a == 0)    # i hat mehr oder weniger als zwei Buchstaben, a ist 0, z.B. keine Parameterangabe
 puts "Please enter three or four parameter as follows!"
 puts "Notation: <filename> <format> <language> <first Page> <last Page> "
 puts "Example: #{__FILE__} [html, pdf, epub] EN 1 329"
 exit
end

until i == "EN" || i== "DE"
 puts "###########"
 puts "At this time there are only english [EN] and german [DE] versions." 
 puts "if you like to start a translation into other languages, you are welcome."
 puts "If you are comfortable with git and github you could fork the repository on"
 puts ""
 puts "https://github.com/MaWiMa/CCS and send a pull request"
 puts ""
 puts "Forking is described on https://help.github.com/articles/fork-a-repo."
 puts ""
 puts "If you do not know what this github thing is, no problem,"
 puts "just write an email, we find a solution your comfortable with."
 puts ""
 puts "WilliV109@gMail.com"
 puts "Norbert Reschke"
 puts "###########"
 exit 
end

if b == 0
 b = a
end 

git = Git.open('.')
f = File.new("_tmp/"+i+".txt", "w")
f.write("// common-part begins\n")
f.write(":doctype: book \n")
f.write(":front-cover-image: image:EN-CCS-Cover.png[] \n")
f.write(":doctitle: Changing Canadian Schools: Perspectives on Disability and Inclusion. \n")
f.write(":author_1: Porter, Gordon L., Ed. \n")
f.write(":author_2: Richler. Diane. Ed. \n")
f.write(":producer: Asciidoctor \n")
f.write(":keywords: Asciidoctor, Inclusion, Gordon L. Porter, Changing Canadian Schools \n")
f.write(":copyright: CC-BY-SA 4.0 \n")
f.write(":revdate: "+Date.today.to_s+"\n")
f.write(":revnumber: "+git.log(1).object(i.downcase+"/").to_s[0..7]+"\n")
f.write(":email: Norbert.Reschke@gMail.com \n")
f.write(":pagenums: \n")
f.write(":toclevels: 5 \n")
f.write("// common-part ends \n")
f.close



format = case o # format
# html
 when "html" then 

for m in a..b
 puts "Language = #{i}, Page = #{m}"
 flip = Flip.new(i,m)

# we need the next three lines only if a == 0 is not used (look for -> i.length != 2 or a == 0)
# if flip.page < 1
#   puts "The number of pages should be greater 0!"
#   exit
 if flip.page > 329
   puts "There should only be 329 pages!"
   exit
  end
 if flip.nextPageNumber > 329
  flip.nextPageNumber = 1
  puts "Last page is reached, we go back to page 1!"
  flip.nextPage = flip.lang + flip.thesePageNames + "%03d" % flip.nextPageNumber.to_s
 end 
 if flip.backPageNumber < 1
  flip.backPageNumber = 329
  puts "First page is reached, we goto page 329"
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
  f.write ":lang: "+i.downcase+"\n"
  f.write File.read(org)
 f.close
puts "append: .... #{org} to part1"

#FileUtils.cp(org,new)
footer = case flip.lang
# EN
 when "EN" then 
 f = File.open(new, "a")
    f.write " \n"
    f.write "[userinput2-c]#link:/CCS/index{ext-relative}[home]# \n"
    f.write "[userinput2-r]#link:/CCS/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward]# \n"
    f.write "[userinput2-l]#link:/CCS/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[back]# \n"
    f.write "[userinput1]#"+ghbase+"copies-from-original/CCS"+"%03d" % flip.page+".png["+flip.thisPage+"]# \n"
 f.close
# DE
 when "DE" then 
 f = File.open(new, "a")
    f.write " \n"
    f.write "[userinput2-c]#link:/CCS/index{ext-relative}[home]# \n"
    f.write "[userinput2-r]#link:/CCS/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward]# \n"
    f.write "[userinput2-l]#link:/CCS/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[back]# \n"
    f.write "[userinput1]#link:/CCS/en/EN"+flip.thesePageNames+"%03d" % flip.page+"{ext-relative}[diese Seite als Abschrift des Originals]# \n"
 f.close
# other Language 
 end
puts "made  : .. #{new}"

Asciidoctor.render_file new,
:to_dir => '_site/CCS/'+flip.lang.downcase,
:safe => 'unsafe',
:attributes => 'linkcss stylesdir=/CCS stylesheet=adoc.css imagesdir=/CCS/images'

puts "made  : . _site/#{flip.thisPage}.html"
 end
f = File.open("_tmp/"+i+".txt", "a")
 f.write("// html-part begins\n")
#f.write(":last-update-label!: \n")
 f.write ":lang: "+i.downcase+"\n"
 f.write(":nofooter: \n")
 f.write(":toc: \n")
#f.write(":includedir: ./en\n")

  b = 329
  a = 10
 
 for m in a..b
  puts "Page "+"%03d" % m
  f.write("include::"+i.downcase+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt[] \n")
 end
f.write("// html-part ends\n")
f.close

footer = case i
# EN
 when "EN" then 
 f = File.open("_tmp/"+i+".txt", "a")
   f.write " \n"
   f.write "[userinput0]#Version: https://github.com/MaWiMa/CCS/commit/"+git.log(1).object(i.downcase+"/").to_s+"["+git.log(1).object(i.downcase+"/").to_s[0..7]+"]# \n"
 f.close
# DE
 when "DE" then 
 f = File.open("_tmp/"+i+".txt", "a")
   f.write " \n"
   f.write "[userinput0]#Version: https://github.com/MaWiMa/CCS/commit/"+git.log(1).object(i.downcase+"/").to_s+"["+git.log(1).object(i.downcase+"/").to_s[0..7]+"]# \n"
 f.close
# other Language 
 end

Asciidoctor.render_file f,
:base_dir => '.',
:to_dir => '_site/CCS/'+flip.lang.downcase,
:safe => 'unsafe',
:attributes => 'linkcss stylesdir=/CCS stylesheet=adoc.css imagesdir=/CCS/images'
#:footer => 'false'

when "pdf" then
f = File.open("_tmp/"+i+".txt", "a")
f.write("// pdf-part begins\n")
f.write("//:toc: \n")
f.write("Changes in Version: https://github.com/MaWiMa/CCS/commit/"+git.log(1).object(i.downcase+"/").to_s+"["+git.log(1).object(i.downcase+"/").to_s[0..7]+"] \n")

 if b < a
  b = a
 end
 for m in a..b
  puts "Page "+"%03d" % m
  f.write("include::"+i.downcase+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt[] \n")
 end
f.write("// pdf-part ends\n")
f.close

Asciidoctor.render_file f,
#:require => 'asciidoctor-pdf',
:base_dir => '.',
:to_dir => 'inclusion',
:backend => 'pdf',
:attributes => 'pdf-style=CCS pdf-stylesdir=. imagesdir=images',
:safe => 'unsafe'

when "epub" then
f = File.open("_tmp/"+i+".txt", "a")
f.write("// epub-part begins\n")
f.write(":toc: \n")

 if b < a
  b = a
 end
 for m in a..b
  puts "Page "+"%03d" % m
  f.write("include::"+i.downcase+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt[] \n")
 end
f.write("// epub-part ends\n")
f.close

Asciidoctor.render_file f,
#:require => 'asciidoctor-epub3', 
:base_dir => '.',
:to_dir => 'inclusion',
:backend => 'epub3',
:attributes => 'imagesdir=images',
:safe => 'unsafe'

 else
 puts "can't do this!"
 exit
end # /format
