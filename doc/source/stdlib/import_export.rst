.. _stdlib-import_export:

**********************
Import and Export I/O
**********************


Basic functions
---------------

.. function:: getAssetAndReturnsFromCSV(filepath::AbstractString)

	Returns a tuple of vectors, with the first element being an asset name vector, and the second element being the expected returns vector.

.. function:: exportModelResultsToCSV(result::Tuple{R,Array{R,1}}, filepath::AbstractString)

	Returns true when properly exported. Takes the output of :func:`optimize(M) <optimize>` and exports it to the filepath given