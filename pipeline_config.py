from moduleultra.pipeline_config_utils import *
from sys import stderr

PIPE_DIR = fromPipelineDir('')


def scriptDir(fpath):
    dname = PIPE_DIR + '/scripts/'
    return dname + fpath


def which(tool):
    cmd = 'which {}'.format(tool)
    return resolveCmd(cmd)


config = {
    'megahit_assembly': {
        'threads': 16,
        'time': 10,
        'mem': 60,
        'exc': {
            'filepath': which('megahit'),
        }
    },
    'concat_contigs': {
        'min_length': 10 * 1000,
    },
    'self_align': {
        'threads': 16,
        'time': 10,
        'mem': 20,
    },
    'gimmebio': {
        'exc': {'filepath': which('gimmebio')}
    },
    'align_to_nt': {
        'threads': 16,
        'time': 10,
        'mem': 20,
    },
}
