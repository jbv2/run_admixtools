#!/usr/bin/env nextflow

/* 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 'run_admixtools' - A Nextflow pipeline to run fstatistics in Admixtools from distict input formats
 v0.0.1
 October 2023
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Judith Ballesteros Villascán
 GitHub: https://github.com/jbv2/run_admixtools
 ----------------------------------------------------------------------------------------
 */

/* 
 Enable DSL 2 syntax
 */
nextflow.enable.dsl = 2

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT LOCAL MODULES/SUBWORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

// 
// MODULES: Consisting of local modules
//

//
// SUBWORKFLOW: Consisting of local subworkflows
//

// TODO rename to active: index_reference, filter_bam etc.
include { VCF2ADMIXTOOLS   } from './subworkflows/local/vcf2admixtools'
include { PLINK2ADMIXTOOLS } from './subworkflows/local/plink2admixtools'
include { EIGEN2ADMIXTOOLS } from './subworkflows/local/eigen2admixtools'


/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    IMPORT NF-CORE MODULES/SUBWORKFLOWS
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/

//
// MODULE: Installed directly from nf-core/modules
//

/*
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    RUN WORKFLOW
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
*/


workflow {
    ch_versions       = Channel.empty()

    // Reading poplist
    if ( params.run_qpDstat ) {
    // Define a list of input parameters
    inputParams = [params.popA, params.popB, params.popC, params.popD]

    // Filter out non-empty parameters
    validInputs = inputParams.findAll { it }

    // Create a channel from the valid input strings
    ch_pops = Channel.fromList(validInputs).collect()

    } else if ( params.run_qp3Pop ) {
    // Define a list of input parameters
    inputParams = [params.popA, params.popB, params.popC]

    // Filter out non-empty parameters
    validInputs = inputParams.findAll { it }

    // Create a channel from the valid input strings
    ch_pops = Channel.fromList(validInputs).collect()

    }

    // Read inputs (VCF) and define name as ID

    if (params.input_type == 'vcf' ) {

    ch_vcf = Channel.fromFilePairs(params.inputVCF, size: -1)
        .map {
            meta, vcf ->
            def fmeta = [:]
            // Set meta.id
            fmeta.id = meta
            [ fmeta, vcf ]
        }

    Channel
        .fromPath(params.samples)
        .set { ch_samples }

    VCF2ADMIXTOOLS(ch_vcf, ch_samples, ch_pops)
    
    } else if (params.input_type == 'plink' ) {
    
    // Read inputs (PLINK) and define name as ID
   ch_bed = Channel.fromFilePairs(params.inputbed, size: -1)
    .map {
        meta, bed ->
        def baseName = bed.baseName.first()
        def dirPath = bed.parent.first()
        def bimPath = "${dirPath}/${baseName}.bim"
        def famPath = "${dirPath}/${baseName}.fam"
        def fmeta = [:]
        // Set meta.id
        fmeta.id = baseName
        [fmeta, bed, file(bimPath), file(famPath)]
    }

    PLINK2ADMIXTOOLS(ch_bed, ch_pops)

    } else if (params.input_type == 'eigenstrat' ) {

    // Read inputs (EIGENSTRAT) and define name as ID
   ch_geno = Channel.fromFilePairs(params.inputgeno, size: -1)
    .map {
        meta, geno ->
        def baseName = geno.baseName.first()
        def dirPath = geno.parent.first()
        def snpPath = "${dirPath}/${baseName}.snp"
        def indPath = "${dirPath}/${baseName}.ind"
        def fmeta = [:]
        // Set meta.id
        fmeta.id = baseName
        [fmeta, geno, file(snpPath), file(indPath)]
    }

    EIGEN2ADMIXTOOLS(ch_geno, ch_pops)

    }
}
