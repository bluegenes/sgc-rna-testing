# Testing sgc & RNA


    
1. NBHDs == genes? 
_How good do the neighborhoods look? Are they single-gene? Or do you have multiple genes in same neighborhood?_

    A. Extract gene nbhds, start with a few genes for testing:
        
	- extract nbhd's using these genes
        - do we get same nbhd using a single isoform vs many isoforms?
          --> use diff isoforms to extract nbhds, compare overlap?
        - 1 annotation per nbhd? Or did we extract anything extra?
             [--> extract reads in each nbhd, assembly, annotate]
        - automate to test all genes
        - test with reads from diff species? [ ** how does % sequence divergence affect neighborhoods?**]

2. Reads vs Reference: What is new/missing in ref?
_Can we use sgc to improve txome references?_
    
    -  Neighborhood-aware kmer comparisons
     	- find completely unassembled regions
	  - unassembled regions w/in covered nbhds = new isoforms?
	  - nbhds/ regions totally uncovered by existing txome reference = contamination or new genes?
	- find regions v. different between ref and reads


**Main questions (practical):**

- Joint cDBG vs reads-only vs ref cDBGs?
	
	- nbhd_overlap.py needs single cDBG?

- Extracting unassembled regions:
	
	- search ref-only cDBG with reads files --> get novel things in the reads.
	- extract_unassembled has a query param --> this script works in a single-file manner? If yes, grab unassembled from each read:  combine, assemble, investigate?
	
~~

 metagenomes, txome applications:
    
    	- nbhd-based diginorm, variant calling, quantification 
	- strain variation, coverage, etc.
	- most strain var should be in the neighborhood that was covered,
	- stuff that’s not might be novel, you might want to add it/integrate it.
~~

