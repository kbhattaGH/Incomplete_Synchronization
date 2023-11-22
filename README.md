# Incomplete_Synchronization
Code available for paper "Incomplete Synchronization in Networks of Coupled Identical Oscillators" by Bhatta, K and Sorrentino, F.

**To reproduce Results**

1. Open run_ImpSynch.m
2. Change num_iter to 50 and run
3. Change ODE solver in line 46 to ensure numerical validity
4. To change between rosseler and lorenz systems, comment/uncomment line 25 or 27.
5. To calculate coupling in x, use function "Imp_Synchx" in line 46 and to calculate coupling in y, use function "Imp_Synch".
