process MAKE_PAR_qpDstat {
    tag "$meta.id"
    label 'process_single'

    input:
    tuple val(meta), path(geno)
    tuple val(meta), path(snp)
    tuple val(meta), path(ind)
    path(combinations)
    

    output:
    tuple val(meta), path("*.parfile"),   emit: parfile

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    
    def f4mode = task.ext.f4 ?: "${params.f4mode}"

"""
echo "genotypename: $geno" > ${prefix}.parfile
echo "snpname: $snp" >> ${prefix}.parfile 
echo "indivname: $ind" >> ${prefix}.parfile
echo "popfilename: $combinations" >> ${prefix}.parfile

# Explicitly set f4mode to YES if it's 'YES'
if [ '$f4mode' == 'YES' ]; then
    echo "f4mode: YES" >> ${prefix}.parfile
fi
"""
}
