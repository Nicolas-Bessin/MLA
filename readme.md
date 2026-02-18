# Facility Location Problem

This repo implements two heuristics and an exact method to solve the facility location problem.  
- `src/data.jl`: Definition of the `Data` struct, and generation of random instances.
- `src/exact.jl`: Exact method to solve the problem using Gurobi.
- `src/rounding.jl`: Rounding heuristic
- `src/primal-dual.jl`: Primal-dual heuristic

# Results

The following table give the results obtained on a few instances. Note that all of the instances where the relaxed value is strictly less than the integer value were specifically selected to show the difference between the two heuristics (Generating random instances, the vast majority of them have the same relaxed and integer value, which makes it hard to compare the two heuristics).

| Instance | N | M | Relaxed obj | Integer obj | Rounding heuristic | Primal-Dual Heuristic |
|------|---|---|-------------|-------------|----------------|-------------------|
| 1 | 25 | 10 | 1498.5 | 1500.0 | 1515.0 | 1510.0 |
| 2 | 25 | 10 | 2191.5 | 2194.0 | 2201.0 | 2287.0 |
| 3 | 25 | 10 | 1595.0 | 1604.0 | 1631.0 | 1865.0 |
| 4 | 25 | 10 | 1529.0 | 1532.0 | 1551.0 | 1818.0 |
| 5 | 50 | 25 | 2210.0 | 2212.0 | 2221.0 | 2339.0 |
| 6 | 50 | 25 | 2423.5 | 2424.0 | 2457.0 | 2766.0 |
| 7 | 50 | 25 | 2189.5 | 2197.0 | 2207.0 | 2317.0 |
| 8 | 50 | 25 | 2186.5 | 2187.0 | 2232.0 | 2398.0 |
| 9 | 50 | 25 | 2226.0 | 2228.0 | 2232.0 | 2325.0 |
| 10 | 50 | 25 | 2177.0 | 2178.0 | 2198.0 | 2457.0 |
| 11 | 50 | 25 | 2558.5 | 2559.0 | 2569.0 | 2603.0 |
| 12 | 50 | 25 | 2612.0 | 2613.0 | 2646.0 | 2699.0 |
| 13 | 50 | 25 | 2279.0 | 2280.0 | 2306.0 | 2430.0 |
| 14 | 50 | 25 | 2327.5 | 2328.0 | 2365.0 | 2559.0 |
| 15 | 50 | 25 | 2415.0 | 2418.0 | 2471.0 | 2539.0 |
| 16 | 50 | 25 | 2515.5 | 2516.0 | 2536.0 | 2661.0 |
| 17 | 50 | 25 | 2442.5 | 2444.0 | 2461.0 | 2547.0 |
| 18 | 50 | 25 | 2310.5 | 2312.0 | 2346.0 | 2390.0 |
| 19 | 50 | 25 | 2359.5 | 2362.0 | 2387.0 | 2704.0 |
| 20 | 50 | 25 | 2338.5 | 2339.0 | 2395.0 | 2592.0 |
| 21 | 50 | 25 | 2260.0 | 2261.0 | 2272.0 | 2282.0 |
| 22 | 50 | 25 | 2103.5 | 2108.0 | 2141.0 | 2178.0 |
| 23 | 50 | 25 | 2302.0 | 2303.0 | 2321.0 | 2439.0 |
| 24 | 50 | 25 | 2743.5 | 2745.0 | 2847.0 | 3191.0 |
| 25 | 50 | 25 | 2356.0 | 2357.0 | 2373.0 | 2554.0 |
| 26 | 50 | 25 | 2253.0 | 2254.0 | 2277.0 | 2532.0 |
| 27 | 50 | 25 | 2265.5 | 2266.0 | 2267.0 | 2267.0 |
| 28 | 50 | 25 | 2475.0 | 2481.0 | 2489.0 | 2758.0 |
