#!/usr/bin/ruby
# encoding: utf-8
require_relative 'flipPages'
#require 'fileutils'
require 'asciidoctor'
require 'asciidoctor-pdf'
require 'asciidoctor-epub3'
require 'git'

BEGIN {
 unless ARGV.length > 1 && ARGV.length < 5
  puts ""
  puts "Please enter at least two parameter, first language, second format,"
  puts "the third and fourth parameter are only needed"
  puts "if you want to make one or a few pages!" 
  puts " "
  puts "Notation: <filename> <language> <format> <firstpage> <lastpage>"
  puts "Example: #{__FILE__} EN [html, pdf, epub] [1] [329]"
  puts ""
  abort
 end

 i = ARGV[0].upcase.to_s         # 1. Parameter language
 o = ARGV[1].downcase.to_s       # 2. Parameter format
 a = ARGV[2].to_i                # 3. Parameter first page [optional]
 b = ARGV[3].to_i                # 4. Parameter last page [optional]

 if a == 0
  a = 1
  b = 329
 end

 if b == 0
  b = a
 end 

 unless ARGV.length > 1 && ARGV.length < 5
  puts "Please enter at least two parameter, first language, second format,"
  puts "the third and fourth parameter are only needed"
  puts "if you want to make one or a few pages!" 
  puts " "
  puts "Notation: <filename> <language> <format> <firstpage> <lastpage>"
  puts "Example: #{__FILE__} EN [html, pdf, epub] [1] [329]"
  puts "You did: #{__FILE__} #{i} #{o} #{a} #{b}"
  abort
 end

 until i.length == 2    # i has more than 2 letters
  puts "Please enter language as follows!"
  puts "Notation: <language> <format>"
  puts "Example: EN pdf"
  abort
end

 until i == "EN" || i== "DE"
  puts "At this time there are only english [EN] and german [DE] versions." 
  puts "if you like to start a translation into other languages, you are welcome."
  puts "If you are comfortable with git and github you could fork the repository on"
  puts ""
  puts "https://github.com/MaWiMa/CCS and send a pull request"
  puts ""
  puts "Forking is described on https://help.github.com/articles/fork-a-repo."
  puts ""
  puts "If you do not know what this github thing is, no problem,"
  puts "just write an email, we find a solution you are comfortable with."
  puts ""
  puts "Norbert.Reschke@gMail.com"
  abort
 end
}

def sample_one(file,lang)
 file.write("== DOCUMENT RESUME \n")
 file.write("include::{includedir}/CCSdocres.txt[] \n")
end

git = Git.open('.')
f = File.new(i.downcase+"/CCS-"+i+".txt", "w")
f.write("// common-part begins\n")
# f.write ":notitle:\n"
# f.write ":noheader:\n"
f.write(":ext-relative: {outfilesuffix} \n")
f.write(":nofooter:\n")
f.write(":doctype: book \n")
f.write(":front-cover-image: image:"+i+"-CCS-Cover.svg[] \n")
f.write(":doctitle: Changing Canadian Schools: Perspectives on Disability and Inclusion. \n")
f.write(":authors: Porter, Gordon L., Ed.; Richler, Diane, Ed. \n")
f.write(":author_01: Campbell, Charlotte \n" )
f.write(":author_02: Collicott, Jean \n" )
f.write(":author_03: den Otter, Jeff \n" )
f.write(":author_04: Jory, David \n" )
f.write(":author_05: Kelly, Brian \n" )
f.write(":author_06: Marcaccio, Marcia \n" )
f.write(":author_07: McCallum, S. Dulcie \n" )
f.write(":author_08: Murray, Margaret \n" )
f.write(":author_09: Panitch, Melanie \n" )
f.write(":author_10: Perner, Darlene E. \n" )
f.write(":author_11: Porter, Gordon L., Ed. \n")
f.write(":author_12: Richler, Diane, Ed. \n")
f.write(":author_13: Rioux, Marcia H. \n")
f.write(":author_14: Steinbach, Alene \n" )
f.write(":author_15: Stone, Julie \n" )
f.write(":author_16: Wilson, Mary \n" )
f.write(":subject: Inclusion in Canada until 1991 \n")
f.write(":keywords: Asciidoctor, Inclusion, Gordon L. Porter, Changing Canadian Schools \n")
f.write(":copyright: CC-BY-SA 4.0 \n")
f.write(":revdate: "+Date.today.to_s+"\n")
f.write(":revnumber: "+git.log(1).path(i.downcase+"/CCS-"+i+".txt").to_s[0..7]+" \n")
f.write(":email: Norbert.Reschke@gMail.com \n")
f.write(":toclevels: 5 \n")
f.write("// common-part ends \n")
f.close


