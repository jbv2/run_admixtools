process MAKE_COMBINATIONS {
    tag "$meta.id"
    label 'process_single'

    input:
    tuple val(meta), val(popA), val(popB). val(popC), val(popD)
    file poplistFile
    
    output:
    tuple val(meta), path("*combinations.txt"),   emit: txt

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"

    """
    export A=$(echo "$popA")
    export B=$(echo "$popB")
    export C=$(echo "$popC")
    export D=$(echo "$popD")

    for i in ${C}; do 
        for j in $D; do
            if [ "$i" != "$j" ]; then
            echo -e "$A\t$B\t$i\t$j"
            fi
        done < 
    done > ${prefix}.combinations.txt

    """
}