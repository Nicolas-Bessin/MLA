include("data.jl")


function primal_dual_heuristic(data :: Data; verbose :: Bool = false)
    N = data.N
    M = data.M

    # Assignment data
    unassigned_clients = Set(1:N)
    client_affectations = zeros(Int, N)
    open_sites = falses(M)

    # Dual values
    v = zeros(Int, N)
    w = zeros(Int, N, M)

    # PHASE 1

    iter = 1
    while length(unassigned_clients) > 0
        if verbose
            println("Iteration $iter, unassigned clients: $(length(unassigned_clients))")
        end
        # Event 1 
        for i in unassigned_clients
            candidates_sites = findall(j -> (v[i] >= data.assignment_costs[i, j] && open_sites[j]), 1:M)
            if length(candidates_sites) > 0
                client_affectations[i] = candidates_sites[1]
                delete!(unassigned_clients, i)
            end
        end

        # Event 3
        for j in 1:M
            if sum(w[i, j] for i in 1:N) >= data.facility_costs[j]
                open_sites[j] = true
                for i in unassigned_clients
                    if v[i] >= data.assignment_costs[i, j]
                        client_affectations[i] = j
                        delete!(unassigned_clients, i)
                    end
                end
            end
        end

        # Augment the dual values
        for i in unassigned_clients
            v[i] += 1
            for j in 1:M
                w[i, j] = max(0, v[i] - data.assignment_costs[i, j])
            end
        end

        iter += 1

        # Verify the complementary slackness conditions
        for i in 1:N
            for j in 1:M
                @assert w[i, j] == max(0, v[i] - data.assignment_costs[i, j])
            end
        end
    end

    # PHASE 2 - Remove some of the opened sites by finding a maximal independent set
    function are_neighbors(site1, site2)
        for i in 1:N
            if w[i, site1] > 0 && w[i, site2] > 0
                return true
            end
        end
        return false
    end

    independent_set = Set{Int}()
    for j in 1:M
        if open_sites[j]
            if all(neighbor -> !are_neighbors(j, neighbor), independent_set)
                push!(independent_set, j)
            end
        end
    end

    removed_sites = [j for j in 1:M if open_sites[j] && !(j in independent_set)]
    for j in removed_sites
        open_sites[j] = false
    end

    # Redo the affectations
    for i in 1:N
        if client_affectations[i] in removed_sites
            new_sites_candidates = findall(j -> open_sites[j] && are_neighbors(client_affectations[i], j), 1:M)
            if length(new_sites_candidates) > 0
                client_affectations[i] = new_sites_candidates[1]
            else
                error("No site to affect client $i after removing sites
                    $(client_affectations[i]) was removed and has no neighbor in the independent set")
            end
        end
    end

    # Finally, compute the cost
    cost = 0
    cost += sum(data.assignment_costs[i, client_affectations[i]] for i in 1:N)
    cost += sum(data.facility_costs[j] for j in 1:M if open_sites[j])

    if verbose
        println("--------------------------------")
        println("Primal-dual heuristic found a solution with objective $cost in $iter iterations")
    end

    return cost, [j for j in 1:M if open_sites[j]], client_affectations
end

# data = random_data(50, 25, seed = 143);
# cost_heur, sites, client_affectations = primal_dual_heuristic(data, verbose = true)
# include("exact.jl")
# cost_exact, y, x = solve_FL(data, relaxed = false)