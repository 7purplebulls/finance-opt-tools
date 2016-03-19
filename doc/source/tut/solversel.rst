.. _tut-solversel:

**********************
Solver Select Tutorial
**********************

JuPOT gives you the option to choose between solvers that you want to optimize with.

This tutorial assumes that you have already completed the :ref:`Getting Started <tut-getting_started>` tutorial.

Lets say for example you installed ``Gurboi`` and want to utilize it as your solver of choice.

You must now install the ``Gurobi`` Julia Interface which can be found `here <https://github.com/JuliaOpt/Gurobi.jl>`_ .

This would install the ``Solver Object`` required to identify which solver you want to use.

.. note::

	The different solvers supported and their corresponding ``Solver Object`` is in the 
	`JuMP Documentation <http://jump.readthedocs.org/en/latest/installation.html#getting-solvers>`_.

.. code:: julia

	using Gurobi
	using JuPOT

This might give you a warning along the lines of:

.. warning::

	WARNING: both JuPOT and Gurobi export "optimize"; uses of it in module Main must be qualified

If it doesn't occur here, it should occur when we call the :func:`optimize` function.
This problem is because both JuPOT and Gurobi packages have an ``optimize`` function and Julia
doesn't necessarily understand exactly who to use.

This problem is generally countered by adding the name of the package you are using ahead of
the function being called like:

.. code:: julia

	JuPOT.optimize(mvo)

Which would identify clearly which optimize function is being called to Julia.

After properly setting up the environment, we now generate a set of data for a sample SimpleMVO example.

.. code:: julia

	# Generate synthetic data sets for Demonstration
	############
	# Assets
	############
	n = 10 # No. Of Assets
	returns = rand(n)
	covarariance = let
	    S = randn(n, n)
	    S'S + eye(n)
	end
	names = [randstring(3) for i in 1:n] # List of asset names

	# Assets data structure containing, names, expected returns, covarariance
	assets = AssetsCollection(names, returns, covarariance)

	# Target Return
	target_return = 0.2

	# Creating the SimpleMVO Object
	mvo = SimpleMVO(assets, target_return; short_sale=false)

When you want to use a specific solver, you need to create a ``Solver Object`` for that solver.

.. code:: julia

	gurobi_solver = GurobiSolver()

Then you pass the ``Solver Object`` you have created called ``gurobi_solver`` into the :func:`optimize` function.

.. code:: julia

	result = JuPOT.optimize(mvo; solver=gurobi_solver)

Passing of the solver object is done by utilizing a ``;`` between the regular input parameters of the :func:`optimize` function and the solver object input.

Congratulations, you can now specify which solver you want to use when you optimize!