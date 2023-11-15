# nf-module:bcftools_reheader
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** November 2023

---

## Module description:
Rename samples in a compressed VCF with bcftools.

## Module Dependencies:
bcftools 1.17 > [Download and compile bcftools](https://samtools.github.io/bcftools/howtos/install.html)

### Input(s):

* A `VCF` file compressed with a `.vcf.gz` extension. A `VCF` file mainly contains meta-information lines, a header and data lines with information about each position. The header names the eigth mandatory columns `CHROM, POS, ID, REF, ALT, QUAL, FILTER, INFO`. 

    Also, it requires the index file with extension `.tbi`

    For more information about the VCF format, please go to the next link: [Variant Call Format](https://www.internationalgenome.org/wiki/Analysis/Variant%20Call%20Format/vcf-variant-call-format-version-40/)

    Example line(s):
    ```bash
    ##fileformat=VCFv4.2
    #CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	sample1	sample2	sample3
    21      9411773 rs867796868     C       T       .       PASS    AC=0;AN=182     GT      0|0     0|0     0|0     0|0
    21      10979896        rs117219976     A       G       .       PASS    AC=1;AN=182     GT      0|1     0|0     0|0
    22      17176028        rs2845365       T       G       .       PASS    AC=58;AN=182    GT      1|0     0|0     0|1 
    ```

* A two columns file, separated by space with old_name new_name.
  ```bash
  sample1 FAM1_sample1
  sample2 FAM2_sample2
  sample3 FAM3_sample3
  ```

### Outputs:

* A `_renamed.vcf.gz` with the renamed samples.
  
Example line(s):
```bash
##fileformat=VCFv4.2
#CHROM	POS	ID	REF	ALT	QUAL	FILTER	INFO	FORMAT	FAM1_sample1	FAM2_sample2	FAM3_sample3
21      9411773 rs867796868     C       T       .       PASS    AC=0;AN=182     GT      0|0     0|0     0|0     0|0
21      10979896        rs117219976     A       G       .       PASS    AC=1;AN=182     GT      0|1     0|0     0|0
22      17176028        rs2845365       T       G       .       PASS    AC=58;AN=182    GT      1|0     0|0     0|1 
```

## Module parameters:
NONE

## References
* Narasimhan, V., Danecek, P., Scally, A., Xue, Y., Tyler-Smith, C., & Durbin, R. (2016). BCFtools/RoH: a hidden Markov model approach for detecting autozygosity from next-generation sequencing data. Bioinformatics, 32(11), 1749-1751.