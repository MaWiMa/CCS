#!/usr/bin/ruby
# encoding: utf-8
require 'fileutils'
require 'asciidoctor'
#require 'git'

puts "Please enter one parameter, which should be the basename of a textfile"
puts "Notation: <filename> <basename>"
puts "Example: #{__FILE__} index"
puts ""
puts "all basefiles should be made by"
puts "\"for i in *.txt;do #{__FILE__} $(basename $i);done\""

i = ARGV[0].to_s         # 1. Parameter language
if File::exists?(i+".txt")

#git = Git.open('.')
f = File.open("_tmp/"+i+".adoc", "w")
f.write("// CCS basedir files\n")
f.write(":nofooter:\n")
f.write(":ext-relative: {outfilesuffix} \n")
f.write(":email: Norbert.Reschke@gMail.com \n")
f.write("include::"+i+".txt[] \n")

#f.write("image:http://mirrors.creativecommons.org/presskit/buttons/88x31/svg/by-nc-sa.svg[, align=center,CC-BY-NC-SA, link=http://creativecommons.org/licenses/by-nc-sa/4.0/]\n")

f.write("[userinput3]#image:cc-by-nc-sa.svg[CC-BY-NC-SA, link=http://creativecommons.org/licenses/by-nc-sa/4.0/]# \n")
f.write("[userinput2-l]#link:/CCS/en/EN-Changing_Canadian_Schools-003{outfilesuffix}[Transcription]# \n")
f.write("[userinput2-c]#link:/CCS/index{ext-relative}[Home]# \n")
f.write("[userinput2-r]#link:/CCS/de/DE-Changing_Canadian_Schools-003{outfilesuffix}[Translation]# \n")
#f.write("[userinput0]#link:/CCS/CCSsta{ext-relative}[Status], Version: https://github.com/MaWiMa/CCS/commit/"+git.log(1).to_s+"["+git.log(1).to_s[0..7]+"]#  \n")
f.write("[userinput0]#link:/CCS/CCSsta{ext-relative}[Status]# \n")
f.close

Asciidoctor.render_file f,
:base_dir => '.',
:to_dir => 'CCS/',
:safe => 'unsafe',
:attributes => 'linkcss stylesdir=. stylesheet=adoc.css imagesdir=images'

puts "made /CCS/"+i+".html"

else
 puts "The file "+i+".txt does not exist in base-directory!"
 exit
end
