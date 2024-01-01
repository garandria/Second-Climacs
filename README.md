# Second Climacs: An Emacs-like editor

Second Climacs is an Emacs-like editor written entirely
in Common Lisp. It is called Second Climacs because it is a complete
rewrite of the Climacs text editor.

## Improvements

Climacs gave us some significant experenice with writing a text
editor, and we think we can improve on a number of aspects of it. As
a result, there are some major differences between Climacs and
Second Climacs:

*  We implemented a better buffer representation, and extracted it
   from the editor code into a separate library named Cluffer.  The
   new buffer representation will have better performance, especially
   on large buffers, and it will make it easier to write
   sophisticated parsers for buffer contents.

 * The incremental parser for Common Lisp syntax of Climacs is very
   hard to maintain, and while it is better than that of Emacs, it is
   still not good enough.  Second Climacs uses a modified version of
   the Common Lisp reader in order to parse buffer contents, making
   it much closer to the way the contents is read by the Common Lisp
   compiler.

 * Climacs depends on McCLIM for its graphic user interface.  Second
    Climacs is independent of any particular library for making
    graphic user interfaces, allowing it to be configured with
    different such libraries.  Though, at the moment, the only graphic
    user interface that exists uses McCLIM.
## Quick Start

1. Make sure you have installed the dependencies:

[the Cluffer repository]:https://github.com/robert-strandh/Cluffer
[the Cluffer Emacs Compatiblity]:https://github.com/robert-strandh/cluffer-emacs-compatibility
[the Stealth mixin repository]:https://github.com/robert-strandh/Stealth-mixin
[the Eclector repository]:https://github.com/s-expressionists/Eclector
[the Incrementalist repository]:https://github.com/robert-strandh/incrementalist

   * A recent 64-bit version of SBCL
   * The system "cluffer" from [the Cluffer repository]
   * The system "cluffer-emacs-compatibility" from [the Cluffer Emacs Compatiblity]
   * The system "stealth-mixin", from [the Stealth mixin repository]
   * The system "eclector", from [the Eclector repository]
   * The system "incrementalist" from [the Incrementalist repository]

The bash script `get-dependencies.sh` will do this work for you.

2. Clone the [source] with `git`:

   ```
   $ git clone https://github.com/robert-strandh/Second-Climacs
   $ cd Second-Climacs
   ```

3. Make sure the top-level directory can be found by ASDF.

4. Compile the editor system as follows:

   ```lisp
   (asdf:load-system :second-climacs-clim)
   ```

5. To start Second Climacs, execute this form:

   ```lisp
   (second-climacs-clim-base:climacs)
   ```


[source]: https://github.com/robert-strandh/Second-Climacs

## Documentation

[Documentation]:https://github.com/robert-strandh/Second-Climacs/tree/master/Documentation

Check the [Documentation] directory for more information.

## Commands
At the moment, all you can do is type some text, and you can use C-x i
to insert and existing file.  Some basic Emacs commands also work, like
`C-f`, `C-b`, `C-p`, `C-n`, `M-<`, `M->`, and `C-x` `C-c`.  The visible window does not
automatically follow the cursor yet.

[CONTRIBUTING.md]: https://github.com/robert-strandh/Second-Climacs/blob/master/CONTRIBUTING.md

## Contributing

I am not accepting contributions at this time.  I will make an
exception for someone who is highly motivated and willing to spend
time understanding the goals of the project, and then only after
discussing the ideas with me.
