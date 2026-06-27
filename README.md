# Hydrodynamic Journal Bearing Pressure Profile Solver (FDM)

This repository contains a **MATLAB implementation** of a Finite Difference Method (FDM) solver designed to map the 3D fluid pressure distribution inside a hydrodynamic journal bearing. By resolving the non-dimensional **Reynolds Equation** through an iterative Gauss-Seidel approach, the script accurately models the fluid film lubrication behavior under varying eccentricity levels.

---

## Technical Context & Governing Theory

In an oil-lubricated journal bearing, a rotating shaft (journal) lifts off the sleeve surface by dragging lubricating oil into a converging wedge shape, creating a high-pressure hydrodynamic fluid film that supports the radial load. 

The spatial distribution of this fluid film pressure is governed by the steady-state **Reynolds Equation** for thin-film lubrication. This script handles the discretized numerical solution for a finite-length journal bearing considering variable density ($\rho$) and viscosity ($\eta$):

$$\frac{\partial}{\partial \theta} \left( \frac{\bar{\rho} \bar{h}^3}{\bar{\eta}} \frac{\partial \bar{p}}{\partial \theta} \right) + \left(\frac{D}{L}\right)^2 \frac{\partial}{\partial \bar{z}} \left( \frac{\bar{\rho} \bar{h}^3}{\bar{\eta}} \frac{\partial \bar{p}}{\partial \bar{z}} \right) = 6 \frac{\partial (\bar{\rho}\bar{h})}{\partial \theta}$$

Where:
* $\theta, \bar{z}$ are the non-dimensional angular and axial coordinates.
* $\bar{h}$ is the non-dimensional film thickness, modeled as $\bar{h} = 1 + \varepsilon \cos(\theta)$, where $\varepsilon$ is the eccentricity ratio ($0.7$).
* $D/L$ is the Diameter-to-Length aspect ratio of the bearing geometry.
* $\bar{p}$ is the non-dimensional pressure tensor solved at each discrete mesh node.

---

## Simulation Setup & Parameters

The script initializes standard mechanical and physical boundaries for the lubrication zone:
* **Journal Diameter ($D$):** $0.10\text{ m}$
* **Journal Length ($L$):** $0.10\text{ m}$ (Aspect Ratio $D/L = 1.0$)
* **Sliding Velocity ($U$):** $1.0\text{ m/s}$
* **Lubricant Density ($\rho_0$):** $850\text{ kg/m}^3$
* **Base Viscosity ($\eta_0$):** $0.1\text{ Pa}\cdot\text{s}$
* **Eccentricity Ratio ($\varepsilon$):** $0.7$

### Numerical Architecture
* **Algorithm:** Central Finite Difference Schemes for spatial derivatives combined with an iterative Gauss-Seidel relaxation technique.
* **Convergence Threshold:** Iterates continuously until the relative pressure error matrix stabilizes below a strict global tolerance:

$$\text{Error} = \frac{\sum |p_{\text{new}} - p_{\text{old}}|}{\sum |p_{\text{new}}|} \le 10^{-3}$$

---

## Script Features & Outputs

1. **Flexible Mesh Discretization:** The user defines the node count along the circumferential ($N_x$) and axial ($N_z$) directions at runtime, allowing quick grid-independence analysis.
2. **Dimensional Scaling:** Once the non-dimensional pressure field ($\bar{p}$) completely converges, it automatically rescales to absolute dimensional pressure values ($P$, in $\text{Pa}$) using:

$$P = \bar{p} \left( \frac{\eta_0 U D}{c^2} \right)$$

3. **3D Visualization:** Generates an interactive 3D surface plot (`surfc`) mapping the distinct pressure profile across the longitudinal axis ($N_z$) and wrapping around the circumferential angular sweep ($N_x$).

---

## How to Run

1. Clone this repository to your local system.
2. Open `designlabpressureprofile.m` inside **MATLAB**.
3. Run the script and specify your grid resolution parameters when prompted in the command window (e.g., $N_x = 40$, $N_z = 20$).
