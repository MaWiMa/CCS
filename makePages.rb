#!/usr/bin/ruby
# encoding: utf-8
require_relative 'flipPages'
#require 'fileutils'
require 'asciidoctor'
require 'asciidoctor-pdf'
require 'asciidoctor-epub3'
require 'git'
require 'hexapdf'

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

puts i
puts o

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

 until i == "EN" || i == "DE"
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

 until o == "html" || o == "pdf" || o == "epub"
  puts "Please enter format as second parameter!"
  puts "Notation: <language> <format>"
  puts "Example: EN html"
  puts "You can choose html, pdf or epub"
  abort
 end

}

def sample_one(file,lang)
 file.write("== DOCUMENT RESUME \n")
 file.write("include::{includedir}/CCSdocres.txt[] \n")
end

git = Git.open('.')
spine = i.downcase+"/CCS-"+i+".txt"
f = File.new(spine, "w")
f.write("// common-part begins\n")
f.write(":ext-relative: {outfilesuffix} \n")
f.write(":doctype: book \n")
f.write(":front-cover-image: image:"+i+"-CCS-Cover.svg[Front Cover] \n")
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
f.write(":revdate: {localdate} \n")
f.write(":revnumber: "+git.log(1).path(i.downcase+"/"+i+"*.txt").to_s[0..7]+" \n")
f.write(":source: ISBN 1-895070-00-7 \n")
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
 f = File.open(spine, "a")
  f.write("// html-part begins\n")
  f.write(":lang: "+i.downcase+"\n")
  f.write(":toc: left \n")
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
  f.write "[userinput0-r]#https://github.com/MaWiMa/CCS/commit/"+git.log(1).path(i.downcase+"/"+i+"*.txt").to_s+"["+git.log(1).path(i.downcase+"/"+i+"*.txt").to_s[0..7]+"]# \n"
  f.write("// html-part ends\n")
  f.write(" \n")
 f.close

Asciidoctor.render_file f,
:base_dir => '.',
:to_dir => 'CCS/'+i.downcase,
:safe => 'safe',
:attributes => 'html-pages linkcss stylesdir=/CCS stylesheet=adoc.css imagesdir=/CCS/images includedir=included'

when "pdf"
 f = File.open(spine, "a")
  f.write("// pdf-part begins\n")
  f.write("Changes in this Version can be viewed by following this link: https://github.com/MaWiMa/CCS/commit/"+git.log(1).path(i.downcase+"/"+i+"*.txt").to_s+"["+git.log(1).path(i.downcase+"/"+i+"*.txt").to_s[0..7]+"] \n")

  f.write("\n")
  f.write("toc::[] \n")
#f.write(":sectlinks: \n")
#f.write(":idprefix: _ \n")
  f.write("\n") 
  f.write("== Authors \n")

  arr=[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16]
  arr.each { |m| f.write("{author_"+"%02d" %m.to_s+"}\n\n") }
  
  f.write("<<< \n")

  
 if i=="EN" 
  a = 1 
  b = 329
 end

 for m in a..b

  next if m == 1 # exclude 001.txt, document resume/abstract 
  next if m == 2 # exclude 002.txt, cover
  next if m == 8 # exclude 008.txt, toc part1
  next if m == 9 # exclude 009.txt, toc part2
  next if m == 294 # exclude 294.txt, toc of annoted bib

  f.write("include::"+i.downcase+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt[] \n")
  f.write("\n")
  # pagebreak for pdfs
  arr =[3,4,5,6,7,11,16,34,77,108,126,148,156,197,218]
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
:attributes => 'pagenums pdf-pages pdf-style=CCS pdf-stylesdir=CCS imagesdir=CCS/images includedir=included',
:safe => 'safe'

optthis= "CCS/inclusion/" + File.basename(f, ".txt")

HexaPDF::Document.open(optthis + ".pdf") do |doc|
 doc.task(:optimize, compact: true, object_streams: :generate, compress_pages: true)
 doc.write(optthis + "-optimized.pdf")
end

File.rename(optthis + "-optimized.pdf", optthis + ".pdf")

when "epub"

Dir.glob("_tmp/*.txt").each { |file| File.delete(file)} #delete all files in tmp-dir

e = File.new("_tmp/CCS-"+i+"-sample.txt", "w")
  a = 1 # firstpage
  b = 329 # lastpage
 for m in a..b # look at sample.read
  next if m == 1 # exclude 001.txt, document resume/abstract 
  next if m == 2 # exclude 002.txt, cover
  next if m == 8 # exclude 008.txt, toc part1
  next if m == 9 # exclude 009.txt, toc part2
  next if m == 294 # exclude 294.txt, toc of annoted bib
 
fragment=i.downcase.to_s+"/"+i+"-Changing_Canadian_Schools-"+"%03d" % m.to_s+".txt" # the contents in original order
 sample = File.open(fragment)
  e.write(sample.read) # write one sampled file (m counts, next if throws away) 
  e.write("\n")
 end
e.close

# split sampled file into chapters (look at https://github.com/asciidoctor/asciidoctor-epub3/issues/90)
## google was my friend..., the following is really fast
# awk '/^=/{i=i+1}{i=sprintf("%03d",i)}{print > "heading-"i".txt"}' _tmp/CCS-EN-sample.txt
# /^=/ => search in file "_tmp/CCS_EN-sample" for heading(i=0), do some fancy format things,
# print content before first heading (if exist) to file "heading-000.txt", then search for next heading,
# print content between heading one (including heading one) and next heading to file
# "heading-001.txt, then do next search (until there is no more heading).
## 

samples=File.open(e) 
headings=samples.read.split(/(?=^=[[:blank:]].)/) # split(/(?=pattern)/) cuts before searched expression, "^= ." searches for only one "=" at first position of line, followed by blank and then any character.
heading_one = headings[0] # get first include file for spine
#puts heading_one[0] # get first character of first file
if not heading_one[0] == "="
 puts "the first include-file in spine has to start with \"=\" as first character in first line"
 exit
else
headings.each_with_index { |h,i| # h is the content including the heading, i the index (starts from 0)
c = File.new("_tmp/heading-"+"%03d"%(i+1).to_s+".txt", "w") # index starts at zero therefor i+1
 c.write(h)
 c.close
}
end

j = headings.count
f = File.open(spine, "a")
 f.write("// epub-part begins\n")
 f.write("Changes in Version: https://github.com/MaWiMa/CCS/commit/"+git.log(1).object(i.downcase+"/").to_s+"["+git.log(1).object(i.downcase+"/").to_s[0..7]+"] \n")
 f.write("\n")
  for m in 1..j # level one chapters 
  f.write("include::_tmp/heading-"+"%03d"%m+".txt[] \n")
  end
 f.write("// epub-part ends\n")
f.close

Asciidoctor.render_file f,
:base_dir => '.',
:to_dir => 'CCS/inclusion',
:backend => 'epub3',
#:attributes => 'ebook-validate epub-pages imagesdir=CCS/images includedir=included epub3-stylesdir=CCS',
:attributes => 'epub-pages imagesdir=CCS/images includedir=included',
:safe => 'safe'

end # /format

