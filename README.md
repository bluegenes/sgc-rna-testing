# Repo for Spacegraphcats testing with yeast samples

Subset of Wildtype and Mutant (SNF2) Saccharomyces cerevisiae from [Schurch et al., 2016](http://rnajournal.cshlp.org/content/early/2016/03/30/rna.053959.115.full.pdf)


Install snakemake and spacegraphcats:
```
conda create -n spaceCats
source activate spaceCats
pip install Cython
pip install snakemake
pip install https://github.com/dib-lab/pybbhash/archive/spacegraphcats.zip
pip install https://github.com/dib-lab/khmer/archive/master.zip
pip install git+https://github.com/dib-lab/sourmash@master#egg=sourmash

pip install spacegraphcats
```

Grab this repo:
```
git clone https://github.com/bluegenes/sgc-rna-testing
```

Download the reads:
```
cd sgc-rna-testing
snakemake -s download_ktrim.snakefile
```

build & search 

```
snakemake -s joint_catlas.snakefile joint_catlas donuts
```
