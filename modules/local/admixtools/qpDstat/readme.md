# nf-module:admixtools_qpDstat
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** November 2023

---

## Module description:
Run qpDstat from AdmixTools.

## Module Dependencies:
qpDstat v980 > [Download and compile qpDstat](https://github.com/DReichLab/AdmixTools)

### Input(s):

* A binary `.geno`.
* A `.snp` file.

Example line(s):

```bash
rs74512038       1      0       778597  T       C
rs553642122       1     0       790021  T       C
rs4951859       1       0       794299  G       C
...
```

* A `.ind` file.

Example line(s):

```bash
sample1 U FAM1
sample2 U FAM2
sample3 U FAM3
...
```

* A `.ftest.txt` file with combinations.

Example line(s):

```bash
CHB	PEL	Maya	Mixe
CHB	PEL	Maya	Nahua
CHB	PEL	Mixe	Maya
CHB	PEL	Mixe	Nahua
CHB	PEL	Nahua	Maya
CHB	PEL	Nahua	Mixe
```
* A `.parfile` file.

Example line(s):

```bash
genotypename: test.geno
snpname: test.snp
indivname: test.ind
popfilename: test.ftest.txt
printsd:  YES
f4mode: YES
```

### Outputs:

* A `.OUT.log` file.

Example line(s):

```bash
qpDstat: parameter file: test.parfile
### THE INPUT PARAMETERS
##PARAMETER NAME: VALUE
genotypename: test.geno
snpname: test.snp
indivname: test.ind
popfilename: test.ftest.txt
printsd: YES
f4mode: YES
## qpDstat version: 980
inbreed set NO
test.snp: genetic distance set from physical distance
*** warning: first snp . is number.  perhaps you are using .map format
number of quadruples 6
  0                  CHB    1
  1                  PEL    4
  2                 Maya    4
  3                 Mixe    5
  4                Nahua   13
jackknife block size:     0.050
snps: 59920  indivs: 27
number of blocks for block jackknife: 9
nrows, ncols: 27 59920
result:        CHB        PEL       Maya       Mixe     -0.000913      0.003262    -0.280    3756   3811  59905 
result:        CHB        PEL       Maya      Nahua      0.002345      0.002936     0.799    3875   3734  59905 
result:        CHB        PEL       Mixe       Maya      0.000913      0.003262     0.280    3811   3756  59905 
```

* A `.result.tsv` with header and separated by TAB.
```bash
PopA	PopB	PopC	PopD	f4	stderr	Zscore
CHB	PEL	Maya	Mixe	-0.000913	0.003262	-0.280
CHB	PEL	Maya	Nahua	0.002345	0.002936	0.799
CHB	PEL	Mixe	Maya	0.000913	0.003262	0.280
CHB	PEL	Mixe	Nahua	0.003258	0.001824	1.787
CHB	PEL	Nahua	Maya	-0.002345	0.002936	-0.799
CHB	PEL	Nahua	Mixe	-0.003258	0.001824	-1.787
```

## Module parameters:
NONE

## References
* Patterson, Nick, et al. "Ancient admixture in human history." Genetics 192.3 (2012): 1065-1093.