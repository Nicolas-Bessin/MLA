# Facility Location Problem

This repo implements two heuristics and an exact method to solve the facility location problem.  
- `src/data.jl`: Definition of the `Data` struct, and generation of random instances.
- `src/exact.jl`: Exact method to solve the problem using Gurobi.
- `src/rounding.jl`: Rounding heuristic
- `src/primal-dual.jl`: Primal-dual heuristic
- `main.ipynb`: Some other bits of code to find intresting seeds for the random instance generator, and to compare the two heuristics on a few instances.

# Results

The following table give the results obtained on a few instances. We selected instances that specifically have a non-zero integrality gap, to show the difference between the two heuristics, and then added some other randomly generated instances (with zero integrality gap, like the vast majority of randomly generated instances).

- On the instances where the integrality gap is zero, the rounding heuristic is optimal as expected.
- However, despite the fact that the primal-dual heuristic is a 3-approximation, in reality it performs much worse than the rounding heuristic (which is a 4-approximation).

| Instance | N | M | Relaxed obj | Time | Integer Obj | Time | Integrality Gap | Rounding heuristic | Time | Primal-Dual Heuristic | Time |
| :----: | -: | -: | -: | -: | -: | -: | -: | -: | -: | -: | -: |
| 1 | 25 | 10 | 1498.5 | 2.9e-03 | 1500 | 6.5e-02 | 1.5 | 1515 | 2.8e-03 | 1516 | 7.1e-04 |
| 2 | 25 | 10 | 2191.5 | 2.6e-03 | 2194 | 5.4e-03 | 2.5 | 2201 | 2.9e-03 | 2287 | 1.9e-03 |
| 3 | 25 | 10 | 1595.0 | 2.9e-03 | 1604 | 6.0e-03 | 9.0 | 1631 | 3.2e-03 | 1865 | 8.4e-04 |
| 4 | 25 | 10 | 1529.0 | 2.8e-03 | 1532 | 4.8e-03 | 3.0 | 1551 | 2.8e-03 | 1608 | 7.2e-04 |
| 5 | 25 | 10 | 1399.0 | 2.7e-03 | 1399 | 4.1e-03 | 0.0 | 1399 | 2.7e-03 | 1399 | 7.0e-04 |
| 6 | 25 | 10 | 1577.0 | 2.5e-03 | 1577 | 1.3e-02 | 0.0 | 1577 | 2.7e-03 | 1687 | 6.9e-04 |
| 7 | 25 | 10 | 1588.0 | 2.6e-03 | 1588 | 3.7e-03 | 0.0 | 1588 | 3.2e-03 | 1808 | 8.0e-04 |
| 8 | 25 | 10 | 1752.0 | 2.7e-03 | 1752 | 3.6e-03 | 0.0 | 1752 | 2.8e-03 | 1797 | 8.4e-04 |
| 9 | 25 | 10 | 1620.0 | 2.7e-03 | 1620 | 4.2e-03 | 0.0 | 1620 | 2.7e-03 | 1648 | 7.4e-04 |
| 10 | 25 | 10 | 1557.0 | 2.5e-03 | 1557 | 3.5e-03 | 0.0 | 1557 | 2.7e-03 | 1592 | 7.4e-04 |
| 11 | 50 | 25 | 2210.0 | 1.0e-02 | 2212 | 2.4e-02 | 2.0 | 2221 | 1.2e-02 | 2339 | 2.0e-03 |
| 12 | 50 | 25 | 2423.5 | 1.1e-02 | 2424 | 3.1e-02 | 0.5 | 2457 | 1.0e-02 | 2639 | 2.5e-03 |
| 13 | 50 | 25 | 2189.5 | 9.8e-03 | 2197 | 2.1e-02 | 7.5 | 2207 | 9.7e-03 | 2317 | 2.4e-03 |
| 14 | 50 | 25 | 2186.5 | 1.0e-02 | 2187 | 1.7e-02 | 0.5 | 2232 | 1.7e-02 | 2336 | 2.2e-03 |
| 15 | 50 | 25 | 2226.0 | 9.6e-03 | 2228 | 1.6e-02 | 2.0 | 2232 | 1.0e-02 | 2298 | 2.4e-03 |
| 16 | 50 | 25 | 2177.0 | 1.1e-02 | 2178 | 1.6e-02 | 1.0 | 2198 | 9.6e-03 | 2279 | 2.3e-03 |
| 17 | 50 | 25 | 2558.5 | 3.8e-02 | 2559 | 2.0e-02 | 0.5 | 2569 | 1.0e-02 | 2603 | 2.7e-03 |
| 18 | 50 | 25 | 2612.0 | 1.1e-02 | 2613 | 1.6e-02 | 1.0 | 2646 | 9.8e-03 | 2699 | 2.7e-03 |
| 19 | 50 | 25 | 2279.0 | 9.7e-03 | 2280 | 7.6e-02 | 1.0 | 2306 | 9.8e-03 | 2430 | 2.3e-03 |
| 20 | 50 | 25 | 2327.5 | 1.0e-02 | 2328 | 1.6e-02 | 0.5 | 2365 | 9.8e-03 | 2534 | 2.2e-03 |
| 21 | 50 | 25 | 2415.0 | 1.0e-02 | 2418 | 2.2e-02 | 3.0 | 2471 | 1.3e-02 | 2539 | 3.4e-03 |
| 22 | 50 | 25 | 2515.5 | 1.1e-02 | 2516 | 1.8e-02 | 0.5 | 2536 | 1.0e-02 | 2624 | 2.3e-03 |
| 23 | 50 | 25 | 2442.5 | 1.0e-02 | 2444 | 1.8e-02 | 1.5 | 2461 | 2.1e-02 | 2547 | 2.3e-03 |
| 24 | 50 | 25 | 2310.5 | 9.5e-03 | 2312 | 1.7e-02 | 1.5 | 2346 | 1.0e-02 | 2390 | 2.6e-03 |
| 25 | 50 | 25 | 2359.5 | 1.0e-02 | 2362 | 1.7e-02 | 2.5 | 2387 | 9.8e-03 | 2704 | 2.4e-03 |
| 26 | 50 | 25 | 2338.5 | 9.9e-03 | 2339 | 1.7e-02 | 0.5 | 2395 | 9.8e-03 | 2592 | 2.7e-03 |
| 27 | 50 | 25 | 2260.0 | 1.8e-02 | 2261 | 2.5e-02 | 1.0 | 2272 | 9.7e-03 | 2270 | 2.3e-03 |
| 28 | 50 | 25 | 2147.0 | 9.4e-03 | 2147 | 1.2e-02 | 0.0 | 2147 | 9.7e-03 | 2175 | 2.3e-03 |
| 29 | 50 | 25 | 2471.0 | 9.5e-03 | 2471 | 1.7e-02 | 0.0 | 2471 | 9.6e-03 | 2535 | 2.8e-03 |
| 30 | 50 | 25 | 2289.0 | 1.0e-02 | 2289 | 1.1e-02 | 0.0 | 2289 | 9.6e-03 | 2386 | 2.1e-03 |
| 31 | 200 | 100 | 5248.0 | 2.1e-01 | 5251 | 3.2e-01 | 3.0 | 5283 | 2.2e-01 | 5779 | 4.1e-02 |
| 32 | 200 | 100 | 5006.5 | 2.8e-01 | 5009 | 3.6e-01 | 2.5 | 5075 | 2.2e-01 | 6007 | 4.0e-02 |
| 33 | 200 | 100 | 4920.0 | 1.8e-01 | 4922 | 3.6e-01 | 2.0 | 4997 | 1.7e-01 | 5803 | 3.5e-02 |
| 34 | 200 | 100 | 5099.0 | 2.6e-01 | 5099 | 1.9e-01 | 0.0 | 5099 | 1.9e-01 | 5741 | 4.1e-02 |
| 35 | 200 | 100 | 5175.0 | 2.2e-01 | 5175 | 2.2e-01 | 0.0 | 5175 | 2.2e-01 | 5483 | 4.2e-02 |
| 36 | 500 | 100 | 10691.0 | 6.4e-01 | 10691 | 6.9e-01 | 0.0 | 10691 | 6.2e-01 | 12336 | 2.5e-01 |
| 37 | 500 | 100 | 10943.5 | 5.6e-01 | 10945 | 6.2e-01 | 1.5 | 10950 | 5.8e-01 | 12053 | 2.6e-01 |
| 38 | 500 | 100 | 10862.0 | 5.9e-01 | 10864 | 8.1e-01 | 2.0 | 10903 | 5.5e-01 | 12205 | 2.7e-01 |
| 39 | 500 | 100 | 11181.0 | 5.4e-01 | 11181 | 5.6e-01 | 0.0 | 11181 | 5.7e-01 | 12613 | 2.6e-01 |
| 40 | 500 | 100 | 10715.0 | 5.7e-01 | 10715 | 6.6e-01 | 0.0 | 10715 | 5.3e-01 | 12264 | 2.7e-01 |
| 41 | 1000 | 200 | 16331.0 | 2.4e+00 | 16332 | 2.9e+00 | 1.0 | 16353 | 2.3e+00 | 18146 | 1.6e+00 |
| 42 | 1000 | 200 | 16325.5 | 2.4e+00 | 16327 | 2.7e+00 | 1.5 | 16341 | 2.2e+00 | 18382 | 1.5e+00 |
| 43 | 1000 | 200 | 16012.0 | 2.1e+00 | 16012 | 2.6e+00 | 0.0 | 16012 | 2.2e+00 | 18639 | 1.3e+00 |
| 44 | 1000 | 200 | 16976.0 | 2.2e+00 | 16976 | 2.5e+00 | 0.0 | 16976 | 2.5e+00 | 19868 | 1.8e+00 |
| 45 | 1000 | 200 | 16948.0 | 2.5e+00 | 16948 | 3.1e+00 | 0.0 | 16948 | 2.5e+00 | 18694 | 1.8e+00 |
| 46 | 2000 | 300 | 26302.0 | 7.3e+00 | 26303 | 1.1e+01 | 1.0 | 26334 | 7.5e+00 | 29521 | 1.1e+01 |
| 47 | 2000 | 300 | 25960.0 | 7.9e+00 | 25960 | 1.0e+01 | 0.0 | 25960 | 7.0e+00 | 29411 | 1.0e+01 |
| 48 | 2000 | 300 | 25919.0 | 6.9e+00 | 25919 | 9.0e+00 | 0.0 | 25919 | 7.9e+00 | 28823 | 1.2e+01 |
| 49 | 2000 | 300 | 26266.0 | 7.6e+00 | 26266 | 9.6e+00 | 0.0 | 26266 | 7.4e+00 | 29780 | 1.1e+01 |
| 50 | 2000 | 300 | 25709.0 | 7.7e+00 | 25709 | 9.1e+00 | 0.0 | 25709 | 7.5e+00 | 29798 | 1.1e+01 |



# Plots

The following two plots, generated from the data in the table above, show the average run time and average gap for each heuristic across all instances.

- We clearly see that while the primal-dual heuristic performs much worse in terms of solution quality, it is much faster, because it does not require a costly computation of the LP relaxation of the problem.
- In fact for the three methods that require computing the LP relaxation (relaxation itself, exact resolution and rounding heuristic),
their run time is almost the same, meaning that the time taken by the heuristics themselves (or the B&B) is negligible compared to the time taken by the LP relaxation, which is the same for all three methods.  

![Average run time](plots/average_run_time.png)
![Average gap](plots/average_gap.png)

## A specific instance

We focus on a specific instance (Instance 13 in the table above) to show the solutions obtained by the exact method, the rounding heuristic and the primal-dual heuristic.

![Exact solution](plots/Exact.png)
![Rounding solution](plots/Rounding.png)
![Primal-Dual solution](plots/Primal-Dual.png)
