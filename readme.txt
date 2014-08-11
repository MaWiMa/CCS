:ext-relative: {outfilesuffix}
:source-highlighter: pygments


=== Original Book
*Changing Canadian Schools* is a book from 1991 and I read it the first time in 2011 because of
link:/CCS/inclusion/Inklusion.pdf[professional interest] on inclusion. You can download the book from this site:
http://eric.ed.gov/?id=ED341224 under this link http://files.eric.ed.gov/fulltext/ED341224.pdf[ED341224.pdf].
If the link is dead now, take link:/CCS/copies-from-original/BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf[my copy], trust me, it is the same.
I split this copy into each page to go through translation side by side. For the copies I use only the front and back-cover of
my book, the rest is from the source above.
If pages are numbered, they are signed out too, white pages are left out.

I guess the book could only be bought used now.
I wanted my own hardcover, on April the 17th in 2013 I received it.


=== Transcript and Translation Website
You can the webpages build from following source from
https://mawima.github.io/CCS/ 
(CCS is case-sensitive).

=== Transcript and Translation Source
You get the source from
https://github.com/MaWiMa/CCS
(MaWiMa/CCS is case-sensitive).

The structure should be selfexplaining, if not write an email.

If you are comfortable with git and github you could
fork the repository on https://github.com/MaWiMa/CCS and send a pull request.
It is described on https://help.github.com/articles/fork-a-repo.

At this time there are only english [EN] and german [DE] versions.
if you like to start a translation into other languages, you are welcome.

You want to help me, but things like ruby, git and asciidoctor are aliens to you?
Then you only need an emaileditor (no html-format, just clean ascii).
Write the first email with following subject: Changing Canadian Schools
Tell me your name and if I am allowed to publish your email-adress (you will be named as author)

Take a look at the source-files which end with the .txt extension.
Correct the existing files or maybe do new-ones.
Just write the filename to the subject of your email in following form:

[source,bash]
----
Notation: <Language><Page>
Example:  EN001
----

Document tree

[source]
----

|-- copies-from-original
|-- de
|-- en
|-- _site
|   `-- CCS
|       |-- adoc.css -> ../../adoc.css
|       |-- copies-from-original -> ../../copies-from-original
|       |-- de
|       |-- en
|       |-- favicon.ico -> ../images/favicon.ico 
|       |-- inclusion -> ../../inclusion
|-- _tmp
|-- CCSdocres.txt
|-- CCSsta.txt
|-- CCStecter.txt
|-- adoc.css
|-- flipPages.rb
|-- images
|-- inclusion
|-- index.txt
|-- makeWebPages.rb
`-- readme.txt

----

todo manually, only if you want to buld your on website for testing
----
_site                    # website directory, has to be createad manually
_site/adoc.css           # symlink to adoc.css in root directory 
CCS/copies-from-original # symlink to copies from original directory
CCS/de                   # directory has to be createad manually
CCS/en                   # directory has to be createad manually
CCS/favicon.ico          # symlink to get less error messages, not necessary
CCS/inclusion            # symlink to inclusion directory
_tmp                     # temporary files directory, has to be createad manually

----

=== You like to build everything?
You need an *editor*.
You need *ruby, asciidoctor* and a *browser* for testing
You should know how to use http://git-scm.com/[git] and write
http://www.methods.co.nz/asciidoc/[ascidoc].

It is all quiet simple, +
*if I can do this - anyone can!* +

To make basedir HTML-Pages, for example, just do

[source]
----
asciidoctor -D _site/CCS -a stylesheet=adoc.css -a linkcss readme.txt
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

open your browser and look for your website at *http://localhost:8000/CCS*


=== Transcript and Translation, why?  

Since 5th of March 2013 I try to transcript and translate *Changing Canadian Schools* into german.
I like to be a part of a socialgroup, so I start and hope a view or more will join. +

In former times I was an expert in special education, the german way, and I realized in 2011, for me, this is not the rightway to help as much as possible.
In the same year I did a short comparsion on special education in Canada and Germany.
Since 1994 I should now about Inclusion, because of the Salamanca Conference; I did not.
I believe Inclusion is a good way to teach and learn, but it has an horrible name, and in Germany it seams to be down before it really started.
Maybe because it is done top-down. It seems as if things get done better, when learners and their parents want a new structures in education.

My goal is to look with more than two eyes on Inclusion, by going back a lot of years in an other country.
I would like to translate with many, because my translation is surely faulty and if your interested in working together with people on this theme, we can discuss what school-educations highs and lows are.
Changing Canadian Schools was written in french and english. We have a special discussion, just like an open competition in comparsion of empty statements. Examples Inclusion, Integration, Assimilation, Separation, Segregation.
We compare the words Integration and Inclusion, for what? In french Inclusion is Integration, as far as I know native french speakers do not use the word inclusion.
In germany Inclusion was first translated into Integration, later it was redefined as Inclusion, backwards.


First I tried to do the work in a wiki with https://github.com/gollum/gollum/blob/master/README.md[gollum] at home, it is really lovely and simple do work with that software.

Now, after a time I did nothing on this stuff, I decided not to do it through wiki. I thought it has do be done through wiki, to be fast. After I realized that even the transcript gets done real slow, I change to static webpages.
Everything should be done from now on with asciidoc(tor), with a static website for online-readers, and later pdfs or epubs for
those who like ebooks and print out papers.

[userinput1]#link:/CCS/index{ext-relative}[home] +
link:/CCS/CCStecter{ext-relative}[Technical Terms] +
link:/CCS/CCSsta{ext-relative}[Status] +
link:/CCS/en/EN-Changing_Canadian_Schools-008{outfilesuffix}[transcript in englisch] +
link:/CCS/de/DE-Changing_Canadian_Schools-008{outfilesuffix}[Übersetzung der Abschrift in deutsch] +
link:/CCS/copies-from-original/BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf[copy of Changing Canadian Schools]#

WilliV109@gMail.com +
Norbert Reschke
