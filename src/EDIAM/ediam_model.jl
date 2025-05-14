using ModelingToolkit
using ModelingToolkit: t_nounits as t, D_nounits as D


## Definimos en modelo con ModelingToolkit
@mtkmodel EDIAM begin
    @parameters begin
        ### Parámetros del modelo y sus valores iniciales
        # Elasticidad de sustitucion
        ε =  3.5
        # Proporcion de ingreso de capital en el ingreso total
        α = 0.33
        size_factor = 1.0
        # retornos a la productividad de R&D en el sector renovable.
        γ_re
        k_re
        # retornos a la productividad de R&D en el sector de carbono.
        γ_ce
        k_ce
        # propensión a la innovación en el sector renovable.
        η_re
        # propensión a la innovación en el sector de carbono
        η_ce
        # probabilidad de éxito al imitar o adaptar tecnologı́a del sector renovable desarrollada en la región avanzada por parte de la región emergente
        ν_re
        # probabilidad de éxito al imitar o adaptar tecnologı́a del sector de carbono desarrollada en la región avanzada por parte de la región emergente.
        ν_ce
        # measures the rate of environmental degradation resulting from the production of dirty inputs
        qsi = 0.010054
        # tasa promedio de regeneración ambiental natural
        δ_S = 0.001823
        # Incremento de la temperatura con respecto a los tiempos preindustriales que genera desastre climático
        Δ_T_Disaster = 8.0
        # sensibilidad de la atmósfera a emisiones de CO2 (grados celsius)
        β_T = 4.997053
        # nivel inicial de concentración de C 02 en la atmósfera al inicio del siglo XX.
        CO2_base = 289.415046
        # nivel de emisiones de C 02 que resultarı́a en un incremento de la temperatura de 6.0C con respecto a niveles preindustriales.
        CO2_Disaster = 1298.216153
        # Tasa de crecimiento de la población en la región avanzada
        labor_growth_N
        # Tasa de crecimiento de la población en la región emergente
        labor_growth_S
        # tasa de descuento.
        ρ = 0.01
        λ = 0.1443
        # inversa de la elasticidad intertemporal de sustitución.
        σ = 2
        # impuesto al carbono en la región avanzada
        ce_tax_N = 0.0
        # impuesto al carbono en la región emergente
        ce_tax_S = 0.0
        # Subsidio para tecnologı́as de energia sostenible en la región avanzada
        Tec_subsidy_N = 0.0
        # Subsidio en R&D para tecnologóas de energı́a sostenible en la región avanzada
        RD_subsidy_N = 0.0
        # Subsidio para tecnologı́as de energia sostenible en la región emergente
        Tec_subsidy_S = 0.0
        # Subsidio en R&D para tecnologóas de energı́a sostenible en la región emergente
        RD_subsidy_S = 0.0
        # Subsidio para tecnologı́as de energia sostenible en la región avanzada del Fondo Verde del Clima
        Tec_subsidy_GF_N = 0.0
        # Subsidio para en R&D de energia sostenible en la región avanzada del Fondo Verde del Clima
        RD_subsidy_GF_N = 0.0
        ## Y renewable energy, advanced economies
        Yre_N_0 = 25.1
        ## Y carbon energy, advanced economies
        Yce_N_0 = 144.9
        ## Y renewable energy, emerging economies
        Yre_S_0 = 9.0
        ## Y carbon energy, emerging economies
        Yce_S_0 = 105.3
        ### Environment quality
        S_0 = 915.970085
        #Initial Productivity conditions are determined by the initial levels of production of energy
        #In the Northern Region
        Ace_N_0 = ((Yce_N_0^((ε-1)/ε)+Yre_N_0^((ε-1)/ε))^(ε/(ε-1)))*(1+(Yce_N_0/Yre_N_0)^((1-ε)/ε))^(1/((1-α)*(1-ε)))
        Are_N_0 = ((Yce_N_0^((ε-1)/ε)+Yre_N_0^((ε-1)/ε))^(ε/(ε-1)))*(1+(Yre_N_0/Yce_N_0)^((1-ε)/ε))^(1/((1-α)*(1-ε)))
        #In the Southern Region
        Ace_S_0 = (1/size_factor)*((Yce_S_0^((ε-1)/ε)+Yre_S_0^((ε-1)/ε))^(ε/(ε-1)))*(1+(Yce_S_0/Yre_S_0)^((1-ε)/ε))^(1/((1-α)*(1-ε)))
        Are_S_0 = (1/size_factor)*((Yce_S_0^((ε-1)/ε)+Yre_S_0^((ε-1)/ε))^(ε/(ε-1)))*(1+(Yre_S_0/Yce_S_0)^((1-ε)/ε))^(1/((1-α)*(1-ε)))

    end

    @variables begin
        ### Variables de estado y sus valor inicial
        # Productividad del sector de renovables en la región avanzada
        Are_N(t) = Are_N_0
        # Productividad del sector fosil en la región avanzada
        Ace_N(t) = Ace_N_0
        # Productividad del sector de renovables en la región emergente
        Are_S(t) = Are_S_0
        # Productividad del sector fosil en la región avanzada
        Ace_S(t) = Ace_S_0
        # Calidad de ambiente
        S(t) = S_0
        
        # Variables intermedias
        φ(t)
        #this is the cost of production of clean technologies
        epsi_re(t) 
        #this is the cost of production of dirty technologies
        epsi_ce(t)
        ### North Region
        #Auxiliaries in North
        # Labour on the North
        L_N(t)
        #gamma displays decreasing returns as in Stiligtz
        γ_re_t_N(t)
        #gamma displays decreasing returns as in Stiligtz
        γ_ce_t_N(t)
        ### Subsidies for research and development
        RelPrice_N(t)
        RelLabor_N(t)
        # Clean sector
        #based on the assumption that Labor.re.N+Labor.ce.N=L.N
        Labor_re_N(t)
        #based on the assumption that  Price.re.N^(1-ε)+Price.ce.N^(1-ε)=1
        Price_re_N(t)
        # technology demand
        Agg_demand_re_tech_N(t)
        # Expected profits see annex IV. Equilibrium research profits
        Profits_re_N(t)
        # Equilibrium levels of production
        Yre_N(t)

        # dirty sector
        Labor_ce_N(t)
        Price_ce_N(t)
        Agg_demand_ce_tech_N(t)
        Profits_ce_N(t)
        Yce_N(t)

        # Producción total
        Y_N(t)

        sre_N(t)
        sce_N(t)

        #Auxiliaries in South
        #Labour on the South
        L_S(t)
        γ_re_t_S(t)
        γ_ce_t_S(t)

        ### Carbon tax in emergent region
        ### Technology subsidy in emergent region
        #Tec_subsidy_S(t)

        ### Subsidies for research and development
        #RD_subsidy_S(t)

        #First we determine the equilibrium levels of relative input prices and relative labour
        RelPrice_S(t)
        RelLabor_S(t)

        #Second we determine the equilibrium conditions for each sector
        #clean sector
        #based on the assumption that Labor_re_S+Labor_ce_S=L_S
        Labor_re_S(t)
        #based on the assumption that  Price_re_S^(1-ε)+(Price_ce_S)^(1-ε)=1
        Price_re_S(t)
        Agg_demand_re_tech_S(t)
        Profits_re_S(t)
        Yre_S(t)

        #dirty sector
        Labor_ce_S(t)
        Price_ce_S(t)
        Agg_demand_ce_tech_S(t)
        Profits_ce_S(t)
        Yce_S(t)

        #Total Production
        Y_S(t)

        #Allocation of Scientists
        sre_S(t)
        sce_S(t)

        ##### Changes in Temperature
        #increase in temperature at which there is environmental disaster
        Delta_Temp_Disaster(t)
        CO2_Concentration(t)
        Delta_Temp(t)

        #Welfare Calculations
        Consumption_N(t)
        Consumption_S(t)
        Cost_S_Damage(t)

        #Budget restrictions
        Budget_function_N(t)
        Budget_function_S(t)

        # Variables de flujo
        #Evolution of Productivity North Region
        dAre_N(t)
        dAce_N(t)
        #Evolution of Productivity South Region
        dAre_S(t)
        dAce_S(t)
        #Environmental Quality
        dS(t)
        
    end
    @equations begin
        ### Ecuaciones de las Variables intermedias
        φ ~ (1-α)*(1-ε)
        #this is the cost of production of clean technologies
        epsi_re ~ α^2
        #this is the cost of production of dirty technologies
        epsi_ce ~ α^2
        
        ### North Region
        #Auxiliaries in North
        L_N ~ Float64(ℯ)^(labor_growth_N*t)
        #gamma displays decreasing returns as in Stiligtz
        γ_re_t_N ~ γ_re*Float64(ℯ)^(-k_re*(Are_N/Are_N_0-1))
        #gamma displays decreasing returns as in Stiligtz
        γ_ce_t_N ~ γ_ce*Float64(ℯ)^(-k_ce*(Ace_N/Ace_N_0-1))
        
        ### Subsidies for research and development
        RelPrice_N ~ ((Ace_N/Are_N)^(1-α))*(((epsi_re*(1-Tec_subsidy_N))/epsi_ce)^α)
        RelLabor_N ~((1+ce_tax_N)^ε)*((((1-Tec_subsidy_N)*epsi_re)/epsi_ce)^(α*(1-ε)))*((Are_N/Ace_N)^(-1*φ))
        
        # Clean sector
        #based on the assumption that Labor.re.N+Labor.ce.N=L.N
        Labor_re_N ~ (RelLabor_N*L_N)/(1+RelLabor_N)
        #based on the assumption that  Price.re.N^(1-ε)+Price.ce.N^(1-ε)=1
        Price_re_N ~ RelPrice_N/(RelPrice_N^(1-ε)+(1)^(1-ε))^(1/(1-ε))
        
        # technology demand
        Agg_demand_re_tech_N ~ ((((α^2)*Price_re_N)/((1-Tec_subsidy_N)*epsi_re))^(1/(1-α)))*Labor_re_N*Are_N
        
        # Expected profits see annex IV. Equilibrium research profits
        Profits_re_N ~(1+RD_subsidy_N)*η_re*epsi_re*((1-α)/α)*Agg_demand_re_tech_N
        
        # Equilibrium levels of production
        Yre_N ~ ((((α^2)*Price_re_N)/((1-Tec_subsidy_N)*epsi_re))^(α/(1-α)))*Labor_re_N*Are_N
        
        # dirty sector
        Labor_ce_N ~ L_N/(RelLabor_N+1)
        Price_ce_N ~ Price_re_N/RelPrice_N
        Agg_demand_ce_tech_N ~ ((((α^2)*Price_ce_N)/(epsi_ce))^(1/(1-α)))*Labor_ce_N*Ace_N
        Profits_ce_N ~ η_ce*epsi_ce*((1-α)/α)*Agg_demand_ce_tech_N
        Yce_N ~ ((((α^2)*Price_ce_N)/(epsi_ce))^(α/(1-α)))*Labor_ce_N*Ace_N
        
        # Producción total
        Y_N ~ ((Yre_N)^((ε-1)/ε)+(Yce_N)^((ε-1)/ε))^(ε/(ε-1))
        sre_N ~ Float64(ℯ)^(Profits_re_N)/(Float64(ℯ)^(Profits_ce_N)+Float64(ℯ)^(Profits_re_N))
        sce_N ~ 1-sre_N
        
        #Auxiliaries in South
        #the population of the South is 4.6 that of the North,
        L_S ~ (Float64(ℯ)^(labor_growth_S*t))*size_factor
        γ_re_t_S ~ γ_re
        γ_ce_t_S ~ γ_ce
        
        ### Technology subsidy in emergent region
        #Tec_subsidy_S~0
        
        ### Subsidies for research and development
        #RD_subsidy_S ~ 0
        #First we determine the equilibrium levels of relative input prices and relative labour
        RelPrice_S ~ ((Ace_S/Are_S)^(1-α))*(((epsi_re*(1-Tec_subsidy_S))/epsi_ce)^α)
        RelLabor_S ~ ((1+ce_tax_S)^ε)*((((1-Tec_subsidy_S)*epsi_re)/epsi_ce)^(α*(1-ε)))*((Are_S/Ace_S)^(-1*φ))
        
        #Second we determine the equilibrium conditions for each sector
        #clean sector
        #based on the assumption that Labor_re_S+Labor_ce_S=L_S
        Labor_re_S ~ (L_S*RelLabor_S)/(RelLabor_S+1)
        
        #based on the assumption that  Price_re_S^(1-ε)+(Price_ce_S)^(1-ε)=1
        Price_re_S ~ RelPrice_S/(RelPrice_S^(1-ε)+(1)^(1-ε))^(1/(1-ε))
        Agg_demand_re_tech_S ~ ((((α^2)*Price_re_S)/((1-Tec_subsidy_S)*epsi_re))^(1/(1-α)))*Labor_re_S*Are_S
        Profits_re_S ~ (1+RD_subsidy_S)*η_re*epsi_re*((1-α)/α)*Agg_demand_re_tech_S
        Yre_S ~ ((((α^2)*Price_re_S)/((1-Tec_subsidy_S)*epsi_re))^(α/(1-α)))*Labor_re_S*Are_S
        
        #dirty sector
        Labor_ce_S ~ L_S/(RelLabor_S+1)
        Price_ce_S ~ Price_re_S/RelPrice_S
        Agg_demand_ce_tech_S ~ ((((α^2)*Price_ce_S)/(epsi_ce))^(1/(1-α)))*Labor_ce_S*Ace_S
        Profits_ce_S ~ η_ce*epsi_ce*((1-α)/α)*Agg_demand_ce_tech_S
        Yce_S ~ ((((α^2)*Price_ce_S)/(epsi_ce))^(α/(1-α)))*Labor_ce_S*Ace_S
        
        #Total Production
        Y_S ~ ((Yre_S)^((ε-1)/ε)+(Yce_S)^((ε-1)/ε))^(ε/(ε-1))
        
        #Allocation of Scientists
        sre_S ~ Float64(ℯ)^(Profits_re_S)/(Float64(ℯ)^(Profits_ce_S)+Float64(ℯ)^(Profits_re_S))
        sce_S ~ 1-sre_S
        
        ##### Changes in Temperature
        #increase in temperature at which there is environmental disaster
        Delta_Temp_Disaster ~ Δ_T_Disaster
        CO2_Concentration ~ max(CO2_Disaster-S,CO2_base)
        Delta_Temp ~ min(β_T*log(CO2_Concentration/CO2_base),Delta_Temp_Disaster)
        
        #Welfare Calculations
        Consumption_N ~ Y_N-epsi_re*Agg_demand_re_tech_N-epsi_ce*Agg_demand_ce_tech_N
        Consumption_S ~ (Y_S-epsi_re*Agg_demand_re_tech_S-epsi_ce*Agg_demand_ce_tech_S)*(1/size_factor)
        Cost_S_Damage ~ ((Delta_Temp_Disaster-Delta_Temp)^λ-λ*Delta_Temp_Disaster^(λ-1)*(Delta_Temp_Disaster-Delta_Temp))/((1-λ)*Delta_Temp_Disaster^λ)
        
        #### Ecuaciones de las Variables de Flujo
        #Evolution of Productivity North Region
        dAre_N ~ γ_re_t_N*η_re*sre_N*Are_N
        dAce_N ~ γ_ce_t_N*η_ce*sce_N*Ace_N

        #Evolution of Productivity South Region
        dAre_S ~ γ_re_t_S*ν_re*sre_S*(Are_N-Are_S)
        dAce_S ~ γ_ce_t_S*ν_ce*sce_S*(Ace_N-Ace_S)

        #Environmental Quality
        dS ~ min(1.0,(δ_S*S)-qsi*(Yce_N+Yce_S))

        # Ecuaciones de las tasas de cambio de los stocks
        D(Are_N) ~ dAre_N
        D(Ace_N) ~ dAce_N
        D(Are_S) ~ dAre_S
        D(Ace_S) ~ dAce_S
        D(S) ~ dS

    end
end

