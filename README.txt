# Repo for Spacegraphcats testing with yeast samples

Subset of Wildtype and Mutant (SNF2) Saccharomyces cerevisiae from Schurch et al., 2016


Install snakemake and spacegraphcats:
```
pip install spacegraphcats snakemake
```

Grab this repo:
```
git clone https://github.com/bluegenes/sgc-rna-testing
```

Download the reads:
```
snakemake -s download_ktrim.snakefile
```

Build cDBG, CAtlas from the reference trancriptome and chosed reads

```
snakemake -s build_search.snakefile ref reads 
```
