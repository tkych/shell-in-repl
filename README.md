shell-in-repl
=============

`#>` is a trivial read-macro for `uiop:run-program`.
It invokes SHELL __in__ REPL.


Examples
--------

      CL-REPL> #> cal
         December 2014
      Su Mo Tu We Th Fr Sa
          1  2  3  4  5  6
       7  8  9 10 11 12 13
      14 15 16 17 18 19 20
      21 22 23 24 25 26 27
      28 29 30 31
      => NIL, 0

      CL-REPL> #> date -u --rfc-3339=ns
      2014-12-29 23:28:06.013553387+00:00
      => NIL, 0

      CL-REPL> #> date -blablabla
      date: invalid option -- 'b'
      Try 'date --help' for more information.
      => #<UIOP/RUN-PROGRAM:SUBPROCESS-ERROR {100B104773}>, 1


Depends-on
----------

 - uiop
 - named-readtables


Installation
------------

0. SHELL$   `git clone https://github.com/tkych/shell-in-repl`
1. CL-REPL> `(push #p"/path-to-shell-in-repl/" asdf:*central-registry*)`
2. CL-REPL> `(ql:quickload :shell-in-repl)` or `(asdf:load-system :shell-in-repl)`
3. CL-REPL> `(named-readtables:in-readtable shell-in-repl:shell-syntax)`


Author, License
---------------

 - Takaya OCHIAI  <#.(reverse "moc.liamg@lper.hcykt")>

 - Public Domain
