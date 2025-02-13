RequireVersion ("2.5.34");

LoadFunctionLibrary ("libv3/all-terms.bf");
LoadFunctionLibrary ("libv3/convenience/regexp.bf");
LoadFunctionLibrary ("libv3/convenience/math.bf");
LoadFunctionLibrary ("libv3/IOFunctions.bf");
LoadFunctionLibrary ("libv3/tasks/alignments.bf");


KeywordArgument ("json","MSS-Selector output .JSON file",None);
mss.json = io.ParseJSON(io.PromptUserForFilePathRead ("MSS-Selector output .JSON file"));
mss.cutoff = 0.5;

mss.mapping = {};

for (k; in; mss.json ["mapping"]) {
    mss.mapping + k[Abs(k)-1];
}

mss.bestScore = 1e100;
mss.models = {};

for (m, s; in;  mss.json["masterList"] ) {
    k = Join ("", Eval (m));
    if (s[0] < mss.bestScore) {
        mss.bestScore = s[0];
        mss.bestModel = k;
        mss.dimension = Abs (k);
        mss.rd = utility.Array1D (s);
    }
    mss.models [k] = s;
}


mss.aw = 0;

for (k, s; in; mss.models) {
    s[1] = Exp ((mss.bestScore-s[0]) * 0.5);
    mss.models[k] = s;
    mss.aw += s[1];
}

mss.filtered = {};

for (k, s; in; mss.models) {
    s[1] = s[1] / mss.aw;
    mss.models[k] = s;
    if (s[1] > 1e-6) {
        mss.filtered[k] = s;
    }
}

mss.nr = mss.rd - 2;

mss.SN_profile = {mss.dimension, mss.nr};
mss.SN_MA_rate = {mss.dimension, 1};
mss.labels     = {mss.nr,1};

mss.labels [0] = "SELECTED";
mss.labels [mss.nr-1] = "NEUTRAL";

for (i = 1; i < mss.nr - 1; i+=1) {
    if (i > 1) {
        mss.labels[i] = "INTERMEDIATE_" + i;
    } else {
        mss.labels[i] = "INTERMEDIATE";
    }
}

for (k, s; in; mss.filtered) {
    nr = 0;
    mss.rd =  utility.Array1D (s);
    
    // find the maximum rate
    
    mss.rate_values = s[{{0,2}}][{{0,mss.rd-1}}];
    mss.max_rate = Max (mss.rate_values, 1);
    nr = mss.max_rate[1];
    mss.sorted_rates = {mss.rd-2,3};
    
    for (i = 0; i < mss.rd-2; i+=1) {
         mss.sorted_rates[i][0] =   mss.rate_values[i];
         mss.sorted_rates[i][1] = i;
    }
    
    mss.sorted_rates = mss.sorted_rates % 0;
    
    for (i = 0; i < mss.rd-2; i+=1) {
         mss.sorted_rates[i][2] = i;
    }    
    
    mss.sorted_rates = mss.sorted_rates % 1;
    
    
    rates = mss.rate_values * (1/mss.max_rate[0]);

    
    for (i = 0; i < mss.dimension; i+=1) {
        ri = +k[i];
        mss.SN_profile [i][mss.sorted_rates[+k[i]][2]] += s[1];
        mss.SN_MA_rate [i] += s[1] * rates[ri];
    }
}


KeywordArgument ("code",        "Which genetic code should be used", "Universal");  
mss.genetic_code = alignments.LoadGeneticCode (None);

mss.aa2codon = {};

for (codon, aa; in; mss.genetic_code["mapping"]) {
    if (mss.aa2codon / aa == FALSE) {
        mss.aa2codon [aa] = {};
    }
    mss.aa2codon [aa] + codon;
}   

KeywordArgument ("tsv",        "Output model partition");  
mss.output = io.PromptUserForFilePath ("Output model partition");


fprintf (mss.output, "AminoAcid\tCODON\tGROUP\tSUPPORT\n");

for (k = 0; k < mss.dimension; k +=1) {
    label = "";
    /*
    if (mss.SN_profile[k] < 0.10) {
        label = "SELECTED";
    }  else {
        if (mss.SN_profile[k] < 0.90) {
            label = "AMBIGUOS";
        } 
    }*/
    
    //console.log ( mss.SN_profile[k][-1]);
    for (i = 0; i < mss.nr; i+=1) {
        if ( mss.SN_profile[k][i] >=  mss.cutoff) {
            label = mss.labels [i];
            support =  mss.SN_profile[k][i];
            break;
        }
    }
    //console.log ( label);
    if (Abs (label) == 0 ) {label = "AMBIGUOUS"; support = Max ( mss.SN_profile[k][-1],0);}
    aa = mss.mapping [k];
    for (codon; in; mss.aa2codon [aa]) {
        fprintf (mss.output, aa, "\t", codon, "\t", label, "\t",support, "\n");
    }
}