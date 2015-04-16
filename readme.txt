:source-highlighter: coderay

== Transcript and Translation Website
You should find the webpages here:
https://mawima.github.io/CCS/ 
(this is case-sensitive)

== Transcript and Translation Source
You get the source, and a few scripts to build your own webpages from
https://github.com/MaWiMa/CCS
(this is case-sensitive)

== Help needed
At this time there are only english [EN] and german [DE] versions planned.
If you like to start translation to other languages, it would be great and
you are welcome.

You want to help, but things like ruby, git and asciidoctor are aliens
to you?
You only need an Editor (please do not use a word-processor).
Write the first email with following subject: Changing Canadian Schools
Tell me your name and if I am allowed to publish your email-adress
(you will be named as author, if you don't like to be named it's OK, but
you should get the credit).

Take a look at the link:
https://github.com/MaWiMa/CCS/tree/master/en[source-files].
Correct the existing files or maybe do new-ones.
Just write the filename to the subject of your email in following form:

[source,bash]
----
Notation: <Language><Page>
Example:  EN001
----
So, if you like to correct the file EN-Changing_Canadian_Schools-050.txt, just write
EN050 as subject and send the whole new page.

If you translate this page to german, please write DE050 as subject, and
send me your stuff. 


=== You like to build your own website?
You need an *editor*.
You need *ruby, asciidoctor* and a *browser* for testing.
You should know how to use http://git-scm.com/[git] and write
http://www.methods.co.nz/asciidoc/[asciidoc] with
http://asciidoctor.org/docs/[asciidoctor].

If you are comfortable with git and github you could fork the repository
on https://github.com/MaWiMa/CCS and send a pull request.
How to do this, is described on
https://help.github.com/articles/fork-a-repo.

==== Document tree

Todo manually, only if you want to build your own website for testing

----
_tmp    # dir has to be created manually
----


[source]
----

|-- CCS
|   |-- CCS-theme.yml
|   |-- adoc.css
|   |-- copies-from-original
|   |-- de
|   |-- en
|   |-- images
|   `-- inclusion
|
|-- _tmp
|-- de
|-- en
|-- included
|   `-- CCSdocres.txt
|
|-- CCSbacgro.txt
|-- CCSsta.txt
|-- CCStecter.txt
|-- flipPages.rb
|-- index.txt
|-- license.txt
|-- makeBase.rb
|-- makePages.rb
`-- readme.txt

----


Building the pages is quite simple, +
To make *all* basedir HTML-Pages just open a terminal and type

[source]
----
for i in *.txt;do ./makeBase.rb $(basename "$i" .txt);done
----

If you just want to build the page that you changed, type 

[source]
----
./makeBase.rb index
----

At the moment you can build separate hmtl-pages this way:

To make Page one of the English Version just type:

[source]
----
./makePages.rb EN html 1
----

To make Page two to onehundretfiftyone of the English Version just type:

[source]
----
./makePages.rb EN html 2 151
----

Everytime you run this command the all-in-one-HTML-Page gets updated.


[source]
----
./makePages.rb EN html 1
----



To take a look at the website you did build run:

[source]
----
ruby -run -e httpd . -p 8000
----

Your terminal should show something like this:

image:/CCS/images/terminal-webrick.png[image from terminal output of ruby -run -e httpd . -p 8000] +

If it does, open your browser and look for your website
at *http://localhost:8000/CCS*


//git subtree push --prefix CCS origin gh-pages
