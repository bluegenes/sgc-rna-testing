# Testing sgc & RNA


    
1. NBHDs == genes? (How good do the neighborhoods look? Are they single-gene? Or do you have multiple genes in same neighborhood?)
    A. Extract gene nbhds, start with a few genes for testing:
        - extract nbhd's using these genes
        - do we get same nbhd using a single isoform vs many isoforms?
          --> use diff isoforms to extract nbhds, compare overlap?
        - 1 annotation per nbhd? Or did we extract anything extra?
             [--> extract reads in each nbhd, assembly, annotate]
        - automate to test all genes
        - test with reads from diff species? [ ** how does % sequence divergence affect neighborhoods?**]

2. Reads vs Reference: What is new/missing in ref?
    [Can we use sgc to improve txome references?]
    - do a neighborhood-aware kmer comparisons
	- component/gene that’s far from the existing assembly & totally uncovered by the assembly (new gene, not isoform), or if closer, likely isoform


Main questions (practical):
   - joint cDBG vs reads-only vs ref cDBGs?
   -  what is completely novel/ uncovered by ref cDBG: extract_unassembled using reads vs ref cDBG
   - extract_unassembled has a 'query' parameter. How to just get "all unassembled"? --> multiple calls, using single reads file as query?

~~
 metagenomes, txome application:
    - nbhd-based diginorm, variant calling, quantification 
- metagenomes, txome application:
	- strain variation, coverage, etc.
	- most strain var should be in the neighborhood that was covered,
	- stuff that’s not might be novel, you might want to add it/integrate it.
~~

