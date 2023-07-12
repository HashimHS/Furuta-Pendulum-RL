"""
Wrapping code for the ODE integrator interface + plotting
"""

# include("motion.jl")
# using Plots, DifferentialEquations

# function ODEf(du,u,p,t)
#     """wrapper for the equations of motion"""
#     du[:] = furuta_sim_clone(u, p[end], p[1:end-1])
# end

# function init_sim(
#     x0 = [0, 0, π, 0],
#     u0 = 0;
#     tmax = 10.,
#     dt = 0.01
#     )
#     """
#     Returns an integrator for the differential equations with:
#         x0, u0 the initial conditions
#         tmax the duration of the simulation
#         dt the timestep
#     """
#     tspan = (0., tmax)
#     t1 = Ku*u0
#     p = [α, β, γ, δ, t1]
#     prob = ODEProblem(ODEf, x0, tspan, p) #define ODE problem
#     integrator = init(prob,alg=Tsit5(),tstops=0:dt:tmax) #init integrator using the Tsitouras solver
# end

# function sim!(integrator, u::Number)
#     """
#     Takes a time step using control action u
#     Also returns the next state x₊
#     """
#     integrator.p[end] = Ku*u
#     step!(integrator)
#     x₊ = integrator.u
#     return x₊
# end


function plotPendulum(ϕ,θ)
    R = 1
    r = 2
    x1 = R*cos(ϕ)
    y1 = R*sin(ϕ)
    z1 = 0
    x2 = x1 - r*sin(ϕ)*sin(θ)
    y2 = y1 + r*cos(ϕ)*sin(θ)
    z2 = r*cos(θ)
    plot([0,x1],[0,y1],[0,z1],
        linewidth=4,
        linecolor=:red,
        ylimits=(-r,r),
        xlimits=(-r,r),
        zlimits=(-r,r))
    plot!([x1,x2],[y1,y2],[z1,z2],linewidth=4,linecolor=:blue)
end

# function animate(integrator, fps=30)
#     tmax = maximum(integrator.sol.t)
#     ϕs = [u[1] for u in integrator.sol.u]
#     θs = [u[3] for u in integrator.sol.u]
#     n = length(ϕs)
#     di = trunc(Int,n/tmax/fps)
#     anim = @animate for i=1:di:n
#         plotPendulum(ϕs[i],θs[i])
#     end
#     gif(anim, "anim_pendulum.gif", fps=fps)
# end

function animate_pendulum(ϕs,θs,tmax,fps=30)
    n = length(ϕs)
    di = trunc(Int,n/tmax/fps)
    anim = @animate for i=1:di:n
        plotPendulum(ϕs[i],θs[i])
        title!("$(i*tmax/n) s")
    end
    gif(anim, "anim_pendulum.gif", fps=fps)
end