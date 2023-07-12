# A: Furuta dynamics with simple motor model
J = 1.54e-4 # Combined moment of inertia [kg*m^2]
M = 0 # Mass of ball at the end of the pendulum (that we don't have) [kg]
ma = 0 # Mass of the base arm (zero since we have a circular symmetrical base, not an arm) [kg]
mp = 5.44e-3 # Mass of the pendulum arm [kg]
la = 4.3e-2 # Base radius [m]
lp = 6.46e-2 # Arm length [m]
R = 0.13 # [Ohm]
Ka = 0.03 # [N*m*Ohm/V]
Ku=Ka/R # Input gain [N*m/V]
g = 9.81 # [m/s^2]

# 
α = J+(M+ma/3+mp)*la^2 # [kg*m^2]
β = (M+mp/3)*lp^2 # [kg*m^2]
γ = (M+mp/2)*la*lp # [kg*m^2]
δ = (M+mp/2)*g*lp # [kg*m^2/s^2]

# Friction model
fφ = 0.3
fθ = 0.3
fv = 0.01

# A = [0 1 0 0; 0 0 -δ*γ/(α*β-γ^2) 0; 0 0 0 1; 0 0 -α*δ/(α*β-γ^2) 0]
# B = [0; β/(α*β-γ^2); 0; γ/(α*β-γ^2)]

function nonlinear_frictionfree(x, u, p=[α, β, γ, δ])
    α, β, γ, δ = p
    φ, dφ, θ, dθ = x
    t1 = u
    t2 = 0
    dx = zeros(4,1)
    dx[1] = dφ
    dx[2] = (β*γ*(((sin(θ))^2)-1)*sin(θ)*(dφ^2)-2*(β^2)*cos(θ)*sin(θ)*dφ*dθ+β*γ*sin(θ)*(dθ^2)-γ*δ*cos(θ)*sin(θ)+β*t1-γ*cos(θ)*t2)/(α*β-(γ^2)+(β^2+(γ^2))*(sin(θ))^2)
    dx[3] = dθ
    dx[4] = (β*(α+β*sin(θ)^2)*cos(θ)*sin(θ)*(dφ^2)+2*β*γ*(1-sin(θ)^2)*sin(θ)*dφ*dθ-(γ^2)*cos(θ)*sin(θ)*(dθ^2)+δ*(α+β*(sin(θ)^2))*sin(θ)-γ*cos(θ)*t1+(α+β*((sin(θ))^2))*t2)/(α*β-(γ^2)+((β^2)+(γ^2))*(sin(θ))^2)
    return dx
end

function nonlinear_friction(x, u, p=[α, β, γ, δ])
    α, β, γ, δ = p
    φ, dφ, θ, dθ = x
    t1 = u
    t2 = 0
    bef = t1*(1-fv)
    dx = zeros(4,1)
    dx[1] = dφ
    dx[2] = (β*γ*(((sin(θ))^2)-1)*sin(θ)*(dφ^2)-2*(β^2)*cos(θ)*sin(θ)*dφ*dθ+β*γ*sin(θ)*(dθ^2)-γ*δ*cos(θ)*sin(θ)+β*t1-γ*cos(θ)*t2)/(α*β-(γ^2)+(β^2+(γ^2))*(sin(θ))^2) - fφ*dφ
    dx[3] = dθ
    dx[4] = (β*(α+β*sin(θ)^2)*cos(θ)*sin(θ)*(dφ^2)+2*β*γ*(1-sin(θ)^2)*sin(θ)*dφ*dθ-(γ^2)*cos(θ)*sin(θ)*(dθ^2)+δ*(α+β*(sin(θ)^2))*sin(θ)-γ*cos(θ)*t1+(α+β*((sin(θ))^2))*t2)/(α*β-(γ^2)+((β^2)+(γ^2))*(sin(θ))^2) - fθ*dθ -bef
    return dx
end

function linear_friction(x, u, p=[α, β, γ, δ, fφ, fθ, fv])
    α, β, γ, δ, fφ, fθ, fv = p
    φ, dφ, θ, dθ = x
    t1 = u
    bef = t1*(1-fv)
    du[1] = dφ
    du[2] = -θ*δ*γ/(α*β-γ^2) + β*t1/(α*β-γ^2) - fφ*dφ
    du[3] = dθ
    du[4] = -θ*α*δ/(α*β-γ^2) + γ*t1/(α*β-γ^2) - fθ*dθ -bef
    return du
end