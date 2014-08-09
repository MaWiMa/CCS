:ext-relative: {outfilesuffix}
:source-highlighter: pygments
=== Source
You get the source from
https://github.com/MaWiMa/CCS

The structure should be selfexplaining, if not write me an email.


[source, ruby]
----
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
----

[source]
----
If you clone/fork and like to get things done, you have to make following dirs relative to your basedir

 |--_tmp 
 |--_site

then create a symlink from 

 |--inclusion
 |--copies-from-original

to

 |--_site
  |--inclusion
  |--copies-from-original
----

=== Programs
You want to edit, but things like ruby, git and asciidoctor must be aliens?
Then you only need an emaileditor.
Write the first email with following subject: Changing Canadian Schools
Tell me your name and if I am allowed to publish your email-adress

Take a look at the source-files which end with the .txt extension.
Correct the exiting files and maybe do new-ones.
Just write the filename to the subject of your email in following form:

[source,bash]
----
Notation: <Language><Page>
Example:  EN001
----

You like do do everything?
//http://asciidoctor.org/docs/user-manual/
You need an *editor* like vim, gedit, textmate, notepad.

You need *ruby, asciidoctor* and a *browser* for testing
To make HTML-Pages in basedir,for example, just do

[source]
----
asciidoctor -D _site/ readme.txt
----

to make the first Page of the English Version just do

[source,bash]
----
./makeWebPages.rb en 1
----

to make Page two to onehundretfiftyone of the English Version just do

[source]
----
./makeWebPages.rb en 2 151
----

To take a look at the website you build, go into your DIR *_site* open a terminal and run

[source]
----
ruby -run -e httpd . -p 8000
----

open your browser and look at *http://localhost:8000*


=== Transcript and Translation  

Since 5th of March 2013 I try to transcript and translate *Changing Canadian Schools* into german.
I like to be a part of a socialgroup, so I start and hope a view or more will join. +

Since 1994 I should now about Inclusion, because of the Salamanca Conference; I did not.
In former times I was an expert in special education, the german way, and I realized in 2011, for me, this is not the rightway to help as much as possible.
In the same year I did a short comparsion on special education in Canada and Germany.

My goal is to look with more than two eyes on Inclusion, by going back a lot of years.
I would like to translate with many, because my translation is surely faulty and if your interested in working together with people on this theme, we can discuss what school-educations highs and lows are.
Changing Canadian Schools was written in french and english. We have a special discussion, just like an open competition in comparsion of empty statements. Examples Inclusion, Integration, Assimilation, Separation, Segregation.
We compare the words Integration and Inclusion, for what? In french Inclusion is Integration, as far as I know native french speakers do not use the word inclusion.
In germany Inclusion was first translated into Integration, later it was redefined as Inclusion, backwards.
Inclusion is a horrible word, but it is not just a word., it is a movement, an attitude.
How do you act the things you do. +
1. Whats your goal +
2. How do you behave to reach this goal +


*Changing Canadian Schools* is a book from 1991 and I read it the first time in 2011 because of
link:/inclusion/Inklusion.pdf[professional interest] on inclusion. You can download the book from this site:
http://eric.ed.gov/?id=ED341224 under this link http://files.eric.ed.gov/fulltext/ED341224.pdf[ED341224.pdf].
If the link is dead now, take link:/copies-from-original/BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf[my copy], trust me, it is the same.
I split this copy into each page to go through translation side by side. For the copies I use only the front and back-cover of
my book, the rest is from the source above.
If pages are numbered, they are signed out too, white pages are left out.

I guess now the book could only be bought used. I wanted my own hardcover, on April the 17th in 2013 I received it.

If you want to work with me (or maybe later us), you should know how to use http://git-scm.com/[git] and write
http://www.methods.co.nz/asciidoc/[ascidoc].

It is all quiet simple, +
*if I can do this - anyone can!* +
You find the source on https://github.com/MaWiMa/CCS.
All work can be done within a simple editor.

First I tried to do the work in a wiki with https://github.com/gollum/gollum/blob/master/README.md[gollum] at home, it is really lovely and simple do work with that software.

Now, after a time I did nothing on this stuff, I decided not to do it through wiki. I thought it has do be done through wiki, to be fast. After I realized that even the transcript gets done real slow, I change to static webpages.
Everything should be done from now on with asciidoc(tor), with a static website for online-readers, and later pdfs or epubs for
those who like ebooks and print out papers.


link:/CCS/index{ext-relative}[home] +
link:/CCS/CCStecter{ext-relative}[Technical Terms] +
link:/CCS/CCSsta{ext-relative}[Status] +
link:/CCS/en/EN-Changing_Canadian_Schools-008{outfilesuffix}[transcript in englisch] +
link:/CCS/de/DE-Changing_Canadian_Schools-008{outfilesuffix}[Übersetzung der Abschrift in deutsch] +
link:/CCS/copies-from-original/BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf[copy of Changing Canadian Schools] +

Changing Canadian Schools
