

rule align_to_nt:
    input:
        contigs = config['find_homologous_contigs']['strain_contigs'],
    output:
        alignment = config['align_to_nt']['alignment']
    params:
        exc = config['blastn']['exc']['filepath'],
        db = config['blastn']['nt']['filepath'],
    threads: int(config['self_align']['threads'])
    resources:
        time = int(config['align_to_nt']['time']),
        n_gb_ram = int(config['align_to_nt']['mem'])
    run:
        cmd = (
            '{params.exc} '
            '-db {params.db} '
            '-outfmt 6 '
            '-perc_identity 80 '
            '-query {input.contigs} '
            '-num_threads {threads} '
            '> {output.alignment}'
        )
        shell(cmd)
