struct Data
    N :: Int
    M :: Int
    assignment_costs :: Matrix{Int}
    facility_costs :: Vector{Int}
    client_points :: Matrix{Int}
    facility_points :: Matrix{Int}
end

# Define a constructor where the points are unknown
function Data(N::Int, M::Int, assignment_costs::Matrix{Int}, facility_costs::Vector{Int})
    client_points = zeros(Int, N, 2)
    facility_points = zeros(Int, M, 2)
    return Data(N, M, assignment_costs, facility_costs, client_points, facility_points)
end

using Random

l1_norm(p1 :: Vector{Int}, p2 :: Vector{Int}) :: Int = sum(abs.(p1 .- p2))
l2_norm(p1 :: Vector{Int}, p2 :: Vector{Int}) :: Float64 = sqrt(sum((p1 .- p2) .^ 2))

function random_data(N::Int, M::Int; seed :: Int = 42) :: Data
    Random.seed!(seed)
    # Generate N random points in 2D space with int coordinates
    client_point = rand(0:250, N, 2)
    facility_points = rand(0:250, M, 2)
    assignment_costs = [l1_norm(client_point[i, :], facility_points[j, :]) for i in 1:N, j in 1:M]
    facility_costs = rand(25:50, M)
    return Data(N, M, assignment_costs, facility_costs, client_point, facility_points)
end