# nf-module:make_par_qp3Pop
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** November 2023

---

## Module description:
Make PAR file to run qpDstat.

## Module Dependencies:
NONE

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

### Outputs:

* A `.parfile` file.

Example line(s):

```bash
genotypename: test.geno
snpname: test.snp
indivname: test.ind
popfilename: test.ftest.txt
inbreed: YES
```

## Module parameters:
* Option to use qp3Pop:
```bash
run_qp3Pop = true
```

* If `inbreed` set NO, outgroup f3 is calculated. YES calculates Admixture F3.
```bash
inbreed = "YES"
```
## References
NONE