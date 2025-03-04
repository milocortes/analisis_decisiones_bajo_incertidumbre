using Plots

### Definimos función de la derivada de la función
function dydt(y)
    return -2*y
end

### Definimos función que ejecuta la actualización de Runge-Kutta 4
function RK4(y,h)
    k1 = dydt(y)
    k2 = dydt(y + 0.5 * k1 * h)
    k3 = dydt(y + 0.5 * k2 * h)
    k4 = dydt(y + k3 * h)

    return y + (h / 6) * (k1 + 2 * k2 + 2 * k3 + k4)

end


h = 0.1
y = [3.0]
t = [0.0]

while (t[end] < 4.0)
    append!(t, t[end] + h)
    append!(y, RK4(y[end],h))
end


et = [t[end]*(i/500) for i in 1:500]
ex = [3.0 * exp(-2.0 * i) for i in et]

### Graficamos las salidas para comparar la solución cerrada vs la solución numérica
plot(et, ex, label = "Exacta", title = "Comparativo solución exacta vs método Runge-Kutta 4")
plot!(t, y, label = "Runge-Kutta 4", seriestype=:scatter )
