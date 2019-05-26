

rule assemble_reads_with_megahit:
    input:
        reads1 = getOriginResultFiles(config, "raw_short_read_dna", "read1"),
        reads2 = getOriginResultFiles(config, "raw_short_read_dna", "read2"),
    output:
        contigs = config['megahit_assembly']['contigs'],
    params:
        exc = config['megahit_assembly']['exc']['filepath'],
    threads: int(config['megahit_assembly']['threads'])
    resources:
        time = int(config['megahit_assembly']['time']),
        n_gb_ram = int(config['megahit_assembly']['mem'])
    run:
        cmd = (
            '{params.exc} '
            '-1 {input.read1} '
            '-2 {input.read2} '
            '-t {threads} '
            '-m 0.95 -o $O --kmin-1pass; '
            'mv '
        )
        shell(cmd)
