

rule group_taxonomic_assignments:
    input:
        contigs = config['find_homologous_contigs']['strain_contigs'],
        alignment = config['align_to_nt']['alignment'],
    output:
        taxa_ids = config['group_assignments']['taxa_ids'],
    params:
        exc = config['gimmebio']['exc']['filepath'],
    run:
        cmd = (
            '{params.exc} '
            'assembly id-contigs '
            '--winner-takes-all '
            '-f {input.contigs} '
            '{input.alignment} '
            '{output.taxa_ids} '
        )
        shell(cmd)
