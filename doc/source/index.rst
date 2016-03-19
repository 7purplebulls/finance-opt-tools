
%%%%%%%%%%%%%%%%%%%%%
 JuPOT Documentation
%%%%%%%%%%%%%%%%%%%%%

* :ref:`tut`
* :ref:`manual`
* :ref:`stdlib`

**************
 Introduction
**************

.. _intro:

JuPOT is a package in Julia that leverages the power of `JuMP <https://github.com/JuliaOpt/JuMP.jl>`_ 
to design a simple and powerful tool for the set-up of portfolio optimization problems. The package 
gives power to create objects to contain the :ref:`Assets <man-assets>` the :ref:`Constraints <man-constraints>` and :ref:`Models <man-models>`
and :func:`optimize` the portfolios created. It simplifies this process to be very easy to create and modify portfolio optmiziations, speeding up 
the workflow of portfolio optimization.

.. _tut:

################
Getting Started
################

.. toctree::
   :maxdepth: 2

   tut/getting_started
   tut/eff
   tut/solversel

.. _manual:

######
Manual
######

.. toctree::
   :maxdepth: 2

   manual/asset
   manual/constraints
   manual/models
   manual/import_export


.. _stdlib:

##################
Standard Library
##################

.. toctree::
   :maxdepth: 2

   stdlib/asset
   stdlib/models
   stdlib/import_export