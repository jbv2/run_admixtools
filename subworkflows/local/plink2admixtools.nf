//
// Run ADMIXTOOLS from a bfile as input
//

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT LOCAL MODULES/SUBWORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT LOCAL MODULES/SUBWORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/
include { PLINK2EIGEN               } from '../../modules/local/plink2eigen/main'
include { MAKE_COMBINATIONS_qpDstat } from '../../modules/local/make_combinations/qpDstat/main'
include { MAKE_COMBINATIONS_qp3Pop  } from '../../modules/local/make_combinations/qp3Pop/main'
include { MAKE_PAR_qpDstat          } from '../../modules/local/make_par/qpDstat/main'
include { MAKE_PAR_qp3Pop           } from '../../modules/local/make_par/qp3Pop/main'
include { ADMIXTOOLS_qpDstat        } from '../../modules/local/admixtools/qpDstat/main'
include { ADMIXTOOLS_qp3Pop        } from '../../modules/local/admixtools/qp3Pop/main'

workflow PLINK2ADMIXTOOLS {

    take:
    bfile // channel : [ val[meta], [bed], [bim], [fam]]
    pops // channel : [ val(popA), val(popB). val(popC), val(popD)]

    main:
    ch_versions       = Channel.empty()

    
    // Convert PLINK to EIGENSTRAT
    ch_input = bfile
    .multiMap {meta, bed, bim, fam ->
    bed: [meta, bed]
    bim: [meta, bim]
    fam: [meta, fam]
    }

    PLINK2EIGEN(ch_input)
    ch_versions = ch_versions.mix(PLINK2EIGEN.out.versions)

    //Make Combinations
        ch_meta = PLINK2EIGEN.out.geno
            .map{meta, geno ->
            meta
            }

    if ( params.run_qpDstat ) {
        
        MAKE_COMBINATIONS_qpDstat(ch_meta, pops)
        ch_combinations = MAKE_COMBINATIONS_qpDstat.out.txt

        // Make PARFILE   
        MAKE_PAR_qpDstat(PLINK2EIGEN.out.geno, PLINK2EIGEN.out.snp, PLINK2EIGEN.out.ind, ch_combinations)
        ch_parfile = MAKE_PAR_qpDstat.out.parfile

        // Run Admixtools

        ADMIXTOOLS_qpDstat(PLINK2EIGEN.out.geno, PLINK2EIGEN.out.snp, PLINK2EIGEN.out.ind, ch_parfile, ch_combinations)
        ch_versions = ch_versions.mix(ADMIXTOOLS_qpDstat.out.versions)
        ch_log = ADMIXTOOLS_qpDstat.out.log

        } else if ( params.run_qp3Pop ) {
        
        MAKE_COMBINATIONS_qp3Pop(ch_meta, pops)
        ch_combinations = MAKE_COMBINATIONS_qp3Pop.out.txt

        // Make PARFILE   
        MAKE_PAR_qp3Pop(PLINK2EIGEN.out.geno, PLINK2EIGEN.out.snp, PLINK2EIGEN.out.ind, ch_combinations)
        ch_parfile = MAKE_PAR_qp3Pop.out.parfile

        // Run Admixtools

        ADMIXTOOLS_qp3Pop(PLINK2EIGEN.out.geno, PLINK2EIGEN.out.snp, PLINK2EIGEN.out.ind, ch_parfile, ch_combinations)
        ch_versions = ch_versions.mix(ADMIXTOOLS_qp3Pop.out.versions)
        ch_log = ADMIXTOOLS_qp3Pop.out.log

        }

    emit:
    output   = ch_log
    versions = ch_versions

}