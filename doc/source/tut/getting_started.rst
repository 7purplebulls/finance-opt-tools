.. _tut-getting_started:


****************
Getting Started
****************



Importing JuPot
---------------

1. Installing Solver

In order for this tutorial to work without issues you will need to have
a optimization solver installed for your Julia installation. If you have
not installed a solver for your Julia installation you can install one
by first opening a Julia terminal and then typing the following command
which will add the CLP solver:

julia> Pkg.add("Clp")

CLP is a free Open Source Solver that can be found here
https://projects.coin-or.org/Clp.

2. Setting the Path

JuPot is not yet setup in the Julia package path and therefore requires
an extra step when importing the package into a new environment. The
first step requires a command that adds the path of the JuPot package
into the current environment shown below.

.. code:: julia

	# For Windows Users
	push!(LOAD_PATH, "$(homedir())/Path/To/JuPOT/")
	
	# For Mac Users
	# push!(LOAD_PATH, "/Path/To/JuPOT/")

3. Importing the Package

Once the path has been set correctly you can now test to see if you can
import JuPot using the following Julia Command,

.. code:: julia

	using JuPOT

Simple MVO Financial Modeling Example
-------------------------------------

JuPOT was developed to streamline Financial Portfolio Optimization. One
of the most common models used in the industry is the simple MVO model.
The rest of this tutorial will show an MVO example to cover the
following JuPOT features:

-  Defining an Asset Object
-  Creating a Model Object
-  Running the Optimization
-  Creation/Addition/Deletion of Model Constraints
-  Changing a Constraint's Paramters

 1. Defining an Asset Object

With the JuPOT package imported in our current environment we are now in
the position to create an Asset Object. The Asset object is a software
object that will contain all the necessary information required for the
assets that are to be using during the optimization process. For the
simple MVO model the Asset data structure requires the following
parameters: \* A names vector (ie a list of labels for each of the
assets) \* A returns matrix (ie a matrix that contains the expected
returns of the assets) \* A covariance matrix (ie a matrix that contains
the covariances of all the assets)

In this tutorial we will generate our own random financial data.

.. note::

	The future values presented in this document may be different from yours, as the values are generated randomly.

.. code:: julia

	n = 10 # No. Of Assets
	returns = rand(n) # Returns a matrix of size(n) with entries between 0-1s
	covariance = let # This part generates a covariance matrix for the returns
		S = randn(n, n)
		S'S + eye(n)
	end
	
	tickers = [randstring(3) for i in 1:n] # List of asset names

Now that we have our asset list, expected returns, and covariance we can
now define our Asset Object.

.. code:: julia

	# Assets data structure containing, names, expected returns, covarariance
	assets = AssetsCollection(tickers, returns, covariance)

One neat feature of JuPOT is the fact that you can defined multiple sets
of assets at the same time! This feature exists to allow easy swapping
of different asset sets when defining a model object. The next part of
the tutorial will discuss how to define and optimize a model object.

2. Defining a Model Object

In this example we are running a simple MVO model on our set of assets.
In order to set up the MVO object we call the function "SimpleMVO". The
built in MVO function set up the following objective function.

.. raw:: latex

   \begin{align}
   &\text{minimize} && w^\top\Sigma w \\
   &\text{subject to} && \mu^\top w\geq r_{\min} \\
   &       && \mathbf{1}^\top w = 1 \\
   &       && w \succeq 0 \\
   &       && \sum_{i=1}^{\infty}{w_i} \succeq 0 \\
   \end{align}

.. code:: julia

	target_return = 0.2
	mvo = SimpleMVO(assets, target_return; short_sale=false)

We now have created a simple MVO model object called "mvo". In order to
run the optimization we call the :func:`optimize` function, passing the MVO
object as a parameter. The printed output represents the optimized
weights for the defined assets given their expected returns and
covariances.

.. code:: julia

	optimize(mvo)


