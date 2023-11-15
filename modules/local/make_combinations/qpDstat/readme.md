# nf-module:make_combinations_qpDstat
**Author(s):**

* Judith Ballesteros Villascán (judith.vballesteros@gmail.com)

**Date:** November 2023

---

## Module description:
Considering the following tree:
![tree](../../../../docs/qpDstat_combinations.png)

Module takes a vector of populations for each position in the tree (A,B,C,D) and make all possible combinations to test it.

## Module Dependencies:
NONE

### Input(s):

Populations as parameters.

### Outputs:

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

## Module parameters:
A vector for each position in the tree.

Example line(s):

```bash
popA="CHB"
popB="PEL"
popC="Maya Mixe Nahua"
popD="Maya Mixe Nahua"
```

## References
NONE