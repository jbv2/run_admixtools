# nf-module:plink
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** November 2023

---

## Module description:
Converts compressedd VCF to PLINK format.

## Module Dependencies:
Plink1.9 >
[Download and compile plink](https://www.cog-genomics.org/plink/1.9/)

### Input(s):

* A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

    For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)

    Example line(s):
    ```bash
    ##fileformat=VCFv4.2
    #CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	FAM1_sample1	FAM2_sample2	FAM3_sample3
    21      9411773 rs867796868     C       T       .       PASS    AC=0;AN=182     GT      0|0     0|0     0|0     0|0
    21      10979896        rs117219976     A       G       .       PASS    AC=1;AN=182     GT      0|1     0|0     0|0
    22      17176028        rs2845365       T       G       .       PASS    AC=58;AN=182    GT      1|0     0|0     0|1 
    ```

### Outputs:

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

## Module parameters:
* vcf-half-call="h"
  * 'haploid'/'h': Treat half-calls as haploid/homozygous (the PLINK 1 file format does not distinguish between the two). This maximizes similarity between the VCF and BCF2 parsers.
  * 'missing'/'m': Treat half-calls as missing.
  * 'reference'/'r': Treat the missing part as reference.

## References
* Purcell, S., Neale, B., Todd-Brown, K., Thomas, L., Ferreira, M. A., Bender, D., ... & Sham, P. C. (2007). PLINK: a tool set for whole-genome association and population-based linkage analyses. The American journal of human genetics, 81(3), 559-575.