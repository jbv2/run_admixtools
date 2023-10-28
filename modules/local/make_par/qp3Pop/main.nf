process MAKE_PAR_qp3Pop {
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
    
    def inbreed = task.ext.f3 ?: "${params.inbreed}"

"""
echo "genotypename: $geno" > ${prefix}.parfile
echo "snpname: $snp" >> ${prefix}.parfile 
echo "indivname: $ind" >> ${prefix}.parfile
echo "popfilename: $combinations" >> ${prefix}.parfile

# Explicitly set f4mode to YES if it's 'YES'
if [ '$inbreed' == 'YES' ]; then
    echo "inbreed: YES" >> ${prefix}.parfile
fi
"""
}