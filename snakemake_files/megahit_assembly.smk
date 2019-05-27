

rule assemble_reads_with_megahit:
    input:
        reads1 = getOriginResultFiles(config, "raw_short_read_dna", "read1"),
        reads2 = getOriginResultFiles(config, "raw_short_read_dna", "read2"),
    output:
        contigs = config['megahit_assembly']['contigs'],
    params:
        exc = config['megahit_assembly']['exc']['filepath'],
        sample_name = '{sample_name}'	
    threads: int(config['megahit_assembly']['threads'])
    resources:
        time = int(config['megahit_assembly']['time']),
        n_gb_ram = int(config['megahit_assembly']['mem'])
    run:
        odir = params.sample_name + '/' + params.sample_name + '_megahit_assembly'	
        cmd = (
            '{params.exc} '
            '-1 {input.reads1} '
            '-2 {input.reads2} '
            '-t {threads} '
            '-m 0.95 -o ' + odir + ' --kmin-1pass && '
            'mv ' + odir + '/final.contigs.fa {output.contigs} && '
            'rm -r ' + odir
        )
        shell(cmd)