format = case o
when "html"
  puts "Language = #{i}"
 for m in a..b
  puts "Page = #{"%03d"% m}"
  flip = Flip.new(i,m)

  if flip.page > 329
    puts "There should only be 329 pages!"
    abort
  end
  if flip.nextPageNumber > 329
   flip.nextPageNumber = 1
#  puts "Last page is reached, we go back to page 1!"
   flip.nextPage = flip.lang + flip.thesePageNames + "%03d" % flip.nextPageNumber.to_s
  end 
  if flip.backPageNumber < 1
   flip.backPageNumber = 329
#  puts "First page is reached, we goto page 329"
   flip.backPage = flip.lang + flip.thesePageNames + flip.backPageNumber.to_s
  end 

 org = flip.lang.downcase + "/" + flip.thisPage + ".txt"
 new = "_tmp/" + flip.thisPage + ".ad" # Problem with including files see CCSdocres


 f = File.new(new, "w")
  f.write(":ext-relative: {outfilesuffix}\n")
  f.write(":nofooter:\n")
   if m == 1
    sample_one(f,i)
   end
  f.write(":lang: " + i.downcase + "\n")
  f.write("include::" + i.downcase + "/" + i + "-Changing_Canadian_Schools-" + "%03d" % m.to_s + ".txt[] \n")
 f.close

 footer = case flip.lang
  when "EN"
   f = File.open(new, "a")
    f.write " \n"
    f.write "[userinput2-c]#link:/CCS/index{ext-relative}[home]# \n"
    f.write "[userinput2-r]#link:/CCS/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward >>]# \n"
    f.write "[userinput2-l]#link:/CCS/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[<< back]# \n"
    f.write "[userinput0-l]#link:/CCS/copies-from-original/CCS"+"%03d" % flip.page+".png[copy from Original]# \n"
    f.write "[userinput0-r]#Ver: https://github.com/MaWiMa/CCS/commit/"+git.log(1).path(flip.lang.downcase+"/"+flip.thisPage+".txt").to_s+"["+git.log(1).path(flip.lang.downcase+"/"+flip.thisPage+".txt").to_s[0..5]+"]# \n"
   f.close

  when "DE"
   f = File.open(new, "a")
    f.write " \n"
    f.write "[userinput2-c]#link:/CCS/index{ext-relative}[home]# \n"
    f.write "[userinput2-r]#link:/CCS/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward >>]# \n"
    f.write "[userinput2-l]#link:/CCS/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[<< back]# \n"
    f.write "[userinput0-l]#link:/CCS/en/EN"+flip.thesePageNames+"%03d" % flip.page+"{ext-relative}[Abschrift des Originals]# \n"
    f.write "[userinput0-r]#Ver: https://github.com/MaWiMa/CCS/commit/"+git.log(1).path(flip.lang.downcase+"/"+flip.thisPage+".txt").to_s+"["+git.log(1).path(flip.lang.downcase+"/"+flip.thisPage+".txt").to_s[0..5]+"]# \n"
   f.close

 end
Asciidoctor.render_file new,
:base_dir => '.',
:to_dir => 'CCS/'+flip.lang.downcase,
:safe => 'safe',
:attributes => 'sep-pages linkcss stylesdir=/CCS stylesheet=adoc.css imagesdir=/CCS/images includedir=included'
end

puts "I start big page "+i+"!"
 f = File.open(i.downcase+"/CCS-"+i+".txt", "a")
  f.write("// html-part begins\n")
  f.write(":lang: "+i.downcase+"\n")
  f.write(":toc: left \n")
