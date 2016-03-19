.. _man-assets:

****************
AssetsCollection
****************

An AssetsCollection in JuPOT is a container structure used to store a set of asset tickers, their corresponding expected returns and the covariance matrix.

The basic syntax for creating an AssetsCollection is

.. code-block:: julia

    A = AssetsCollection(names, expected_returns, covariance)


Where ``A`` is the variable AssetsCollection that holds the newly created AssetsCollection. ``names`` is a Vector of Strings that holds the names of the asset tickers. ``expected_returns`` is a Vector of Floats that contain the corresponding expected returns of every asset. ``covariance`` is the associated Matrix of Floats for this AssetsCollection.

Once an ``A`` AssetsCollection object is created, it can be modified by any of the functions below.

Function Descriptions
----------------------

============================================================================  ==============================================================================
Function                                                                      Description
============================================================================  ==============================================================================
:func:`length(A) <length>`                                                    The number of assets in ``A`` 
:func:`getReturnForAsset(A, name) <getReturnForAsset>`                        The expected returns of ``name`` in ``A`` 
:func:`setReturnForAsset(A, name, value) <setReturnForAsset>`                 Sets ``name`` to ``value``  in ``A``
:func:`getVarForAsset(A, name) <getVarForAsset>`                              Gets the Variance of ``name`` in ``A`` 
:func:`setVarForAsset(A, name, value) <setVarForAsset>`                       Sets the Variance of ``name`` to ``value`` in ``A`` 
:func:`getCoVarForAssetPair(A, name1, name2) <getCoVarForAssetPair>`          Gets the Covariance of ``name1`` and ``name2`` in ``A`` 
:func:`setCoVarForAssetPair(A, name1, name2, value) <setCoVarForAssetPair>`   Sets the Covariance of ``name1`` and ``name2`` to ``value`` in ``A`` 
:func:`getCovariance(A) <getCovariance>`                                      Gets the Covariance Matrix of ``A`` 
:func:`setCovariance(A, covariance) <setCovariance>`                          Sets the Covariance Matrix to ``covariance`` in ``A`` 
:func:`getReturns(A) <getReturns>`                                            Gets the Vector of Expected Returns in ``A`` 
:func:`setReturns(A, returns) <setReturns>`                                   Sets the Vector of Expected Returns to ``returns`` in ``A`` 
:func:`getNames(A) <getNames>`                                                Gets the Vector of Names in ``A`` 
:func:`setNames(A, names) <setNames>`                                         Sets the Vector of Names to ``names`` in ``A`` 
============================================================================  ==============================================================================

Errors
-------

Error messages will stop the execution of any of the above functions and will not result in a change within the AssetsCollection.