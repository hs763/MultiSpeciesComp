#instaling spipe on the cluster https://support.parsebiosciences.com/hc/en-us/articles/23060102930580-Pipeline-Installation-Current-Version
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh 
bash Miniconda3-latest-Linux-x86_64.sh

#location: /lmb/home/hannas/miniconda3
export PATH="/lmb/home/hannas/miniconda3/bin:$PATH"

conda create -n spipe conda-forge::python==3.10
conda activate spipe

unzip ParseBiosciences-Pipeline.1.3.1.zip 
cd ParseBiosciences-Pipeline.1.3.1
bash ./install_dependencies_conda.sh -i -y
pip install --no-cache-dir ./

split-pipe


#!/bin/bash

# Activate the conda environment
source /lmb/home/hannas/miniconda3/etc/profile.d/conda.sh
conda activate spipe

# Set path to data
path2data="/cephfs2/hannas/MultiSpeciesComp/P1300/newvolume"

# Run split-pipe commands
split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir /cephfs2/hannas/MultiSpeciesComp/low_covereage_seq/newvolume/genom>
--fq1 $path2data/expdata/Hania_1_R_S3_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_1_R_S3_R2_001.fastq.gz \
--output_dir $path2data/analysis/indiv_sublib/sublib1

path2data="/cephfs2/hannas/MultiSpeciesComp/P1300/newvolume"
split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir /cephfs2/hannas/MultiSpeciesComp/low_covereage_seq/newvolume/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_7_R_S4_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_7_R_S4_R2_001.fastq.gz \
--output_dir $path2data/analysis/indiv_sublib/sublib7

sbatch -J individual_genomes -c 6 --mail-type=ALL --mail-user=hannas@mrc-lmb.cam.ac.uk --mem=300G sublib1.sh
sbatch -J individual_genomes -c 6 --mail-type=ALL --mail-user=hannas@mrc-lmb.cam.ac.uk --mem=300G sublib7.sh

------------------------------------------------------------------------------------------------------------------------------
#!/bin/bash

# Activate the conda environment
source /lmb/home/hannas/miniconda3/etc/profile.d/conda.sh
conda activate spipe

# Set path to data
path2data="/cephfs2/hannas/MultiSpeciesComp/P1300/newvolume"

# Run split-pipe commands
split-pipe --mode comb \
    --sublibraries $path2data/analysis/indiv_sublib/sublib1 $path2data/analysis/indiv_sublib/sublib7 \
    --output_dir $path2data/analysis/combined_1_7

sbatch -J individual_genomes -c 6 --mail-type=ALL --mail-user=hannas@mrc-lmb.cam.ac.uk --mem=300G combined_1_7.sh
