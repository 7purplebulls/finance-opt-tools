.. _stdlib-collections:

.. currentmodule:: Base

************
 Collections
************

.. function:: getindex(collection, key...)

   Retrieve the value(s) stored at the given key or index within a collection.
   The syntax ``a[i,j,...]`` is converted by the compiler to
   ``getindex(a, i, j, ...)``.

.. function:: setindex!(collection, value, key...)

   Store the given value at the given key or index within a collection. The syntax ``a[i,j,...] = x`` is converted by the compiler to ``(setindex!(a, x, i, j, ...); x)``\ .



.. function:: constant(isConstant)

  .. Heya

  This is a constant

:obj:`Dict` is the standard associative collection.


.. function:: Dict([itr])

   ``Dict{K,V}()`` constructs a hash table with keys of type ``K`` and values of type ``V``.

   BLAHBLAHBLAH

   .. doctest::

     julia> Dict([("A", 1), ("B", 2)])
     Dict{ASCIIString,Int64} with 2 entries:
       "B" => 2
       "A" => 1

   If you want code blocks without any heading text, you can setup with the below doctest

   .. doctest::

     julia> Dict("A"=>1, "B"=>2)
     Dict{ASCIIString,Int64} with 2 entries:
       "B" => 2
       "A" => 1