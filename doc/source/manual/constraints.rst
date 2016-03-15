.. _manual-constraints:

**********************
Constraint Definition
**********************

Introduction
-------------

The following tutorial will guide users on setting up, modifying and removing constraints. Please keep in find when a model is initialized, model defined constraints are already loaded into the optimization and only custom constraints need to be added.

Adding Constraints
-------------------
In **JuPOT** constraints are stored as stand alone dictionaries. This means that constraints can be added, deleted and modified modularly. To begin we can first define ``Constraint1``

.. code-block:: julia

	constraints = Dict((:constraint1 => :(dot(w,tech) <= tech_thresh)))

The constraint above indicates that the sum of all assets that carry *Tech Constraints* must be less than or equal to the ``tech_thresh``. However we can see that neither ``tech`` or ``tech_thresh`` is define yet. Therefore we must assign values to these through **Parameters**.

.. code-block:: julia

	parameters = Dict(:tech=>[1,1,0,0,1,0,1,0,0,0], 
	:tech_thresh => 0.3

We can see that ``tech`` is an indicator array showing whether an asset is in the tech sector while ``tech_thresh`` has been set to 0.3.

Changing Constraints
---------------------

All constraints are defined as unique dictionaries so in order to modify an existing constraints, one only needs to modify the parameter. Given the constraint above, if we wish to modify the value to ``tech_thresh`` we need to only make the following adjustments.

.. code-block:: julia

	parameters[:tech_thresh] = 0.04



Deleting Constraints
----------------------

In order to delete a constraint, users imply have to delete the constraint name from the dictionary. For good form, users should also remove the associated parameters.

.. code-block:: julia

	delete!(constraints, :constraint1)
	delete!(parameters, :tech_thresh)
	delete!(parameters, :tech)

In the example above, we have now delelted ``constraint1`` from the model and removed all parameters associated with ``constraint1``.


       
