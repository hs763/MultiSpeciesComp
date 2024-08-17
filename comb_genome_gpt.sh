#!/bin/bash

# Activate the conda environment
source /lmb/home/hannas/miniconda3/etc/profile.d/conda.sh
conda activate spipe

# Define the path to the data
path2data="/cephfs2/hannas/MultiSpeciesComp/newvolume"

# Create a parameter file for split-pipe
echo "mkref_star_limitGenomeGenerateRAM 41888514314" > $path2data/genomes/parfile.txt

# Run the split-pipe command
split-pipe \
  --mode mkref \
  --parfile $path2data/genomes/parfile.txt \
  --genome_name "GRCh38 PanTro3_TTC GorGor1_TTC MacFas6 GRCm39" \
  --fasta $path2data/genomes/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
  $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.fna.gz \
  $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.fna.gz \
  $path2data/genomes/MacFas6_genomic.fna.gz \
  $path2data/genomes/GRCm39_genomic.fna.gz \
  --genes $path2data/genomes/Homo_sapiens.GRCh38.112.gtf.gz \
  $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.gtf.gz \
  $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.gtf.gz \
  $path2data/genomes/MacFas6_genomic.gtf.gz \
  $path2data/genomes/GRCm39_genomic.gtf.gz \
  --output_dir $path2data/genomes/ensemble_ttc_ref
