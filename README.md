# spread

**spread** provides a set of defaults for creating and manipulating
spreadsheets in plain text documents.

The awesomeness comes from the fact that you don't need to use a
full-fledged spreadsheet program nor learn their crappy, inexpressive macro
languages -- you know, all that **=SUM(A4:F4)** junk. Instead, you get to
handle the data using the language of your choice! (As long as it's Awk or
Ruby, currently.)


## What spread assumes

This repository maintains little scripts which are sourced into the
appropriate interpreter. They all are prepared to handle **spreadsheet**
documents (suggested extension ".spread"), which are plain text documents
formatted like so: 

  - Fields are separated by 1 or more tab characters ("\t").
  - Records are separated by newlines ("\n").
  - Blank lines and lines which begin with a hash mark ("#") are ignored,
    kind of like comments.

It is usually trivial to change these settings. You can edit the script's
source yourself, or (if the interpreter allows) you can pass a command-line
switch.


## Using spread.awk

Using spread.awk is really simple. The Awk language really was suited for
these kind of text-processing tasks. You invoke the interpreter with
multiple "-f" switches like this:

    $ awk -f spread.awk -f myscript.awk data.spread

Alternately, if you have Gawk, you can source spread.awk inside your script
with the @include directive.

You are free to use BEGIN {} blocks in your own script -- the BEGIN block in
myscript.awk builds on top of the BEGIN block in spread.awk (it doesn't
replace it). Also remember you can specify the field separator with the -F
switch.

You can make your scripts slightly more useful with carefully selected "-v
var=value" options.


## Using spread.rb

You may or may not know that Ruby was somewhat designed to behave like Awk
or Perl if so desired. But you need to use a handful of tricks.

You can get Ruby scripts to behave kind of like Awk scripts if you invoke it
this way:

    $ ruby -an -r ./spread myscript.rb data.spread

The -n switch makes the interpreter pretend that a "while" loop surrounds
myscript.rb, such that myscript.rb is read for every record in data.spread.

The -a switch splits every record into an array of fields called **$F**.

Ruby actually provides BEGIN {} and END {} blocks which behave exactly like
those in Awk. So use them.

The only major caveat is that somewhere in your script (preferably right
after the BEGIN block) you have to include this line:

    next if blank?

This will properly ignore blank lines and comments in your spreadsheet. The
reason you have to do this in YOUR script stems from the fact that "next" in
Awk and Ruby actually mean totally different things.

Also remember that Ruby's "-s" switch allows you to assign variables a lot
like Awk's "-v var=value".


## Tips for drafting .spread files

If you use Vim, I recommend you use the following modeline in your document:

    # vim: nospell noexpandtab nolist nowrap nolinebreak ts=8 sts=8 sw=8

It might be better to add a filetype auto-command in your .vimrc. Refer to
my vimrc in my dotfiles repo.


## Examples

Here's a simple .spread file:

    # Last          First           Age

    Doe             Jane            47
    Koch            Christian       23
    Torvalds        Linus           43
    Doe             John            50
    Smith           Will            44
    Shazbot         Gregory-Philip  100


### Sample Awk script

    BEGIN {
      sum = 0
      n_people = 0
    }

    $1 == "Doe" {
      sum += int($3)
      n_people++ 
    }

    END {
      print "Total age of the Does:", sum
      print "Average age of the Does:", sum/n_people
    }


### Sample Ruby script

    BEGIN {
      $sum = 0
      $n_people =0
    }

    next if blank?

    if $F[0] == "Doe"
      $sum += $F[2].to_i
      $n_people += 1
    end

    END {
      print "Total age of the Does:", sum
      print "Average age of the Does:", sum.to_f/n_people
    }


## License

This code is in the public domain. It's not really substantial (although I
totally hurt my head trying to get the Ruby implementation to behave the way
I wanted it).
