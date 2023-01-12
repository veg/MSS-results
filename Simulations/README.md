# Simulating MSS-like data

####Requirements.

1.  The `develop` branch of [HyPhy](https://github.com/veg/hyphy)
2.  The most recent version of [HyPhy analyses](https://github.com/veg/hyphy-analyses/)

### Simulate the original MSS model

This assumes all synonymous substitutions between codons encoding for a speicific amino-acid 

What you need

1. A Newick tree with branch lengths (see `tree.nwk`)
2. A `.TSV` file with amino-acid partitions (see `specification.tsv`)
3. Optionally, if desired, a sequence alignment to collect nucleotide base frequencies from.

To simulate some data, assuming a specific partitioning of amino-acids into neutral and selected classes, global &omega; value, execute the following command (edit paths as needed), with &omega;=0.1 and `dSs = 0.8` and obtaining base frequencies from `example.fas` (assumed that this command is run with `cwd` set to `Simulations`

```
hyphy /path/to/hyphy-analyses/SimulateMG94/SimulateMG94.bf 
--model MSS  
--replicates 5   
--sites 300 
--branch-variation constant-mss  
--mss-file specification.tsv  
--mss-neutral NEUTRAL  
--tree tree.nwk 
--output data/example 
--mss-alpha_SELECTED 0.8 
--omega 0.1  
--base-frequencies `pwd`/example.fas
```

```
ls -1 data
example
example.replicate.1.nex
example.replicate.2.nex
example.replicate.3.nex
example.replicate.4.nex
example.replicate.5.nex
```

Check model fit

```
hyphy /path/to/hyphy-analyses/FitModel/FitModel.bf 
--model MSS 
--mss-file specification.tsv 
--mss-neutral NEUTRAL 
--alignment data/example.replicate.1.nex 
```


* Log(L) = -5086.05, AIC-c = 10254.60 (41 estimated parameters)
* Alignment-wide parameters and their maximum likelihood estimates (MLEs)

|                                                       Parameter                                                        |        MLE         |
|------------------------------------------------------------------------------------------------------------------------|--------------------|
|                                  Substitution rate from nucleotide A to nucleotide C                                   |          0.450832  |
|                                  Substitution rate from nucleotide A to nucleotide G                                   |          1.000000  |
|                                  Substitution rate from nucleotide A to nucleotide T                                   |          0.404567  |
|                                  Substitution rate from nucleotide C to nucleotide G                                   |          0.423164  |
|                                  Substitution rate from nucleotide C to nucleotide T                                   |          0.887574  |
|                                  Substitution rate from nucleotide G to nucleotide T                                   |          0.285467  |
|                                          non-synonymous/synonymous rate ratio                                          |          0.105792  |
|                                      synonymous rate within codon class SELECTED                                       |          0.816121  |

### Simulate the SynREVCodon model 

This assumes every pair of codons gets its own relative rate (set to 1 by default)

What you need

1. A Newick tree with branch lengths (see `tree.nwk`)
2. Optionally, if desired, a sequence alignment to collect nucleotide base frequencies from.
3. A reference rate (set to 1)
4. A list of rates that you wish to be different from 1


```
hyphy /path/to/hyphy-analyses/SimulateMG94/SimulateMG94.bf 
--model MSS  
--replicates 5   
--sites 300 
--branch-variation constant-mss  
--mss-type SynREVCodon
--tree tree.nwk 
--output data/example-codon
--mss-alpha_SELECTED 0.8 
--mss-reference-rate "synonymous rate between codon classes TTC and TTT"
--omega 0.1  
--mss-alpha_GGC_GGG 0.1 
--mss-alpha_GGA_GGT 0.1 
--mss-alpha_CCC_CCG 2.0
```

```
$ls -1 data/*codon*
data/example-codon
data/example-codon.replicate.1.nex
data/example-codon.replicate.2.nex
data/example-codon.replicate.3.nex
data/example-codon.replicate.4.nex
data/example-codon.replicate.5.nex
```

Check model fit

```
hyphy /path/to/hyphy-analyses/FitModel/FitModel.bf 
--model MSS 
--model MSS 
--mss-type SynREVCodon 
--alignment data/example-codon.replicate.1.nex 
```


* Log(L) = -5208.41, AIC-c = 10634.18 (107 estimated parameters)
* Alignment-wide parameters and their maximum likelihood estimates (MLEs)

|                                                       Parameter                                                        |        MLE         |
|------------------------------------------------------------------------------------------------------------------------|--------------------|
|                                          non-synonymous/synonymous rate ratio                                          |          0.212114  |
|                                   synonymous rate between codon classes GGC and GGG                                    |          0.451068  |
|                                   synonymous rate between codon classes GGA and GGT                                    |          0.000000  |
|                                   synonymous rate between codon classes CCC and CCG                                    |          5.201511  |
|                                   synonymous rate between codon classes TTC and TTT                                    |          4.966124  |


