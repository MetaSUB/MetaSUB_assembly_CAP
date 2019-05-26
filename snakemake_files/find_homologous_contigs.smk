

rule find_strain_homologous_contigs:
    input:
        contigs = config['megahit_assembly']['contigs'],
        alignment = config['self_align']['alignment'],
    output:
        contigs = config['find_homologous_contigs']['strain_contigs'],
        groups = config['find_homologous_contigs']['strain_groups'],
    params:
        exc = config['gimmebio']['exc']['filepath'],
    threads: int(config['self_align']['threads'])
    resources:
        time = int(config['self_align']['time']),
        n_gb_ram = int(config['self_align']['mem'])
    run:
        cmd = (
            '{params.exc} '
            'assembly filter-homologous '
            '-p 0.99 '
            '-g {output.groups} '
            '{output.contigs} '
            '{input.alignment} '
            '{input.contigs} '
        )
        shell(cmd)


rule find_homologous_contigs:
    input:
        contigs = config['megahit_assembly']['contigs'],
        alignment = config['self_align']['alignment'],
    output:
        contigs = config['find_homologous_contigs']['homology_contigs'],
        groups = config['find_homologous_contigs']['homology_groups'],
    params:
        exc = config['gimmebio']['exc']['filepath'],
    threads: int(config['self_align']['threads'])
    resources:
        time = int(config['self_align']['time']),
        n_gb_ram = int(config['self_align']['mem'])
    run:
        cmd = (
            '{params.exc} '
            'assembly filter-homologous '
            '-p 0.8 '
            '-g {output.groups} '
            '{output.contigs} '
            '{input.alignment} '
            '{input.contigs} '
        )
        shell(cmd)

