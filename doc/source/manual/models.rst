.. _man-models:

******
Models
******

Simple Mean Variance Optimization
----------------------------------

The simple mean variance optmization is a technique to optimally allocate investments between assets. The gaol is globally reduce risk on investment at a specified expected return based on the covariance between asset groups. In a Simple MVO, the expect inputs are, **expected return of assets** and **correlation matrix between assets**. Given this, the optimization algorith will be able to output an optimal portfolio weight. 

In previous manuals you will have already learned about creating assets groups as well as constraint group. These groups can now be used to create a Simple MVO with the follow code.

.. code-block:: julia

	mvo = SimpleMVO(Asset_Group, target_return, constraints, short_sale)
	optimize(mvo, parameters)

==============  ==================================================================
Variable Name   Description                                                      
==============  ==================================================================
Asset Group     Set of Asset returns and covarianced inputtedf or analysis         
Target_Return   Expected target return of portfolio post optimization                
Constraints     Any non-model specific constraints to be used in optimization         
Short_Sale      A boolean indicating whether or not short selling will be allowed 
==============  ==================================================================

Robust Mean Variance Optimization
----------------------------------

Other methods of optimization such as Robust Mean Variance Optimization can also be applied onto asset and constraint groups.

.. code-block:: julia

	rmvo = RobustMVO(Asset_Group, target_return, constraints, uncertainty_set, uncertainty_set_size, short_sale)
	optimize(rmvo, parameters) 

====================  ==================================================================
Variable Name         Description                                                      
====================  ==================================================================
Asset Group           Set of Asset returns and covarianced inputtedf or analysis         
Target_Return         Expected target return of portfolio post optimization                
Constraints           Any non-model specific constraints to be used in optimization      
Uncertainty_Set                                                                         
Uncertainty_Set_Size                                                                   
Short_Sale            A boolean indicating whether or not short selling will be allowed 
====================  ==================================================================

.. comment

	TODO: Uncertainty_Set stuff

Minimum-Variance Optimization
----------------------------------

In minimum-variance optmization, the goal is to minize the risk of the portfolio. 

.. code-block:: julia

	mvar = MinVarO(Asset_Group, constraints, short_sale)
	optimize(mvar, parameters) 

==============  ================================================================== 
Variable Name   Description                                                      
==============  ==================================================================
Asset Group     Set of Asset returns and covarianced inputtedf or analysis        
Constraints     Any non-model specific constraints to be used in optimization         
Short_Sale      A boolean indicating whether or not short selling will be allowed 
==============  ==================================================================

Conditional Value at Risk (CVaR) Optimization
----------------------------------------------

.. code-block:: julia

	cvar = CVaRO(Asset_Group, losses, constraints, alpha, short_sale)
	optimize(cvar, parameters) 

==============  ================================================================== 
Variable Name   Description                                                     
==============  ==================================================================
Asset Group     Set of Asset returns and covarianced inputtedf or analysis         
Losses                                                                            
Constraints     Any non-model specific constraints to be used in optimization       
Alpha                                                                              
Short_Sale      A boolean indicating whether or not short selling will be allowed 
==============  ==================================================================


Optimize Function
-----------------

The :func:`optimize(M, parameters; solver=Default) <optimize>` function will optimize 
the models above using a solver with the parameters.

To change solvers, refer to the :ref:`solver select <solver-sel>` tutorial.

