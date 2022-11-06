RequireVersion ("2.5.34");

LoadFunctionLibrary ("libv3/all-terms.bf");
LoadFunctionLibrary ("libv3/convenience/regexp.bf");
LoadFunctionLibrary ("libv3/convenience/math.bf");
LoadFunctionLibrary ("libv3/IOFunctions.bf");
LoadFunctionLibrary ("libv3/tasks/alignments.bf");


KeywordArgument ("json","MSS-Selector output .JSON file",None);
mss.json = io.ParseJSON(io.PromptUserForFilePathRead ("MSS-Selector output .JSON file"));

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
    if (s[1] > 1e-4) {
        mss.filtered[k] = s;
    }
}

mss.SN_profile = {mss.dimension, 1};
mss.SN_MA_rate = {mss.dimension, 1};

for (k, s; in; mss.filtered) {
    nr = 0;
    rates = {{1,s[mss.rd-1]}};
    if (s[ mss.rd - 1] > 1) { // rate class 1 is NEUTRAL
        nr = 1;
        rates = {{1/s[ mss.rd - 1] , 1}};
    }
    for (i = 0; i < mss.dimension; i+=1) {
        ri = +k[i];
        if (ri == nr) {
            mss.SN_profile [i] += s[1];
        }
        mss.SN_MA_rate [i] += s[1] * rates[ri];
    }
}

//console.log (mss.SN_profile);

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
    label = "NEUTRAL";
    if (mss.SN_profile[k] < 0.10) {
        label = "SELECTED";
    }  else {
        if (mss.SN_profile[k] < 0.90) {
            label = "AMBIGUOS";
        } 
    }
    aa = mss.mapping [k];
    for (codon; in; mss.aa2codon [aa]) {
        fprintf (mss.output, aa, "\t", codon, "\t", label, "\t", mss.SN_profile[k], "\n");
    }
}