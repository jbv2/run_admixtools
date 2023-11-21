process PLINK {
    tag "$meta.id"
    label 'process_low'

    input:
    tuple val(meta), path(vcf)

    output:
    tuple val(meta), path("*.bed"),   emit: bed
    tuple val(meta), path("*.bim"),   emit: bim
    tuple val(meta), path("*.fam"),   emit: fam
    path "versions.yml"           ,   emit: versions

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    """
    memory=\$(echo "$task.memory" | sed "s# GB#000#")
    plink --vcf $vcf \
        --keep-allele-order \
        --memory \${memory} \
        $args \
        --make-bed \
        --out ${prefix} 

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        plink: \$(echo \$(plink --version) | sed 's/^PLINK v//;s/64.*//')
    END_VERSIONS
    """
}
