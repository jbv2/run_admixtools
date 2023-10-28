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
    qpDstat -p $parfile > ${prefix}.f4.test.OUT.log
    else 
    qpDstat -p $parfile > ${prefix}.D.test.OUT.log
    fi

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        qpDstat: \$(echo \$(qpDstat -V 2>&1) | sed 's/no parameters ## qpDstat version: //')
    END_VERSIONS
    """
}