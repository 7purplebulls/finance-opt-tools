.. _stdlib-asset:

******************
 Asset Collections
******************


Basic functions
---------------

.. function:: length(A)

	Returns the number of assets in ``A`` as an ``Integer`` 

Constructors
---------------

.. function:: AssetsCollection(names::Vector{AbstractString}, expected_returns::Vector{Real}, covariance::Matrix{Real})

	Returns the constructed AssetsCollection from the given inputs. Will throw errors if

Getters and Setters
--------------------

.. function:: getReturnForAsset(A, name::AbstractString)

	Returns the value of the given asset ``name`` expected returns.
	If ``name`` does not exist in ``A`` , it will throw an error:
	LoadError: The asset collection has no asset named ``name`` 

.. function:: setReturnForAsset(A, name::AbstractString, value::Real)

	Returns the ``value`` that was set as the expected return of ``name`` in ``A`` .
	If ``name`` does not exist in ``A`` , it will throw an error:
	LoadError: The asset collection has no asset named ``name`` 

.. function:: getVarForAsset(A, name::AbstractString)

	Returns the value of the variance of the given asset ``name`` .
	If ``name`` does not exist in ``A`` , it will throw an error:
	LoadError: The asset collection has no asset named ``name`` .

.. function:: setVarForAsset(A, name::AbstractString, value::Real)

	Returns the ``value`` that was set as the variance of ``name`` in ``A`` .
	If ``name`` does not exist in ``A`` , it will throw an error:
	LoadError: The asset collection has no asset named ``name`` 

.. function:: getCoVarForAssetPair(A, name1::AbstractString, name2::AbstractString)

	Returns the value of the covariance between the assets ``name1`` and ``name2`` .
	If ``name1`` does not exist in ``A`` , it will throw an error:
	LoadError: The asset collection has no asset named ``name1`` .
	If ``name2`` does not exist in ``A``, it will throw an error:
	LoadError: The asset collection has no asset named ``name2`` .
	If both ``name1`` and ``name2`` do not exist in ``A`` , it will throw an error for
	``name1`` as the first error to be encountered.

.. function:: setCoVarForAssetPair(A, name1::AbstractString, name2::AbstractString, value::Real)

	Returns the ``value`` that was set for the covariance between the assets ``name1`` and ``name2`` .
	If ``name1`` does not exist in ``A`` , it will throw an error:
	LoadError: The asset collection has no asset named ``name1`` .
	If ``name2`` does not exist in ``A``, it will throw an error:
	LoadError: The asset collection has no asset named ``name2`` .
	If both ``name1`` and ``name2`` do not exist in ``A`` , it will throw an error for
	``name1`` as the first error to be encountered.

	Will throw a warning if the ``value`` changed will cause the covariance matrix to no longer be positive semi-definite.

.. function:: getCovariance(A)

	Returns the Covariance Matrix of Real values as a Matrix{Real} from asset collection ``A`` .

.. function:: setCovariance(A, covariance::Matrix{Real})

	Returns the ``covariance`` that is set as the Covariance Matrix of the asset collection ``A`` .
	Will throw an error if the ``covariance`` to be changed will cause the covariance matrix to no longer be positive semi-definite.

.. function:: getReturns(A)

	Returns a Vector{Real} of the expected returns from asset collection ``A`` .

.. function:: setReturns(A, returns::Vector{Real})

	Returns the ``returns`` that is set as the expected returns of the asset collection ``A`` .

.. function:: getNames(A)

	Returns a Vector{AbstractString} of the asset names from asset collection ``A`` .

.. function:: setNames(A, names::Vector{AbstractString})

	Returns the ``names`` that are set as the asset names of the asset collection ``A`` .