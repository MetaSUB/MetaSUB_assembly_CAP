from moduleultra.pipeline_config_utils import *
from packagemega import Repo as PMRepo
from packagemega.mini_language import processOperand
from sys import stderr

pipeDir = fromPipelineDir('')
pmrepo = PMRepo.loadRepo()


def scriptDir(fpath):
    dname = pipeDir + '/scripts/'
    return dname + fpath


def pmegaDB(operand):
    try:
        res = processOperand(pmrepo, operand, stringify=True)
    except KeyError:
        stderr.write('[packagemega] {} not found.\n'.format(operand))
        res = ''
    return res


def which(tool):
    cmd = 'which {}'.format(tool)
    return resolveCmd(cmd)


config = {
    'microbe_census': {
        'threads': 6,
        'time': 4,
        'ram': 10,
        'exc': {
            'filepath': which('run_microbe_census.py'),
            'version': resolveCmd('run_microbe_census.py --version 2>&1')
        }
    }
}
