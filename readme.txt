:ext-relative: {outfilesuffix}
:source-highlighter: pygments


=== Original Book
*Changing Canadian Schools* is a book from 1991 and I read it the first time in 2011 because of
link:/CCS/inclusion/Inklusion.pdf[professional interest] on inclusion.
I was searching for experienced people and changingin canadian schools seems to be sampled experience on inclusion from the view
of students, their parents and teachers. I want to look at former times and than look what happened till that time.
For short -- learning.

You can download the book from this site:
http://eric.ed.gov/?id=ED341224 under this link http://files.eric.ed.gov/fulltext/ED341224.pdf[ED341224.pdf].
If the link is dead now, take link:/CCS/copies-from-original/BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf[my copy],
trust me, it is the same.
I split this copy into each page to go through translation side by side. For the copies I use only the front and back-cover of
my book, the rest is from the source above.
White pages are left out, the pages are numbered like the copies are counted. Look at one page and you will recognize what is meant.

I guess the book can only be bought used now.
I wanted my own hardcover, on April the 17th in 2013 I received it a used book.

==== Help needed
At this time there are only english [EN] and german [DE] versions planned.
If you like to start translation to other languages, you are welcome.

You want to help me, but things like ruby, git and asciidoctor are aliens to you?
You only need an (email)editor (no html-format, just clean ascii).
Write the first email with following subject: Changing Canadian Schools
Tell me your name and if I am allowed to publish your email-adress
(you will be named as author, if you don't like to be named it_s OK too, just tell me).

Take a look at the link: https://github.com/MaWiMa/CCS/tree/master/en[source-files].
Correct the existing files or maybe do new-ones.
Just write the filename to the subject of your email in following form:

[source,bash]
----
Notation: <Language><Page>
Example:  EN001
----
So, if you like to correct the file EN-Changing_Canadian_Schools-050.txt, just write
EN050 as subject and send the whole new page.

If you translate this page to german, please write DE050 as subject, and send me your stuff. 

=== Transcript and Translation Website
You find the webpages here:
https://mawima.github.io/CCS/ 
(CCS is case-sensitive).

=== Transcript and Translation Source
You get the source, and a few scripts to build your own webpages from
https://github.com/MaWiMa/CCS
(MaWiMa/CCS is case-sensitive).


=== You like to build your own website?
You need an *editor*.
You need *ruby, asciidoctor* and a *browser* for testing
You should know how to use http://git-scm.com/[git] and write
http://www.methods.co.nz/asciidoc/[asciidoc].

If you are comfortable with git and github you could fork the repository
on https://github.com/MaWiMa/CCS and send a pull request.
It is described on https://help.github.com/articles/fork-a-repo.



=== Document tree

[source]
----

|-- copies-from-original
|-- de
|-- en
|-- inclusion
|-- images
|-- _site
|   `-- CCS
|       |-- adoc.css -> ../../adoc.css
|       |-- copies-from-original -> ../../copies-from-original
|       |-- de
|       |-- en
|       |-- inclusion -> ../../inclusion
|       |-- images    -> ../../images
|-- _tmp
|
|-- CCSdocres.txt
|-- CCSsta.txt
|-- CCStecter.txt
|-- adoc.css
|-- flipPages.rb
|-- index.txt
|-- makeWebPages.rb
`-- readme.txt

----

todo manually, only if you want to buld your on website for testing
----

_site                          # website dir, to be createad manually
_site/CCS/copies-from-original # symlink to copies from original dir
_site/CCS/de                   # dir has to be createad manually
_site/CCS/en                   # dir has to be createad manually
_site/CCS/images               # symlink to images dir
_site/CCS/inclusion            # symlink to inclusion directory
_site/adoc.css                 # symlink to adoc.css in root dir 
_tmp                           # dir has to be createad manually

----


It is all quiet simple, +
*if I can do this - anyone can!* +

To make basedir HTML-Pages, for example, just open a terminal and type

[source]
----
asciidoctor -D _site/CCS -a stylesheet=adoc.css -a linkcss readme.txt
----

to make the first Page of the English Version just type

[source,bash]
----
./makeWebPages.rb en 1
----

to make Page two to onehundretfiftyone of the English Version just type

[source]
----
./makeWebPages.rb en 2 151
----

To take a look at the website you did build, change to your DIR *_site*
open a terminal and run

[source]
----
ruby -run -e httpd . -p 8000
----

If your terminal shows something like this +
image:/CCS/images/terminal-webrick.png[image from terminal output of ruby -run -e httpd . -p 8000] +

open your browser and look for your website at *http://localhost:8000/CCS*


=== Transcript and Translation, why?  

Since 5th of March 2013 I try to transcript and translate *Changing Canadian Schools* into german.
I like to be a part of a socialgroup, so I start and hope a view or more will join. +

In former times I was an expert in special education, the german way, and in 2011 I changed my attitudes.
My attitude changed as I wrote a short comparsion on special education in Canada and Germany.
Since 1994 I should know about inclusion, because of the Salamanca Conference; I did not.

I recognized, special education, the way we do in germany till now is not the right way to help pupils be part of real life.

I believe inclusion is a good way to teach and learn, (but it has an horrible name), and in germany it seams to be down before
it is really started.
Maybe because it is done top-down. It seems as if things get done better, when learners and their parents want a change and new structures
in education.

My goal is to look with more than two eyes on inclusion, by going back a lot of years in an other country.
I would like to translate with many, not only because my translation is surely faulty and if your interested in working together with people on this,
we maybe also can discuss what education should do.

Changing Canadian Schools was written in french and english. We have a special discussion in germany --
just like an open competition in comparsion of empty statements -- we compare the words integration and inclusion, for what?
In french inclusion is integration, as far as I know native french speakers do not use the word inclusion.
In germany inclusion was first translated into integration, later it was redefined as inclusion, really backwards (Salamanca Declaration, german translation 2006 and 2010).

Now, to me, inclusion describes the ratified right to education for all. People are taught within the same general types of schools
in one study group. The diversity of individuals builds the basis, to the development of the skills of all.

[userinput3]#link:/CCS/index{ext-relative}[home] +
link:/CCS/CCSsta{ext-relative}[Status] +
link:/CCS/CCStecter{ext-relative}[Technical Terms] +
link:/CCS/en/EN-Changing_Canadian_Schools-008{outfilesuffix}[transcript in englisch] +
link:/CCS/de/DE-Changing_Canadian_Schools-008{outfilesuffix}[Übersetzung der Abschrift in deutsch] +
link:/CCS/copies-from-original/BestCopy_Changing_Canadian_Schools_Perspectives_on_Disability_and_Inclusion.pdf[copy of Changing Canadian Schools]#

WilliV109@gMail.com +
Norbert Reschke
