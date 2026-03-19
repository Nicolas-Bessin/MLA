include("data.jl")
include("exact.jl")


function rounding_heuristic(data :: Data; verbose = false, eps = 1e-6, env = Gurobi.Env())
    N = data.N
    M = data.M
    # Begin by solving the relaxation
    obj, y, x, v, w = solve_FL(data, relaxed = true, env = env)

    unassigned_clients = Set(1:N)
    cluster_affectations = ones(Int, N)
    cluster_centers = []

    k = 1
    while length(unassigned_clients) > 0

        ik = argmin(client -> v[client], unassigned_clients)
        if verbose
            println("k = $k, Current min of dual is $(minimum(v[collect(unassigned_clients)]))")
            println("Best client to start a cluster is $ik with dual value $(v[ik])")
        end
        cluster_affectations[ik] = k
        push!(cluster_centers, ik)
        delete!(unassigned_clients, ik)
        for j in 1:M
            if x[ik, j] < eps
                continue
            end
            # Assign all not already assigned neighbor of M_j to cluster k
            for i in unassigned_clients
                if x[i, j] > eps
                    cluster_affectations[i] = k
                    delete!(unassigned_clients, i)
                end
            end
        end

        if length(unassigned_clients) > 0
            k += 1
        end
    end

    # Finally, choose the sites
    sites :: Vector{Int} = []
    for cluster in 1:k
        min_site = argmin(
            site -> data.facility_costs[site], [site for site in 1:M if x[cluster_centers[cluster], site] > eps]
            )
        if verbose
            println("Best site for cluster $cluster is $min_site with cost $(data.facility_costs[min_site])")
        end
        push!(sites, min_site)
    end

    # Site affectations
    site_affectations = [sites[cluster_affectations[i]] for i in 1:N]

    # Compute the cost
    cost = 0
    cost += sum(data.assignment_costs[i, site_affectations[i]] for i in 1:N)
    cost += sum(data.facility_costs[j] for j in sites)

    if verbose
        println("Rounding found a solution with objective $cost")
    end
    return cost, sites, site_affectations

end

# data = random_data(50, 25, seed = 143);

# cost_heur, sites, cluster_affectations = rounding_heuristic(data, verbose = false)

# cost_exact, y, x = solve_FL(data, relaxed = false)