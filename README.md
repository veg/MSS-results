# MSS-results

Visualizations of our results running the MSS model on various datasets can be found below:  
## *Drosophila*
**SynREV2:** https://observablehq.com/@hverdonk/synrev-codon-drosophila  
**Model Comparison:** https://observablehq.com/@spond/visualizing-mss-model-results-for-drosophila-genes-take-2   

## *Caenorhabditis*
https://observablehq.com/@hverdonk/synrev-codon-caenorhabditis   

## *Saccharomyces*
https://observablehq.com/@hverdonk/synrev-codon-saccharomyces  

# *Definitions*
**Substitution Models**

*MG94*: (Muse Gaut 1994 https://doi.org/10.1093/oxfordjournals.molbev.a040152 ) Actually a modified version of the Muse Gaut method that allows for transversion/transition substitution bias and varying nucleotide frequencies between positions in a codon (Pond & Frost 2004, https://doi.org/10.1093/molbev/msi131). 

*MSS*: (Multiclass Synonymous Substitution) model, as defined in Rahman et al 2021 https://doi.org/10.1073/pnas.2023575118
Based on MG94,  but with two (or more) classes of synonymous substitutions.  In the special case where there are two classes (named SELECTED and NEUTRAL) there are 4 rates: dN (conventional non-synonymous rate), dSn (rate between NEUTRAL synonymous codons), dSs (rate between SELECTED synonymous codons), and the rate between NEUTRAL and SELECTED codons (which may be zero if no amino acids have some codons in both classes).   Hyphy sets dSn = 1 and returns the other rates relative to dSn. Note that dN/dSn can be compared to MG94 dN/dS, in which case it should, on average across genes, be the case that dN/dSn < dN/dS.

*SynREV*:	Each group of synonymous codons reachable by one nucleotide substitution is given its own rate (one rate per amino-acid)

*SynREV2*:	Each pair of synonymous codons that share an amino acid and which differ only by a transition in the 3rd codon position is given its own rate; all other synonymous changes share a separate rate.

*SynREVX*:	Each pair of synonymous codons that share an amino acid and that are reachable by one nucleotide substitution is given its own rate

**Methods for Identifying the Neutral Set**  

*FA1*:  Codons are identified using factor analysis, as in Rahman et al 2021.  Factor analysis is run on a table (genes by codons, using relative codon frequency within an amino acid) to identify the dominant pattern of covariation in codon frequency.  The logic is that some selective forces (e.g. gene expression) cause substs of codons to tend to become more common together in some genes. Codons that do not covary in frequency with others are likely to be more neutral.  The codons with the smallest absolute loading score for factor 1 are designated as Neutral. 

*Margins from Many Rates (MMR)*:  Run a model with many rates (e.g. SynREV2) over lots of genes and get a mean value for each of the rates.  The rates with the highest mean values are candidates for a Neutral class in a smaller MSS model. 

*CHC genetic algorithm*: An agggressive hill climber with dramtic mutagenesis & recombination. The model effectively uses small populations to converge to a good solution.


