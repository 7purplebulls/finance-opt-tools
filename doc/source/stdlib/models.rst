.. _stdlib-constraints:

*******
Models
*******

Constructor
-----------

.. function:: mvo = SimpleMVO(assets, target_return, constraints, short_sale=false)
		When setting the simple MVO, there are 4 fields to consider.
		1. Assets
		The ``asset`` field indicates the matrix of asset returns and covariances to be inputted into the model
		2. Target Return
		The ``target return`` specifies the minimum expected return of the optimal portfolio.
		3. Constraints
		The constraints define the set of constraints, outside of implied simple MVO constraints, to be applied during model optimization. 
		4. Short Sale flag
		This is a boolean indicating whether or not short sale is allowed for the model. It simples defines whether or not weights for assets can drop below zero. 

Getters and Setters
-------------------

.. function:: getDefault Constraints(m::AbstractModel)
	Return the default constraints of a given Model as a ConstraintsContainer
    type

.. function:: getConstraints(m::AbstractModel)
	Return an array of constraints as expressions

