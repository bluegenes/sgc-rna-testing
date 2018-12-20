#Tessa Pierce

#Input - fasta file
#Name pattern
#Output - fasta with matching contig names

import argparse
import screed
import re

def extract_contigs(in_fasta,pattern, outF):
    if not outF:
        outF = in_fasta.split('.fa')[0] + '_' + pattern + '.fa'
    with screed.open(in_fasta) as seqF:
        with open(outF, 'w') as o:
            for read in seqF:
                match = re.search(pattern, read.name, re.IGNORECASE)
                if match:
                    o.write('\n'.join(['>' + read.name,read.sequence]) + '\n')

if(__name__=='__main__'):
    parser = argparse.ArgumentParser(description="Create simple BED from fasta")
    parser.add_argument('fasta', help='input fasta file')
    parser.add_argument('--pattern', help='pattern to match')
    parser.add_argument('--out', help='output fasta file', default=None)
    args = parser.parse_args()
    extract_contigs(args.fasta, args.pattern, args.out)
