using Plots

### Definimos función de la derivada de la función
function dydt(y)
    return -2*y
end

### Definimos función que ejecuta la actualización de Euler
function Euler(y,h)
    return y + h*dydt(y) 
end

h = 0.1
y = [3.0]
t = [0.0]

while (t[end] < 4.0)
    append!(t, t[end] + h)
    append!(y, Euler(y[end],h))
end


et = [t[end]*(i/500) for i in 1:500]
ex = [3.0 * exp(-2.0 * i) for i in et]

### Graficamos las salidas para comparar la solución cerrada vs la solución numérica
plot(et, ex, label = "Exacta", title = "Comparativo solución exacta vs método de Euler")
plot!(t, y, label = "Euler", seriestype=:scatter )
