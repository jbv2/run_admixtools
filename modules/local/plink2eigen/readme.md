# nf-module:plink2eigen
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** November 2023

---

## Module description:
Converts PLINK files to EIGENSTRAT format. 

## Module Dependencies:
trident v1.4.0.2 >
[Download and compile trident](https://www.poseidon-adna.org/#/trident)

### Input(s):

* A binary `.bed`.
* A `.bim` file.

Example line(s):

```bash
1       rs74512038      0       778597  T       C
1       rs553642122     0       790021  T       C
1       rs4951859       0       794299  G       C
...
```
* A `.fam` file.

Example line(s):

```bash
FAM1 sample1        0       0       0       -9
FAM2 sample2        0       0       0       -9
FAM3 sample3        0       0       0       -9
...
```

### Outputs:

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

## Module parameters:
NONE

## References
* https://github.com/poseidon-framework/poseidon-hs