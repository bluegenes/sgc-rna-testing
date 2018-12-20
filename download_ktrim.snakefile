# Snakefile for yeast RNAseq testing
import sys
from os.path import join
import pandas as pd

from snakemake.remote import HTTP
HTTP = HTTP.RemoteProvider()


configfile: 'yeast_mini.yaml'

SAMPLES = pd.read_table(config["samples"],dtype=str).set_index(["sample_alias"], drop=False)
DATA_DIR = 'data'
REF = join(DATA_DIR, "GCF_000146045.2_R64_rna.fna.gz")
targs= [join(DATA_DIR, s + '.khmer.fq.gz') for s in SAMPLES['sample_alias'].tolist()]

rule download:
    input: targs, REF

# download S. cerevisiae RNA reference
rule download_rna_reference:
    output: REF 
    shell:
    	#"curl -o {output} -L 'https://osf.io/97vzd/?action=download'"
    	"curl -o {output} -L 'ftp://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/000/146/045/GCF_000146045.2_R64/GCF_000146045.2_R64_rna.fna.gz'"

rule get_fq:
    input: lambda wildcards: HTTP.remote(f"https://osf.io/{SAMPLES.loc[(wildcards.sample),'osf_id']}/download", allow_redirects=True)
    #"{}".format(samples.loc[(wildcards.sample), "osf_id"]), static=True, keep_local=True, immediate_close=True)
    output: join(DATA_DIR,"{sample}.khmer.fq.gz")
    shell: "mv {input} {output}"