# f.write(":toc: macro \n")
# f.write(":revnumber:"+git.log(1).path(i.downcase+"/CCS-"+i+".txt").to_s+"["+git.log(1).path(i.downcase+"/CCS-"+i+".txt").to_s[0..7]+"] \n")
# f.write(":nofooter: \n")
# f.write("toc::[] \n")
  f.write(" \n")
 
  a = 1
  b = 329

  for m in a..b
   if m == 1
    sample_one(f,i)
   end
   next if m == 2 # exclude EN-Changing_Canadian_Schools-002.txt
   next if m == 8 # exclude EN-Changing_Canadian_Schools-008.txt
   next if m == 9 # exclude EN-Changing_Canadian_Schools-009.txt
   f.write " \n"
   f.write("include::"+i.downcase+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt[] \n")
  end

  f.write " \n"
  f.write "[userinput0-l]#link:/CCS/index{ext-relative}[Home]# \n"
  f.write "[userinput0-r]#https://github.com/MaWiMa/CCS/commit/"+git.log(1).path(i.downcase+"/CCS-"+i+".txt").to_s+"["+git.log(1).path(i.downcase+"/CCS-"+i+".txt").to_s[0..7]+"]# \n"
  f.write("// html-part ends\n")
  f.write(" \n")
 f.close

Asciidoctor.render_file f,
:base_dir => '.',
:to_dir => 'CCS/'+i.downcase,
:safe => 'safe',
:attributes => 'html-pages linkcss stylesdir=/CCS stylesheet=adoc.css imagesdir=/CCS/images includedir=included'

when "pdf"
 f = File.open(i.downcase+"/CCS-"+i+".txt", "a")
  f.write("// pdf-part begins\n")
  f.write(":pagenums: \n")
  f.write(":toc: macro \n")
  f.write("Changes in this Version can be viewed by following this link: https://github.com/MaWiMa/CCS/commit/"+git.log(1).path(i.downcase+"/CCS-"+i+".txt").to_s+"["+git.log(1).path(i.downcase+"/CCS-"+i+".txt").to_s[0..7]+"] \n")
  f.write("\n")
  f.write("toc::[] \n")
#f.write(":sectlinks: \n")
#f.write(":idprefix: _ \n")
  f.write("\n") 
  f.write("== Authors \n")

  arr=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
  arr.each { |m| f.write("{author_"+"%02d" %m.to_s+"}\n\n") }
  
  f.write("\n")

  
 if i=="EN" 
  a = 1 
  b = 329
 end

 for m in a..b
  if m == 1
   sample_one(f,i)
  end
  next if m == 2 # exclude EN-Changing_Canadian_Schools-002.txt
  next if m == 8 # exclude EN-Changing_Canadian_Schools-008.txt
  next if m == 9 # exclude EN-Changing_Canadian_Schools-009.txt
  f.write("include::"+i.downcase+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt[] \n")
  f.write("\n")
  # pagebreak for pdfs
  arr =[1,3,4,5,6,7,11,16,34,77,108,126,148,156,197,218]
  if arr.include?(m)
   f.write("<<< \n")
  end 
 end
 
  f.write("// pdf-part ends\n")
 f.close

Asciidoctor.render_file f,
:base_dir => '.',
:to_dir => 'CCS/inclusion',
:backend => 'pdf',
:attributes => 'pdf-pages pdf-style=CCS pdf-stylesdir=CCS imagesdir=CCS/images includedir=included',
#:attributes => 'pdf-pages  imagesdir=CCS/images includedir=included',
:safe => 'safe'

when "epub"
=begin
f = File.open(i.downcase+"/CCS-"+i+".txt", "a")
f.write("// epub-part begins\n")
f.write(":toc: \n")
f.write("Changes in Version: https://github.com/MaWiMa/CCS/commit/"+git.log(1).object(i.downcase+"/").to_s+"["+git.log(1).object(i.downcase+"/").to_s[0..7]+"] \n")
f.write("\n")
f.write("<<< \n")
f.write("\n")

  a = 1
  b = 329

 for m in a..b
  if m == 1
   sample_one(f,i)
  end
   next if m == 2 # exclude EN-Changing_Canadian_Schools-002.txt
   next if m == 8 # exclude EN-Changing_Canadian_Schools-008.txt
   next if m == 9 # exclude EN-Changing_Canadian_Schools-009.txt

  puts "Page "+"%03d" % m
  f.write("include::"+i.downcase+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt[] \n")
 end
 f.write("// epub-part ends\n")
 f.close

Asciidoctor.render_file f,
#:require => 'asciidoctor-epub3', 
:base_dir => '.',
:to_dir => 'CCS/inclusion',
:backend => 'epub3',
:attributes => 'pdf-pages imagesdir=CCS/images includedir=included',
:safe => 'safe'
=end
puts "I can't do the #{o}-format now, look at https://github.com/MaWiMa/CCS for more info!"
exit

 else
 puts "I can't do this format -> #{o} (now)!"
 exit
end # /format

