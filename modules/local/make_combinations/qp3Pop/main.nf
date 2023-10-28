process MAKE_COMBINATIONS_qp3Pop {
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

    # Loop through combinations
    for i in "\${A}"; do
        for j in "\${B}"; do
            for k in "\${C}"; do
                if [[ "\$i" != "\$j" && "\$i" != "\$k" && "\$j" != "\$k" ]]; then
                    echo -e "\$i\t\$j\t\$k"
                fi
            done
        done
    done > "${prefix}.ftest.txt"
    """
}