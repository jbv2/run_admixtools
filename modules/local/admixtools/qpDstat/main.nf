process ADMIXTOOLS_qpDstat {
    tag "$meta.id"
    label 'process_high_memory'

    input:
    tuple val(meta), path(geno)
    tuple val(meta), path(snp)
    tuple val(meta), path(ind)
    tuple val(meta), path(parfile)
    path(combinations)


    output:
    tuple val(meta), path("*.OUT.log"),   emit: log
    tuple val(meta), path("*.tsv"),       emit: tsv
    path "versions.yml"               ,   emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    
    def f4mode = task.ext.f4 ?: "${params.f4mode}"

    """
    # Conditionally set poplistname based on f4mode
    if [ '$f4mode' == 'YES' ]; then
    qpDstat -p $parfile > ${prefix}.f4.test.OUT.log \
    && echo "PopA PopB PopC PopD f4 stderr Zscore SNPs" | tr " " "\t" > ${prefix}.f4.result.tsv \
    && grep "result" ${prefix}.f4.test.OUT.log | tr -s " " | tr " " "\t" | cut -f2,3,4,5,6,7,8,11 >> ${prefix}.f4.result.tsv
    else 
    qpDstat -p $parfile > ${prefix}.D.test.OUT.log \
    && echo "PopA PopB PopC PopD D stderr Zscore SNPs" | tr " " "\t" > ${prefix}.D.result.tsv \
    && grep "result"${prefix}.D.test.OUT.log | tr -s " " | tr " " "\t" | cut -f2,3,4,5,6,7,8,11 >> ${prefix}.D.result.tsv
    fi

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        qpDstat: \$(echo \$(qpDstat -V 2>&1) | sed 's/no parameters ## qpDstat version: //')
    END_VERSIONS
    """
}