.. parsed-literal::

	(0.6770945295038107,[0.23139516562088264,5.639370208919988e-11,0.2268200385109376,0.08008854839530366,0.07396216415563542,0.08548711025588242,0.11481169593806027,0.09054634792972655,0.09688892912978656,7.389778756327122e-12])

.. note::

	Remember these values might be different from yours, as the initial set was generated randomly.


MVO with User-Defined Constraints
---------------------------------

User-Defined Constraints & Parameters
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Another phenomenal feature of JuPOT is the fact that the user can
dynamically defined, modify, and delete constraints for the model they
are using. This section will outline this trailblazing process by
demonstrating the constraints listed below that will be used for the MVO
model we defined earlier in the tutorial.

-  Asset Grouping Constraints
-  Modifying Constraint Parameters
-  Deleting a Constraint
-  Adding Multiple Constraints

Before we go to the examples some background on the Constraints Object.
The Constraints object is defined as a dictionary that will contain the
constraints in the form of "expressions" which are equivalent to their
mathematical form. The following example best highlights this fact.

Say you want to define an expression that states all of the technology
stocks in the portfolio are required to be less than or equal to a
defined threshold (t).

:math:`TechStock <= TechThreshold` is written as
:math:`dot(weights,TechStocks) <= TechThreshold)`

Where the function $dot(weights, TechStocks) extracts the weights that
are related to the technology stocks using the labeling vector
TechStocks. The important thing to note is that no numerical values have
been used (ie only expressions). We will now see how this concept is
applied to defining a constraint.

Asset Group Constraints
~~~~~~~~~~~~~~~~~~~~~~~

.. code:: julia

	constraints = Dict((:constraint1 => :(dot(w,tech) <= tech_thresh)),
					   (:constraint2 => :(dot(w,fin) <= Fin_thresh)))

Great! So now we have defined our constraints but we are still missing
the parameters (ie the values we want for tech\_thresh and Fin\_thresh).
Setting the parameters for our constraints is done separately in order
to facilitate easy modifications. Essentially once you have defined your
constraints you can change the parameters by simply redefining the
Parameter's Dictionary without having to modify the Constraints. The
next example illustrates this concept.

Defining Parameters
~~~~~~~~~~~~~~~~~~~

.. code:: julia

	parameters = Dict(:tech=>[0,0,1,1,0,1,0,1,1,0], # remember from the constraints we defined above, tech is the labeling vector
	:tech_thresh => 0.3, # this threshold indicates the maximum weight allowed for tech stocks
	:fin=> [1,1,0,0,1,0,1,0,0,0], # This is the labeling vector for finance stocks
	:Fin_thresh => 0.1) # this threshold defines the maximum weight for finance stocks allowed

To illustrate one of the benefits of using JuPOT the next example will
show how to change a parameter. Say for example, you wish to alter the
maximum weight threshold for tech stocks in response to a new investment
strategy. The following code will show exactly how simple such a change
is.

.. code:: julia

	# Remember that we defined our parameters as a dictionary
	parameters[:tech_thresh] = 0.6 # Voila!

Now that we have defined a set of constraints and parameters lets move
onto how we incorporate these into our MVO object. To add user-defined
constraints to an MVO object we simply pass the constraints dictionary
as an extra parameter as shown in the following example.

.. code:: julia

	mvo = SimpleMVO(assets, target_return, constraints; short_sale=false)

.. parsed-literal::

	
	 Variables: 
	w[1:10] >= 0
	
	 Constraints: 
	2x2 DataFrames.DataFrame
	| Row | Keys        | Constraint                    |
	|-----|-------------|-------------------------------|
	| 1   | constraint1 | :(dot(w,tech) <= tech_thresh) |
	| 2   | constraint2 | :(dot(w,fin) <= Fin_thresh)   |
	
	
	 Assets: 
	 10x2 DataFrames.DataFrame
	| Row | A     | B         |
	|-----|-------|-----------|
	| 1   | "d5j" | 0.47117   |
	| 2   | "5ce" | 0.0442691 |
	| 3   | "fw2" | 0.619319  |
	| 4   | "lsu" | 0.0110536 |
	| 5   | "GtC" | 0.133128  |
	| 6   | "CyY" | 0.840685  |
	| 7   | "s9w" | 0.0744033 |
	| 8   | "1pP" | 0.0532713 |
	| 9   | "9GR" | 0.71077   |
	| 10  | "wIC" | 0.893267  | 


