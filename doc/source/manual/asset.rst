.. _man-functions:

****************
AssetsCollection
****************

An AssetsCollection in JuPOT is a container structure used to store a set of asset tickers, their corresponding expected returns and the covariance matrix.

The basic syntax for creating an AssetsCollection is

	.. code-block:: julia

	A = AssetsCollection(names, expected_returns, covariance)

Where ``A`` is the variable AssetsCollection that holds the newly created AssetsCollection. ``names`` is a Vector of Strings that holds the names of the asset tickers. ``expected_returns`` is a Vector of Floats that contain the corresponding expected returns of every asset. ``covariance`` is the associated Matrix of Floats for this AssetsCollection.

Once a ``A`` AssetsCollection object is created, it can be modified simply through calling any of the functions listed below:

=================== ==================
Expression          Calls
=================== ==================
``length(A)``            :func:`length`
``getReturnForAsset(A, name::AbstractString)``          :func:`getReturnForAsset`
=================== ==================
