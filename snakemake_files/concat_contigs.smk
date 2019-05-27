

rule concat_contigs:
    input:
        contigs = expandGroup(config['megahit_assembly']['contigs'])
    output:
        contigs = config['concat_contigs']['contigs'],
    params:
        exc = config['gimmebio']['exc']['filepath'],
        min_length = int(config['concat_contigs']['min_length'])
    run:
       cmd = (
            '{params.exc} '
            'assembly cat-fastas '
            '-l {params.min_length} '
            '{output.contigs} '
        ) + ' '.join(input)
        shell(cmd)
