include("data.jl")

using JuMP, Gurobi

function solve_FL(data :: Data; relaxed :: Bool, verbose = false, env = Gurobi.Env())
    N = data.N
    M = data.M

    model = Model(() -> Gurobi.Optimizer(env))
    if !verbose
        set_silent(model)
    end

    # Disable presolve to illustrate the relaxation gap 
    set_optimizer_attribute(model, "Presolve", 0)
    @variable(model, y[1:M] >= 0)
    @variable(model, x[1:N, 1:M] >= 0)

    @constraint(model, assignment[i=1:N], sum(x[i, j] for j in 1:M) == 1)
    @constraint(model, validity[i=1:N, j=1:M], x[i, j] <= y[j])

    @objective(model, Min,
        sum(data.assignment_costs[i, j] * x[i, j] for i in 1:N, j in 1:M) +
        sum(data.facility_costs[j] * y[j] for j in 1:M)
    )

    if !relaxed
        set_binary.(y)
    end

    optimize!(model)
    @assert is_solved_and_feasible(model)

    objective = objective_value(model)
    assignment_cost = sum(data.assignment_costs[i, j] * value(x[i, j]) for i in 1:N, j in 1:M)
    assignment_share = assignment_cost / objective

    if verbose
        println("Mode = ", relaxed ? "Relaxed" : "Integer")
        println("Optimal objective value: ", objective)
        println("Assignment share of total cost: ", round(assignment_share * 100, digits=2), "%")
    end

    if relaxed
        return objective, value.(y), value.(x), dual.(assignment), dual.(validity)
    else
        return objective, value.(y), value.(x)
    end
end