Congratulations! You have succesfully added your own custom constraints
to the MVO model and did not throw the computer out the window. IT will
be excstatic.


Optimizing With Parameters
~~~~~~~~~~~~~~~~~~~~~~~~~~

To run the optimization you now need to pass the parameters dictionary
as an additional argument to the optimize function.

.. code:: julia

	optimize(mvo, parameters)




.. parsed-literal::

	(11.90649844572114,[2.2794628281174675e-10,0.04999999937492011,4.617478125408177e-11,0.049999999823038405,1.1705825938750947e-10,1.8514010361178518e-11,1.8930647260561038e-10,2.788472943401233e-11,7.245548765584464e-11,0.9000000001027015])


Merging Sets of Assets and Constraints
--------------------------------------

The last thing to learn before moving on is how to
add constraints and merge different sets of constraints. Because the
constraints object is defined as a dictionary it is quite simple to
merge two sets of constraints. Watch out, when you merge constraints to
create a larger dictionary of constraints don't forget to do the same
for the parameters.

.. warning:: 

	Keep in mind if you have the same symbols in the dictionaries, the later one in the merge function will overwrite the previous ones.

	See the `Julia Official Documentation <http://docs.julialang.org/en/release-0.4/>`_ for more information.


.. code:: julia

	constraints_1 = [symbol("x$i") => :(min_thresh <= w[$i]) for i=1:n] # this sets a minimum weight for each asset
	constraints_2 = [symbol("y$i") => :( w[$i] <= max_thresh) for i=1:n] # this sets a maximum weight for each asset
	
	parameters_1 = Dict(:min_thresh => 0, :max_thresh => 0.7, :n => n)
	
	constraints = merge(constraints,constraints_1,constraints_2) # you just merged three sets of constraints
	parameters = merge(parameters,parameters_1) # an now you merged their set of parameters


.. parsed-literal::

	Dict{Symbol,Any} with 7 entries:
	  :tech        => [0,0,1,1,0,1,0,1,1,0]
	  :tech_thresh => 0.6
	  :max_thresh  => 0.7
	  :fin         => [1,1,0,0,1,0,1,0,0,0]
	  :n           => 10
	  :Fin_thresh  => 0.1
	  :min_thresh  => 0



Notice that in the output you see all the relevant parameters needed to
evaluate the constraints set you just defined. The next part will show
how to delete a constraint from the master list.

Note that we also delete the respective parameter as well. This is not
necessary but is it is good practice.

.. code:: julia

	delete!(constraints, :constraint2)
	delete!(parameters, :Fin_thresh)




.. parsed-literal::

	Dict{Symbol,Any} with 6 entries:
	  :tech        => [0,0,1,1,0,1,0,1,1,0]
	  :tech_thresh => 0.6
	  :max_thresh  => 0.7
	  :fin         => [1,1,0,0,1,0,1,0,0,0]
	  :n           => 10
	  :min_thresh  => 0



Now to run the optimization with the newly modified/defined constraints
simply repeat the procedure shown earlier where you instantiate a model
object using the new constraints & parameters dictionary as input
arguments.

.. code:: julia

	mvo = SimpleMVO(assets, target_return, constraints; short_sale=false)
	optimize(mvo, parameters)




.. parsed-literal::

	(0.7950797830454557,[0.14793896011925078,0.14250828049828448,0.06065446429498908,0.06685276760919971,0.09784209811932233,0.07066037147158193,0.24205710864439633,0.05616846274299124,0.0751363309355665,0.04018115556440407])



The End

You've now completed the introductory JuPOT tutorial and are now ready
to take advantage of the features this financial portfolio optimization
package has to offer. Now go generate some SWEET DELICIOUS RETURNS!
