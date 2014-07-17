#!/usr/bin/ruby
# encoding: utf-8
require_relative 'flipPages'
require 'fileutils'
require 'asciidoctor'

i = "EN"
a = 8
flip = Flip.new(i,a)


# CCS hat 329 Seiten, die HTML-Seiten sollen durchlaufen
 if flip.page < 1
   puts "Die Seitenzahl sollte größer 0 Seiten sein!"
   exit
 elsif flip.page > 329
   puts "Es sollte nur 329 Seiten geben!"
   exit
  end
 if flip.nextPageNumber > 329
 flip.nextPageNumber = 1
 puts "Die letzte Seite ist erreicht, die nächste Seite ist Seite 1!"
 flip.nextPage = flip.lang + flip.thesePageNames + "%03d" % flip.nextPageNumber.to_s
 end 
 if flip.backPageNumber < 1
 flip.backPageNumber = 329
 puts "Die erste Seite ist erreicht, die vorherige Seite ist Seite 329!"
 flip.backPage = flip.lang + flip.thesePageNames + flip.backPageNumber.to_s
 end 
# backup file

org = flip.lang.downcase+"/"+flip.thisPage+".txt"
new = "_tmp/"+flip.thisPage+".ad"
FileUtils.cp(org,new)

f = File.open(new, "a")
    f.write " \n"
    f.write "link:/index{ext-relative}[home] + \n"
    f.write "link:/"+flip.lang.downcase+"/"+flip.nextPage+"{ext-relative}[forward] + \n"
    f.write "link:/"+flip.lang.downcase+"/"+flip.backPage+"{ext-relative}[back] + \n"
    f.write "link:/copies-from-original/BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf[copy of Changing Canadian Schools] + \n"
    f.write "[.lead] \n"
    f.write flip.thisPage+" \n"
f.close
# HTML output
Asciidoctor.render_file new, :to_dir => '_site/'+flip.lang.downcase, :safe => 'unsafe'
# DOCBOOK output
#Asciidoctor.render_file org, :to_dir => '_tmp/', :backend => 'docbook',:safe => 'unsafe'

