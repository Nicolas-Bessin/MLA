include("data.jl")

using Plots


function draw_solution(
    data :: Data, 
    opened_facilities :: Vector{Int}, 
    client_assignments :: Vector{Int};
    figname :: String = "facility_location_solution",
    cost :: Real = 0.0
    )
    scatter(data.client_points[:, 1], data.client_points[:, 2], label="Clients", color=:blue)
    scatter!(data.facility_points[:, 1], data.facility_points[:, 2], label="Facilities", color=:red)
    # Add specific markers for opened facilities
    scatter!(data.facility_points[opened_facilities, 1], data.facility_points[opened_facilities, 2], 
                label="Opened Facilities", color=:green, markershape=:star5, markersize=10)
    
    for client in 1:data.N
        assigned_facility = client_assignments[client]
        plot!([data.client_points[client, 1], data.facility_points[assigned_facility, 1]], 
              [data.client_points[client, 2], data.facility_points[assigned_facility, 2]], 
              color=:gray, linestyle=:dash, label="")
    end
    title!("Facility Location Solution : $(figname), Cost = $(trunc(cost, digits=1))")
    xlabel!("X")
    ylabel!("Y")

    plot!(size=(800, 600), legend=:topright)

    savefig("plots/$(figname).png")

    return
end