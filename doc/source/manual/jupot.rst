.. _man-jupot:


JuPOT - Tutorial
================

.. code:: julia

    push!(LOAD_PATH, "/Users/shenwang/Projects/RBC/financial-opt-tools/src")
    
    using JuPOT
    using DataFrames
    
    # Generate synthetic data sets for Demonstration
    ############
    # Assets
    ############
    n = 10 # No. Of Assets
    returns = rand(n)
    covarariance = let
        S = randn(n, n)
        S'S + eye(n)
    end
    names = [randstring(3) for i in 1:n] # List of asset names
    
    # Assets data structure containing, names, expected returns, covarariance
    assets = AssetsCollection(names, returns, covarariance)




.. parsed-literal::

    10x2 DataFrames.DataFrame
    | Row | A     | B        |
    |-----|-------|----------|
    | 1   | "qpk" | 0.354764 |
    | 2   | "786" | 0.929591 |
    | 3   | "uPC" | 0.552491 |
    | 4   | "NHk" | 0.310286 |
    | 5   | "Qmu" | 0.595714 |
    | 6   | "6Xc" | 0.871733 |
    | 7   | "gBi" | 0.476924 |
    | 8   | "7rq" | 0.392108 |
    | 9   | "la9" | 0.685851 |
    | 10  | "xDT" | 0.701849 |



Simple MVO
----------

.. raw:: latex

   \begin{align}
   &\text{minimize} && w^\top\Sigma w \\
   &\text{subject to} && \mu^\top w\geq r_{\min} \\
   &       && \mathbf{1}^\top w = 1 \\
   &       && w \succeq 0 \\
   &       && \sum_{i=1}^{\infty}{w_i} \succeq 0 \\
   \end{align}

.. code:: julia

    ######################################################
    ################### SIMPLE MVO #######################
    ######################################################
    
    # Example 1: Basic
    target_return = 0.2
    # refer to model definition for keyword arguments, etc.
    mvo = SimpleMVO(assets, target_return; short_sale=false)




.. parsed-literal::

    
     Variables: 
    w[1:10] >= 0
    
     Constraints: 
    0x2 DataFrames.DataFrame
    
    
    
     Assets: 
     10x2 DataFrames.DataFrame
    | Row | A     | B        |
    |-----|-------|----------|
    | 1   | "qpk" | 0.354764 |
    | 2   | "786" | 0.929591 |
    | 3   | "uPC" | 0.552491 |
    | 4   | "NHk" | 0.310286 |
    | 5   | "Qmu" | 0.595714 |
    | 6   | "6Xc" | 0.871733 |
    | 7   | "gBi" | 0.476924 |
    | 8   | "7rq" | 0.392108 |
    | 9   | "la9" | 0.685851 |
    | 10  | "xDT" | 0.701849 | 




.. code:: julia

    abc = optimize(mvo)




.. parsed-literal::

    (0.6493707243141008,[0.051403867245335834,0.1393801424313705,0.17462066767866158,0.10837775720777901,0.15528244026904986,0.01975174174407225,0.020740515444269032,0.13510413094248896,0.04359954995906796,0.15173918707790807])





::


    LoadError: MethodError: `describe` has no method matching describe(::Tuple{Float64,Array{Float64,1}})
    Closest candidates are:
      describe(::Any, !Matched::DataFrames.AbstractDataFrame)
      describe{T<:Number}(::Any, !Matched::AbstractArray{T<:Number,N})
      describe{T}(::Any, !Matched::AbstractArray{T,N})
    while loading In[4], in expression starting on line 1

    


.. code:: julia

    df = DataFrame()




.. raw:: html

    <table class="data-frame"><tr><th></th></tr></table>



.. code:: julia

    df[:weights] = abc

.. code:: julia

    df[:names] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j"]

.. code:: julia

    df

.. code:: julia

    rename!(df, :x1, :weights)


Constraints
-----------

**constraint1**: :math:`\sum` asset group constraints

