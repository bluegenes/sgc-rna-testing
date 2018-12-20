# Snakefile for yeast RNAseq testing
import sys
from os.path import join
import yaml
import pandas as pd
from spacegraphcats.snakemake import (catlas_build, catlas_search,
                                      catlas_extract, catlas_search_input, catlas_search_dir)

configfile: 'yeast_mini.yaml' #'yeast_reads.yaml'
SAMPLES = pd.read_table(config["samples"],dtype=str).set_index(["sample_alias"], drop=False)
SAMPLE_NAMES = SAMPLES['sample_alias'].tolist()
DATA_DIR = 'data'
REF = config['reference'] 

def write_yaml(yamlD, paramsfile):
    with open(paramsfile, 'w') as p:
        yaml.dump(yamlD, stream=p, indent=2,  default_flow_style=False)

# build spacegraphcats vars from the tsv file
config['reads'] = [join(DATA_DIR, s + '.khmer.fq.gz') for s in SAMPLES['sample_alias'].tolist()]

config['input_sequences'] = config['reads'] + config['reference']

if not config.get('search'):
    config['search'] = config['input_sequences'] + config['genes']
config['catlas_base'] = config['catlas_base'] + '_joint'
BASE = config['catlas_base']
sgc_config_file = '.yeast_minijoint.yaml'
write_yaml(config, sgc_config_file)

rule joint_catlas:
    input: catlas_extract(sgc_config_file),

rule build:
    input:
        config['input_sequences'] 
    output:
        catlas_build(sgc_config_file)
    shell:
        "{sys.executable} -m spacegraphcats {sgc_config_file} build --nolock"

rule search:
    input:
        catlas_search_input(sgc_config_file),
        catlas_build(sgc_config_file),
    output:
        catlas_search(sgc_config_file)
    shell:
        "{sys.executable} -m spacegraphcats {sgc_config_file} search --nolock"

rule extract:
    input:
        catlas_search(sgc_config_file),
    output:
        catlas_extract(sgc_config_file),
    shell:
        "{sys.executable} -m spacegraphcats {sgc_config_file} extract_reads extract_contigs --nolock"


rule donuts:
    input: [join(catlas_search_dir(sgc_config_file), s + '.khmer.fq.gz_ref.donut.fa') for s in SAMPLE_NAMES]

rule subtract_refmatches:
    input:
        catlas_search(sgc_config_file),
        ref = config['reference'],
        reads = config['reads'],
    output: [join(catlas_search_dir(sgc_config_file), s + '.khmer.fq.gz_ref.donut.fa') for s in SAMPLE_NAMES] #SAMPLES['sample_alias'].tolist()]
    shell:
        #"{sys.executable} -m spacegraphcats.search.make_donut --query {input.reads} --subtract {input.ref} -k 31 -o '_ref.donut.fa' "
        "{sys.executable} make_donut.py --query {input.reads} --subtract {input.ref} -k 31 -o '_ref.donut.fa' "

rule extract_unassembled:
    input: 
        catlas_search(sgc_config_file),
        reads = config['reads'],
    output: join(catlas_search_dir(sgc_config_file), 'unassembled.fa')
    shell:
        "{sys.executable} -m spacegraphcats.search.extract_unassembled_nodes --catlas_prefix {BASE} --query {input.reads} --output {output} " 


