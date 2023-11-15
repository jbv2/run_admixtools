# nf-module:make_par_qpDstat
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
CHB	PEL	Maya	Mixe
CHB	PEL	Maya	Nahua
CHB	PEL	Mixe	Maya
CHB	PEL	Mixe	Nahua
CHB	PEL	Nahua	Maya
CHB	PEL	Nahua	Mixe
```

### Outputs:

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

## Module parameters:
* Option to use qpDstat:
```bash
run_qpDstat = true
```
* If `f4mode` set NO, f4 is calculated. YES calculates D.
```bash
f4mode = "YES"
```

## References
NONE