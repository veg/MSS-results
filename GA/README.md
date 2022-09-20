# Running MSS GA

####Requirements.

1.  The `develop` branch of [HyPhy](https://github.com/veg/hyphy)


There are two types of GA run here

1. By amino-acid: all synonymous substitutions to/from the same amino-acid are either NEUTRAL or SELECTED
2. By codon: individual synonymous codon pairs are either NEUTRAL or SELECTED

##### What you need.

1. Alignment files you wish to run the GA on. Each alignment file must include a tree
2. A line list of absolute paths to these files

### Example

#### Make line list of file names

```
ls -1 `pwd`/files/* > files.lst
```

The files in `files` have been simulated using the selection profile in `profile.tsv`

#### Run by amino-acid GA using the BIC selection criterion

```
mpirun -np 6 HYPHYMPI /path/to/hyphy/TemplateBatchFiles/MSS-selector.bf --ic BIC 
--filelist files.lst
--output BIC.json
```

### Note: for by codon analysis, everything is the same except `MSS-selector.bf` &rarr; `MSS-selector-2.bf` 

Partial output...

* Loaded a list with **40** files
code: Universal
ic: BIC
mss-type: SynREVFull

Individual file statistics and simple model fits

|                                                        Filepath                                                        |   Sequences    |     Sites      |   TreeLength   |     Log(L)     |
|------------------------------------------------------------------------------------------------------------------------|----------------|----------------|----------------|----------------|
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000015_NT_033777.3_4_species_4_seqs.msa.raxml.bestTree....|       4        |      500       |       0.039    |    -2405.3654  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000017_NT_037436.4_5_species_5_seqs.msa.raxml.bestTree....|       5        |      500       |       0.187    |    -3212.6147  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000100_NT_037436.4_12_species_13_seqs.msa.raxml.bestTre...|       12       |      500       |       0.171    |    -3628.1197  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000014_NT_033777.3_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.280    |    -4497.3440  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000108_NC_004354.4_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.317    |    -4542.9272  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000018_NT_033779.5_11_species_11_seqs.msa.raxml.bestTre...|       11       |      500       |       0.616    |    -6370.0548  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000109_NT_037436.4_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.604    |    -6528.0365  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000116_NT_037436.4_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.217    |    -3902.2086  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000115_NT_037436.4_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.199    |    -3856.2171  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000114_NT_033779.5_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.321    |    -4591.9826  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000117_NC_004354.4_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.287    |    -4463.9680  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000119_NT_033778.4_11_species_11_seqs.msa.raxml.bestTre...|       11       |      500       |       0.442    |    -5325.4575  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000121_NT_037436.4_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.283    |    -4529.2011  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000120_NT_033779.5_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.286    |    -4526.7355  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000137_NC_004354.4_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.507    |    -5319.9183  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000139_NT_033777.3_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.459    |    -5681.3849  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000152_NC_004354.4_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.416    |    -5315.8573  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000140_NT_033777.3_11_species_11_seqs.msa.raxml.bestTre...|       11       |      500       |       0.648    |    -6593.3642  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000157_NT_033778.4_7_species_7_seqs.msa.raxml.bestTree....|       7        |      500       |       0.122    |    -3037.8657  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000153_NT_033779.5_12_species_12_seqs.msa.raxml.bestTre...|       11       |      500       |       0.384    |    -5107.2847  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000150_NT_033777.3_12_species_14_seqs.msa.raxml.bestTre...|       14       |      500       |       0.818    |    -6191.4463  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000163_NC_004354.4_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.295    |    -4392.4833  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000166_NT_033777.3_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.391    |    -5037.8999  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000180_NT_033779.5_7_species_7_seqs.msa.raxml.bestTree....|       7        |      500       |       0.227    |    -3661.4317  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000173_NC_004354.4_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.312    |    -4648.1461  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000179_NC_004354.4_11_species_11_seqs.msa.raxml.bestTre...|       11       |      500       |       0.309    |    -4504.8554  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000158_NT_033777.3_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       1.069    |    -8737.7841  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000181_NT_033778.4_12_species_12_seqs.msa.raxml.bestTre...|       11       |      500       |       0.156    |    -3495.3484  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001075_NT_033779.5_7_species_7_seqs.msa.raxml.bestTree....|       7        |      500       |       0.196    |    -3675.3453  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001078_NT_037436.4_4_species_4_seqs.msa.raxml.bestTree....|       4        |      500       |       0.087    |    -2784.8343  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000182_NT_033779.5_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.301    |    -4421.1165  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001077_NT_033777.3_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.333    |    -4725.3471  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0000183_NT_033779.5_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.374    |    -5042.9816  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001085_NT_037436.4_5_species_5_seqs.msa.raxml.bestTree....|       5        |      500       |       0.080    |    -2734.4699  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001083_NC_004354.4_10_species_10_seqs.msa.raxml.bestTre...|       10       |      500       |       0.360    |    -4755.9682  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001084_NT_033779.5_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.627    |    -6645.2963  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001089_NT_033779.5_7_species_7_seqs.msa.raxml.bestTree....|       7        |      500       |       0.145    |    -3314.2074  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001079_NC_004354.4_11_species_11_seqs.msa.raxml.bestTre...|       11       |      500       |       0.547    |    -5974.7851  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001087_NC_004354.4_8_species_8_seqs.msa.raxml.bestTree....|       8        |      500       |       0.252    |    -4024.9318  |
|/Users/sergei/Dropbox/Work/Collaborations/MSS/power-sims/FBgn0001086_NT_033779.5_12_species_12_seqs.msa.raxml.bestTre...|       12       |      500       |       0.538    |    -6059.8341  |

....

```
[MSS-GA]   2 rates [ generation    110, total models      503,   99% converged,  0.44/sec]. Min (c-AIC) =  392059.0047 [ delta =    17.68], rate profile 010010111100100001	000010111100100001 IC =     392060.1066, delta =    16.58
	000010111110100001 IC =     392062.5581, delta =    14.13
	000110011100100000 IC =     392066.2938, delta =    10.39
	000110011100100001 IC =     392063.8969, delta =    12.79
	000110101100100001 IC =     392063.7864, delta =    12.90
	000110110100100001 IC =     392063.1025, delta =    13.58
	010010111100100001 IC =     392059.0047, delta =    17.68
	010010111100110000 IC =     392063.4709, delta =    13.21
	010010111110100001 IC =     392061.3829, delta =    15.30
	010110011100100001 IC =     392062.7265, delta =    13.96
	010110101100100000 IC =     392064.9231, delta =    11.76
	010110101100100001 IC =     392062.6572, delta =    14.03
	010110110100100001 IC =     392061.9562, delta =    14.73
	010110110100110001 IC =     392063.6082, delta =    13.08
	010110110110100001 IC =     392064.1537, delta =    12.53
	010110111100100001 IC =     392059.0584, delta =    17.63
	010110111100110000 IC =     392063.1530, delta =    13.53
	010110111100110001 IC =     392060.8197, delta =    15.86
	010110111110100001 IC =     392061.3014, delta =    15.38
	010110111110110001 IC =     392062.5206, delta =    14.16
	011010111100100001 IC =     392062.3843, delta =    14.30
	011110111100110001 IC =     392063.3483, delta =    13.34
```


#### Process the results

```
hyphy scripts/processor.bf --json BIC.json --tsv BIC.tsv
```

#### Repeat the run with c-AIC 

```
mpirun -np 6 HYPHYMPI /path/to/hyphy/TemplateBatchFiles/MSS-selector.bf 
--ic AIC-c 
--filelist files.lst
--output AIC.json
```

Partial output...

```

[MSS-GA]   2 rates [ generation      3, total models      122,    0% converged,  0.45/sec]. Min (c-AIC) =  379070.6804 [ delta =    20.36], rate profile 000010100100100001	000010010100000000 IC =     379078.9366, delta =    12.10
	000010100100100001 IC =     379070.6804, delta =    20.36
	000010101100100011 IC =     379079.3370, delta =    11.70
	000010110000000100 IC =     379092.0010, delta =    -0.96
	000011100100000100 IC =     379091.4607, delta =    -0.42
	000011100100100000 IC =     379083.4720, delta =     7.57
	000011100101100000 IC =     379088.8819, delta =     2.16
	000011100101100001 IC =     379087.4599, delta =     3.58
	000101010100100011 IC =     379088.6731, delta =     2.37
	000101100110000001 IC =     379088.1840, delta =     2.86
	000101110011000111 IC =     379090.7832, delta =     0.26
	000110100100000000 IC =     379078.7554, delta =    12.29
	000110110100100001 IC =     379067.2709, delta =    23.77
	000111000001101011 IC =     379088.5286, delta =     2.51
	000111000010000000 IC =     379093.0186, delta =    -1.98
	000111100100000000 IC =     379086.8884, delta =     4.15
	000111100110000000 IC =     379087.6720, delta =     3.37
	000111101100100001 IC =     379078.7064, delta =    12.33
	000111111110000001 IC =     379081.2840, delta =     9.76
	001001010100101011 IC =     379093.0666, delta =    -2.03
	001011100100100011 IC =     379088.5343, delta =     2.51
	001011100100110010 IC =     379088.6893, delta =     2.35
	001101001100101010 IC =     379092.9979, delta =    -1.96
	001101100100000101 IC =     379091.8732, delta =    -0.83
	001110100100010001 IC =     379079.4863, delta =    11.55
	001111000101010000 IC =     379091.5463, delta =    -0.51
	001111100100001001 IC =     379092.7048, delta =    -1.66
	010001100001000100 IC =     379089.6283, delta =     1.41
	010001100001100010 IC =     379092.2959, delta =    -1.25
	010010100101100011 IC =     379086.7259, delta =     4.32
	011001110001001000 IC =     379088.3191, delta =     2.72
	011111100001100011 IC =     379093.0614, delta =    -2.02
	
```


#### Process the results

```
hyphy scripts/processor.bf --json AIC.json --tsv AIC.tsv
```

#### Compare simulated truth with results



