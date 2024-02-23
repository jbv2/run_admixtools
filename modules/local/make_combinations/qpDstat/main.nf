process MAKE_COMBINATIONS_qpDstat {
    tag "$meta.id"
    label 'process_single'

    input:
    val(meta)
    tuple val(popA), val(popB), val(popC), val(popD)
    
    output:
    path("*ftest.txt"),   emit: txt

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    export A=\$(echo "$popA")
    export B=\$(echo "$popB")
    export C=\$(echo "$popC")
    export D=\$(echo "$popD")

    # Loop through combinations
    for i in \${A}; do
        for j in \${B}; do
            for k in \${C}; do
                for l in \${D}; do
                    if [[ "\${i}" != "\${j}" && "\${i}" != "\${k}" && "\${i}" != "\${l}" && "\${j}" != "\${k}" && "\${j}" != "\${l}" && "\${k}" != "\${l}" ]]; then
                        echo -e "\${i}\t\${j}\t\${k}\t\${l}"
                    fi
                done
            done
        done
    done > "${prefix}.ftest.tmp"

    Rscript --vanilla $projectDir/docs/combinations.R "${prefix}.ftest.tmp" && rm "${prefix}.ftest.tmp"

    """
}