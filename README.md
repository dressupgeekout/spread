# spread.awk

This Awk source provides a set of defaults for creating spreadsheets in
plain text documents. To include this functionality into your own
application, use "awk -f" multiple times, including **this** source first. I
recall that Gawk, in particular, has a "source" command that behaves like
sh's -- you could use that, too, I suppose.

I also recommend that your spreadsheet document use the following Vim
modeline (if you use Vim, of course):

    # vim: nospell noexpandtab sw=8 ts=8 sts=8

The hash mark at the beginning is OK (actually, it's kinda necessary)
because spread.awk will treat lines like that as comments. spread.awk will
also ignore blank lines.

I dedicate this code to the public domain, since it's so trivial.
