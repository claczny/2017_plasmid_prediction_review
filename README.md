# 2017 Plasmid Prediction Review

`ensemble.mk` includes code used to cluster the candidate plasmid sequences as predicted by the evaluated tools (cBar, plasmidSPAdes, Recycler, PlasmidFinder).

To run this code, you should (at least) adjust the `SOFTWARE_DIR` variable and the `SAMPLES` variable to reflect your configuration.
Moreover, the per-sample predictions must exist for the tools of interest (here, cBar, plasmidSPAdes, Recycler, PlasmidFinder).
However, this code can be adapted to accomodate any set of plasmid predictions.

This code currently only removes the redundancy in the predictions and does *not* rank them, e.g., high-confidence clusters where >= 2 tools agree.



