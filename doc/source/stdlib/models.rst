.. _stdlib-constraints:

***************
Abstract Models
***************

Constructors
------------

.. function:: SimpleMVO(assets::AssetsCollection{Real, AbstractString}, target_return::Real, constraints::Dict{Symbol,Expr}; short_sale::Bool=false)

	When setting the Simple MVO, there are 4 fields to consider.

	1. Assets
	
	The ``asset`` field indicates the matrix of asset returns and covariances to be inputted into the model.
	
	2. Target Return
	
	The ``target return`` specifies the minimum expected return of the optimal portfolio.
	
	3. Constraints
	
	The constraints define the set of constraints, outside of implied simple MVO constraints, to be applied during model optimization. If not defined, it is implied to have no constraints but the default of SimpleMVO.
	
	4. Short Sale flag
	
	This is a boolean indicating whether or not short sale is allowed for the model. It simples defines whether or not weights for assets can drop below zero. If not defined, it is implied to be false.

.. function:: RobustMVO(assets::AssetsCollection{Real, AbstractString}, target_return::Real, constraints::Dict{Symbol,Expr}, uncertaintySet, uncertaintySetSize, short_sale::Bool=false)

	When setting the Robust MVO, there are 6 fields to consider.

	1. Assets
	
	The ``asset`` field indicates the matrix of asset returns and covariances to be inputted into the model.
	
	2. Target Return
	
	The ``target return`` specifies the minimum expected return of the optimal portfolio.
	
	3. Constraints
	
	The constraints define the set of constraints, outside of implied simple MVO constraints, to be applied during model optimization.

	4. The Uncertainty Set

	The ``uncertaintySet`` 

	5. The Uncertainty Set Size

	The ``uncertaintySetSize`` 
	
	6. Short Sale flag
	
	This is a boolean indicating whether or not short sale is allowed for the model. It simples defines whether or not weights for assets can drop below zero.
	


Optimize
------------

.. function:: optimize(M, parameters::Dict{Symbol,Any}, solver=JuMP.UnsetSolver())

	Optimizes the model ``M`` using the values in the dictionary of ``parameters`` using a ``solver`` , and returns a tuple of the objective value and an array of the weights. The ``solver`` is an optional ``Solver Object`` that can be passed in to define which solver to use while optimizing. The default is to let JuMP decide which solver to use.

Getters and Setters
-------------------

.. function:: getDefaultConstraints(M)

	Return the default constraints of model ``M`` as a ConstraintsContainer type.

.. function:: getConstraints(M)

	Return an array of constraints as expressions for model ``M`` .

.. function:: getObjective(M)

	Return the objective function of model ``M`` as an Expr type.

.. function:: getSense(M)

    Return the Sense of the model ``M`` , Min or Max.

.. function:: getVariables(M)

    Return the list of variables in the model ``M`` .

