using DifferentialEquations
using StatsPlots
using DataFrames
using PlutoUI
using PlutoTeachingTools
using LaTeXStrings
using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D
using Interpolations

### Creamos una interpolación lineal para obtener el valor de la demanda, dada la producción
production_data = Array(0.0:0.2:2.0)
demand_data = [2.0, 2.0, 2.0, 2.0, 1.4, 1.0, 0.6, 0.1, 0.1, 0.1, 0.1] 

plot(production_data, demand_data, 
     seriestype =:scatter, 
     title = "Production-demand", label = "Observado")
plot!(production_data, demand_data, label = "Interpolado")

## Agregamos valores extremos a los arreglos para obtener valores
## cuando la producción sea muy alta
append!(production_data, 1000.0)
append!(demand_data, 0.1)

## Definimos la interpolación lineal
interp_price_factor = LinearInterpolation(production_data, 
                        demand_data)

## Creamos una función if que recibe el valor de net_revenues, Debt y debt repayment fraction
function repayment_function(net_revenues, Debt, debt_repayment_fraction)
    return ifelse(
        net_revenues > 0.0 && Debt > 0.0 , 
        net_revenues*debt_repayment_fraction,
        0.0
    )
end

## Función que calcula los creditos obtenidos de acuerdo al tiempo de la 
## simulacion
function credit_amount(t)
    return ifelse(
        t >= 4 && t <= 10,
        100.0,
        0.0
    )
end

repayment_function_mtk(net_revenues, Debt, debt_repayment_fraction) = repayment_function(net_revenues, Debt, debt_repayment_fraction)
credit_amount_mtk(t) = credit_amount(t)
interp_price_factor_mtk(demanda) = interp_price_factor(demanda)
 
@register_symbolic repayment_function_mtk(net_revenues, Debt, debt_repayment_fraction)
@register_symbolic credit_amount_mtk(t)
@register_symbolic interp_price_factor_mtk(demanda)

## Creamos la estructura del modelo de simulación
@mtkmodel DebtCrisis begin
    # Parámetros del modelo y sus valores iniciales
    @parameters begin 
        investment_effectiveness = 0.5
        reinvestment_fraction = 0.5
        debt_repayments = 0.0
        deterioration_rate = 0.05
        specific_production = 1.0
        demand = 100.0
        interest_rate = 0.07
        debt_repayment_fraction = 0.5
    end
    ## Definición y valores iniciales de variables de estado e intermedias
    @variables begin
        ## Variables de estado (stock)
        ProductionPlants(t) = 0.0
        Debt(t) = 0.0
        ## Variables intermedias
        exogenous_credits(t)
        investments(t)
        endogenous_investments(t)
        net_revenues(t)
        revenues(t)
        sales(t)
        production(t)
        price_factor(t)
        interest_payments(t)
        
        ## Variables de flujo
        new_production_plants(t)
        deterioration(t)
        credits(t)
        additional_debt_due_interest_payment(t)
        repayment(t)
    end
    ## Definimos las ecuaciones de modelo
    @equations begin
        ## Ecuaciones de las Variables Intermedias
        production ~ ProductionPlants*specific_production
        sales ~ production
        price_factor ~ interp_price_factor_mtk(production/demand)
        revenues ~ sales * price_factor
        interest_payments ~ Debt*interest_rate
        net_revenues ~ revenues - interest_payments
        repayment ~ repayment_function_mtk(net_revenues, Debt, debt_repayment_fraction)
        endogenous_investments ~ max(net_revenues - repayment, 0.0)
        exogenous_credits ~ credit_amount_mtk(t)
        investments ~ endogenous_investments + exogenous_credits
        
        ## Ecuaciones de las Variables de Flujo
        new_production_plants ~ investments*investment_effectiveness
        deterioration ~ deterioration_rate*ProductionPlants
        additional_debt_due_interest_payment ~ max(-1*net_revenues , 0.0)
        credits ~ credit_amount(t)

        ## Ecuaciones de las tasas de cambio de los stocks
        D(ProductionPlants) ~ new_production_plants - deterioration
        D(Debt) ~ credits + additional_debt_due_interest_payment - repayment
    end
end

### Construimos una instancia del modelo
@mtkbuild mtk_model = DebtCrisis()

## Definimos los valores numéricos de la simulacion
sim_time = (0.0, 100.0)
h = 0.25

prob_ode = ODEProblem(mtk_model, [], sim_time, [])

## Resolvemos el modelo 
sol_ode = solve(prob_ode, RK4(), dt = h, adaptive = false)