.. code:: julia

    ##################################
    # Example 2: Adding a Constraint #
    ##################################
    function genTechIndicator()
        [0,0,1,1,0,1,0,1,1,0]
    end
    
    # Adding a simple weight constraint
    constraints = Dict((:constraint1 => :(dot(w,tech) <= tech_thresh)),
                       (:constraint2 => :(dot(w,fin) <= Fin_thresh)))
    parameters = Dict(:tech=>genTechIndicator(), 
                      :tech_thresh => 0.3,
                      :fin=> [1,1,0,0,1,0,1,0,0,0],
                      :Fin_thresh => 0.05)
    # refer to model definition for keyword arguments, etc.
    mvo = SimpleMVO(assets, target_return, constraints; short_sale=false)
    w = optimize(mvo, parameters)
    
    # add checkers for constraints

.. code:: julia

    ####################################################### 
    # Example 3: Changing a Constraint's parameter values #
    #######################################################
    
    # Changing values of an entered constraint
    parameters[:tech_thresh] = 0.04
    
    # refer to model definition for keyword arguments, etc.
    mvo = SimpleMVO(assets, target_return, constraints; short_sale=false)
    optimize(mvo, parameters)

.. code:: julia

    ####################################
    # Example 4: Deleting a Constraint #
    ####################################
    
    # Removing a previously defined constraint
    delete!(constraints, :constraint2)
    delete!(parameters, :Fin_thresh)
    # refer to model definition for keyword arguments, etc.
    mvo = SimpleMVO(assets, target_return, constraints; short_sale=false)
    optimize(mvo, parameters)

.. code:: julia

    ##########################################
    # Example 5: Adding multiple Constraints #
    ##########################################
    
    # Adding a multiple weight constraints
    # constraints = Dict(:constraint1 => :(w[1:5] .<= assets_1_5_max), :constraint2 => :(w[6:n] .<= assets_6_n_max))
    # Adding a simple weight constraint
    constraints_1 = [symbol("x$i") => :(min_thresh <= w[$i]) for i=1:n]
    constraints_2 = [symbol("y$i") => :( w[$i] <= max_thresh) for i=1:n]
    parameters_1 = Dict(:min_thresh => 0, :max_thresh => 0.5, :n => n)
    
    # Different constraint sets can be merged to form new ones
    constraints = merge(constraints,constraints_1,constraints_2)
    parameters = merge(parameters,parameters_1)
    # refer to model definition for keyword arguments, etc.
    mvo = SimpleMVO(assets, target_return, constraints; short_sale=false)
    optimize(mvo, parameters)

.. code:: julia

    
    #####################################
    # Example 6: Using Different Assets #
    #####################################
    
    ############
    # Asset #2 #
    ############
    n = 10 # No. Of Assets
    returns_new = rand(n)
    covarariance_new = let
        S = randn(n, n)
        S'S + eye(n)
    end
    names_new = [randstring(3) for i in 1:n]
    # Assets data structure containing, names, expected returns, covarariance
    assets_new = AssetsCollection(names_new, returns_new, covarariance_new)
    
    
    # Using the same previously defined constraints we can run the model on a different set of assets effortlessly
    mvo = SimpleMVO(assets_new, target_return; short_sale=false)
    optimize(mvo, parameters)

.. code:: julia

    # Forgot what constraints and parameters were defined for initial constraints? No Problem!
    constraints # Prints the constraints

.. code:: julia

    parameters # prints the parameters

.. code:: julia

    # Using old constraints on new assets
    mvo = SimpleMVO(assets_new, target_return, constraints; short_sale=false)
    optimize(mvo, parameters)

.. code:: julia

    ##############################
    #  Example 7 Using Robust MVO#
    ##############################
    
    # refer to model definition for keyword arguments, etc
    # If no uncertainty matrix is entered the model defaults
    # to the ellipse whose axes are proportional to the 
    # individual variances of each asset
    
    rmvo = RobustMVO(assets, target_return; short_sale=true)
    optimize(rmvo, parameters)

.. code:: julia

    #################################################################
    #  Example 8 Creating Custom Functions (e.g efficient frontier) #
    #################################################################
    
    n = 20
    risk = Array(Float32,n)
    index = Array(Float32,n)
    for i in 1:n
       target_ret = i/21
       mvo = SimpleMVO(assets, target_ret; short_sale=true)
       optimize(mvo, parameters)
       risk[i] = mvo.objVal
       index[i] = target_ret
    end

.. code:: julia

    risk

.. code:: julia

    index


