

rule assemble_reads_with_metaspades:
    input:
        reads1 = getOriginResultFiles(config, "filter_human_dna", "nonhuman_read1"),
        reads2 = getOriginResultFiles(config, "filter_human_dna", "nonhuman_read2")
    output:
        agraph = config['metaspades_read_assembly']['assembly_graph'],
        contigs = config['metaspades_read_assembly']['fasta'],
        pecontigs = config['metaspades_read_assembly']['first_pe_contigs'],
        params = config['metaspades_read_assembly']['params'],
        beforerr = config['metaspades_read_assembly']['before_rr'],
        contig_paths = config['metaspades_read_assembly']['contig_paths'],
        dataset_info = config['metaspades_read_assembly']['dataset_info'],
        input_dataset = config['metaspades_read_assembly']['input_dataset'],
        scaffolds = config['metaspades_read_assembly']['scaffolds'],
        scaffold_paths = config['metaspades_read_assembly']['scaffold_paths'],
        log = config['metaspades_read_assembly']['log']
    params:
        exc = config['metaspades_read_assembly']['exc']['filepath']
        dirname = 'temp_{sample_name}'
    threads: int(config['metaspades_read_assembly']['threads'])
    resources:
        time = int(config['metaspades_read_assembly']['time']),
        n_gb_ram = int(config['metaspades_read_assembly']['ram'])
    run:
        cmd = ('{params.exc} '
               '-1 {input.reads1} '
               '-2 {input.reads2} '
               '-t {threads} '
               '-m {resources.n_gb_ram} '
               '-o {params.dirname} '
               '; '
               'mv {params.dirname}/assembly_graph.fastg {output.agraph}; '
               'mv {params.dirname}/contigs.fasta {output.contigs}; '
               'mv {params.dirname}/first_pe_contigs.fasta {output.pecontigs}; '
               'mv {params.dirname}/params.txt {output.params}; '
               'mv {params.dirname}/before_rr.fasta {output.beforerr}; '
               'mv {params.dirname}/contigs.paths {output.contig_paths}; '
               'mv {params.dirname}/dataset.info {output.dataset_info}; '
               'mv {params.dirname}/input_dataset.yaml {output.input_dataset}; '
               'mv {params.dirname}/scaffolds.fasta {output.scaffolds}; '
               'mv {params.dirname}/scaffolds.paths {output.scaffold_paths}; '
               'mv {params.dirname}/spades.log {output.log}; '
               )
        shell(cmd)
