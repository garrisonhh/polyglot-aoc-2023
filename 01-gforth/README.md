# gforth

you can run either solution by putting the text file in "input.txt" and running
`gforth <filename> -e bye`. each file contains a procedure for the part it
solves, so you can also just load it into the repl.

## comments

I was frustrated attempting this at first, but gforth is a surprisingly nice
experience once you get past the initial mindfuck of understanding the
stack-based paradigm. it has a full-featured repl, nice docs, and intuitive
debugging.

that being said, I would not want to write a program much larger than this, and
never anything a non-technical user would have to interact with. I do not
understand what kind of environment gforth is useful in, perhaps it would be
nice in an embedded environment or bootstrapping an OS or something like that?