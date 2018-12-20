# Snakefile for yeast RNAseq testing
import sys
from os.path import join
import yaml
import pandas as pd
from spacegraphcats.snakemake import (catlas_build, catlas_search,
                                      catlas_extract, catlas_search_input)

configfile: 'yeast_mini.yaml' #'yeast_reads.yaml'
SAMPLES = pd.read_table(config["samples"],dtype=str).set_index(["sample_alias"], drop=False)
DATA_DIR = 'data'
REF = 'GCF_000146045.2_R64_rna.fna.gz'

def write_yaml(yamlD, paramsfile):
    with open(paramsfile, 'w') as p:
        yaml.dump(yamlD, stream=p, indent=2,  default_flow_style=False)

# build spacegraphcats vars from the tsv file
config['input_sequences'] = [join(DATA_DIR, s + '.khmer.fq.gz') for s in SAMPLES['sample_alias'].tolist()]

config['search'] = config['input_sequences'] + ["data/GCF_000146045.2_R64_rna.fna.gz"]
base = config['catlas_base']
config['catlas_base'] = base + '_reads'
sgc_config_file = 'yeastReads_sgc.yaml'
write_yaml(config, sgc_config_file)

ref_config_file = 'yeastRef_sgc.yaml'
ref_config = config
ref_config['input_sequences'] = join(DATA_DIR, REF) 
ref_config['catlas_base'] = base + '_ref'
write_yaml(ref_config, ref_config_file)

rule reads:
    input:
        catlas_search(sgc_config_file),

rule ref:
    input: catlas_search(ref_config_file)

rule build_reads:
    input:
        config['input_sequences'] 
    output:
        catlas_build(sgc_config_file)
    shell:
        "{sys.executable} -m spacegraphcats {sgc_config_file} build --nolock"

rule build_ref:
    input:
        join(DATA_DIR, REF) 
    output:
        catlas_build(ref_config_file)
    shell:
        "{sys.executable} -m spacegraphcats {ref_config_file} build --nolock"

rule search_reads:
    input:
        catlas_search_input(sgc_config_file),
        catlas_build(sgc_config_file),
    output:
        catlas_search(sgc_config_file)
    shell:
        "{sys.executable} -m spacegraphcats {sgc_config_file} search --nolock"

rule search_ref:
    input:
        catlas_search_input(ref_config_file),
        catlas_build(ref_config_file),
    output:
        catlas_search(ref_config_file)
    shell:
        "{sys.executable} -m spacegraphcats {ref_config_file} search --nolock"

