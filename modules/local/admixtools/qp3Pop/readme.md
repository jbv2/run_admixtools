# nf-module:admixtools_qp3Pop
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** November 2023

---

## Module description:
Run qp3Pop from AdmixTools.

## Module Dependencies:
qp3Pop v651 > [Download and compile qp3Pop](https://github.com/DReichLab/AdmixTools)

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
CHB	PEL	Maya
CHB	PEL	Mixe
CHB	PEL	Nahua
```
* A `.parfile` file.

Example line(s):

```bash
genotypename: test.geno
snpname: test.snp
indivname: test.ind
popfilename: test.ftest.txt
inbreed: YES
```

### Outputs:

* A `.OUT.log` file.

Example line(s):

```bash
qp3Pop: parameter file: test.parfile
### THE INPUT PARAMETERS
##PARAMETER NAME: VALUE
genotypename: test.geno
snpname: test.snp
indivname: test.ind
popfilename: test.ftest.txt
inbreed: YES
## qp3Pop version: 651
inbreed set YES
test.snp: genetic distance set from physical distance
*** warning: first snp . is number.  perhaps you are using .map format
number of triples 3
nplist: 3
snps: 59920
number of blocks for block jackknife: 9
                      Source 1             Source 2               Target           f_3       std. err           Z    SNPs
 result:                   CHB                  PEL                 Maya      0.001641       0.011348       0.145   53604
```

## Module parameters:
NONE

## References
* Patterson, Nick, et al. "Ancient admixture in human history." Genetics 192.3 (2012): 1065-1093.