.. _devdocs-init:

.. currentmodule:: Base

*************************************************
Documentation quick-guide for this
*************************************************

To highlight specific words/values in "code blocks"

The standard reST inline markup is quite simple: use

one asterisk: *text* for emphasis (italics),
two asterisks: **text** for strong emphasis (boldface), and
backquotes: ``text`` for code samples.

Use ``HIGHLIGHTED`` with the spacing around it. Make sure its space``word``space 
or else it'll end up like this.


To make raw code blocks we do this::

    code block
    of however many lines we want
    foo
    bar
    la
    boo
    mee
    doh

And end by just removing the indent

There needs to be a newline between the :: and the code block or else it'll be::
	like this

You need the :: or else it'll be like this
	
	Heya, no :: ending the above line

It'll just have a : if you do::

and have no indent here, and it'll throw a warning of literal block expected; none found


Without the :: at the end
	and you do this it'll be a heading


If you want to run raw ``latex`` stuff

.. raw:: latex

    \begin{CJK*}{UTF8}{mj}

::

    $ echo 'println("Greetings! 你好! 안녕하세요?")' > ~/.juliarc.jl
    $ julia
    Greetings! 你好! 안녕하세요?

    ...

.. raw:: latex

    \end{CJK*}s



If we want code-blocks with julia syntax

.. code-block:: julia

    if VERSION > v"0.4"
        "..."
        f(x) = x
    end

Math
---------

The input format is LaTeX math syntax without the “math delimiters“ ($ $), for example:

The area of a circle is :math:`A_\text{c} = (\pi/4) d^2`.



Links
---------

Links can be included like this
with the ` <>`_ format

`Hyperlink text <hyperlink/itself>`_

`Learn Julia in a few minutes <http://learnxinyminutes.com/docs/julia/>`_

Lists
---------


- Will give you a bullet point list
- Yay
- Now


* This is a bulleted list.
* It has two items, the second
  item uses two lines.

1. This is a numbered list.
2. It has two items too.

#. This is a numbered list.
#. It has two items too.
#. but continues off the previous list

How do you break the list?

#. by just putting some other block of text in between

1. or by doing this!

#. setting a value. one

Or how do you start on a different value?

10. by just starting on it

#. then adding the # signs



Nested lists are possible, but be aware that they must be separated from the parent list items by blank lines:

* this is
* a list

  * with a nested list
  * and some subitems

* and here the parent list continues


term (up to a line of text)
   Definition of the term, which must be indented

   and can even consist of multiple paragraphs

next term
   Description.



Making a table
==============

This shows you how to make a table -- if you only want to make a list see :ref:`making-a-list`.

==================   ============
Name                 Age
==================   ============
John D Hunter        40
Cast of Thousands    41
And Still More       42
==================   ============

.. _my-reference-label:

Section to cross-reference
--------------------------

This is the text of the section.

This is the text of the section.

This is the text of the section.

.. _my-middle-reference-label:

My middle reference label.

This is the text of the section.

This is the text of the section.

This is the text of the section.

This is the text of the section.


This is the text of the section.

This is the text of the section.

This is the text of the section.

This is the text of the section.

This is the text of the section.

This is the text of the section.


It refers to the section itself, see :ref:`my-reference-label`.

Labels that aren’t placed before a section title can still be referenced to, but you must give the link an explicit title, using this syntax: :ref:`Link title <label-name>`.

:ref:`Here's the Middle reference label <my-middle-reference-label>`


Referencing other documents::
	These are like this

``function`` 
:ref:`either syntax <man-functions>`


Can also deal with Referencing like this:


.. function:: testFunc()

  lalalala
  random text
  here to save the day




=================== ==================
Expression          Calls
=================== ==================
``A[i]``            :func:`getindex`
``A[i]=x``          :func:`setindex!`
=================== ==================

If you click on the getindex,

it'll take you to the location with:
Or the Collections file as that has it



A similar thing can happen with

:obj:`Dict` is the standard associative collection.


:const:`constant` is here, doesn't seem like it matters what you use

:bloop:`constant` hello see? <- nope bloop doesn't work!, but const, obj, and func all work along same principles


filler text

filler text

filler text


:func:`testFunc`


