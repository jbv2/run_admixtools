process qpDstat {
    tag "$meta.id"
    label 'process_high_memory'

    input:
    tuple val(meta), path(parfile)


    output:
    tuple val(meta), path("*.OUT.log"),   emit: parfile

    when:
    task.ext.when == null || task.ext.when

    script:
    def args = task.ext.args ?: ''
    def prefix = task.ext.prefix ?: "${meta.id}"
    
    def f4 = task.ext.f4mode ?: 'YES'

    """
    # Conditionally set poplistname based on f4mode
    if [ "$f4" == 'YES' ]; then
    $(which qpDstat) -p ./parfile > f4.test.OUT.log
    else 
    $(which qpDstat) -p ./parfile > D.test.OUT.log
    fi
    """
}