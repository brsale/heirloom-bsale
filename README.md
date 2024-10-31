# This repo contains

1. some hypothetical data files
2. a skeleton `dbt` project with some models to stage the hypothetical data
3. (disabled) models to address the two query portions of the assignment
   - `carbon_trend.sql`: how did the carbon trend from one process to the next within an experiment?
   - `instrument_calibration.sql`: can the measurements from a instrument be trusted? Is it calibrated?

# ER Diagram

![heirloom_erd.png](Schema ER Diagram)

# Setup

This repo uses dbt and duckdb for that portion of the project.
To set up, create a virtual environment and run `pip install -r requirements.txt`.
