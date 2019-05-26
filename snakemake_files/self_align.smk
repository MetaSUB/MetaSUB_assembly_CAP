

rule make_self_blastdb:
    input:
        contigs = config['megahit_assembly']['contigs'],
    output:
        blastdb = temp(config['group_name'] + 'self_align.blast_db'),
    params:
        exc = config['blastn']['makedb']['filepath'],
    threads: int(config['self_align']['threads'])
    resources:
        time = int(config['self_align']['time']),
        n_gb_ram = int(config['self_align']['mem'])
    run:
        cmd = (
            '{params.exc} '
            '-dbtype nucl '
            '-in {input.contigs} '
            '-out {output.blastdb} '
        )
        shell(cmd)


rule self_align:
    input:
        contigs = config['megahit_assembly']['contigs'],
        blastdb = config['group_name'] + 'self_align.blast_db',
    output:
        alignment = config['self_align']['alignment']
    params:
        exc = config['blastn']['exc']['filepath'],
    threads: int(config['self_align']['threads'])
    resources:
        time = int(config['self_align']['time']),
        n_gb_ram = int(config['self_align']['mem'])
    run:
        cmd = (
            '{params.exc} '
            '-db {input.blastdb} '
            '-outfmt 6 '
            '-perc_identity 80 '
            '-query {input.contigs} '
            '-num_threads {threads} '
            '> {output.alignment}'
        )
        shell(cmd)
