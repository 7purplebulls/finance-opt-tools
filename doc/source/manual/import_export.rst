.. _manual-import_export:

**********************
Import and Export I/O
**********************

Importing
---------

The supported importing function :func:`getAssetAndReturnsFromCSV(filepath) <getAssetAndReturnsFromCSV>` will take a filepath and get the assets and their corresponding expected returns from the CSV file. This CSV would be arranged in the format of:

|	asset_name1, expected_return1
|	asset_name2, expected_return2
|	...

The resulting output of the function would be a structure that contains the assets and the expected returns arrays. A sample code is displayed before, showing how to set the values into an ``AssetsCollection`` after importing.

.. code-block:: julia

	data = getAssetAndReturnsFromCSV("filepath.csv")
	setNames(assetsCollection, data[1])
	setReturns(assetsCollection, data[2])


Exporting
---------

The export function :func:`exportModelResultsToCSV(result, filepath) <exportModelResultsToCSV>` will take in the output from an :func:`optimize(model, parameters) <optimize>` function as the result, and export it in CSV format to the filepath. With the first value in the CSV being the Objective Value and the ones after being the Weights.

|	objective_value
|	weight1
|	weight2
|	...


.. code-block:: julia

	result = optimize(model, parameters)
	exportModelResultsToCSV(result, "filepath.csv")



Custom Import/Export
--------------------

This can be done utilizing the `DataFrames Julia Package <https://github.com/JuliaStats/DataFrames.jl>`_. There documentation is located `here <http://learnxinyminutes.com/docs/julia/>`_.