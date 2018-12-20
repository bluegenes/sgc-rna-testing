# Repo for Spacegraphcats testing with yeast samples

Subset of Wildtype and Mutant (SNF2) Saccharomyces cerevisiae from [Schurch et al., 2016](http://rnajournal.cshlp.org/content/early/2016/03/30/rna.053959.115.full.pdf)


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

build & search with ref, reads 

```
snakemake -s build_search.snakefile ref reads 
```
