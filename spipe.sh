#Reading in the low-coverage sequencing fastqc files form Kim to xeon. 
#Files stored: /data2/hanna/MultiSpeciesComp
#Working on xeon since spipe is installed here. 

singularity shell --bind /data2:/mnt parse_single_cell.1.0.6p.sif
PATH="/share/miniconda/bin:/share/miniconda/envs/spipe/bin:$PATH"

#making combined reference genome 
path2data="/mnt/hanna/MultiSpeciesComp/newvolume"
nohup split-pipe \
--mode mkref \
--genome_name GRCh38 \
--fasta $path2data/genomes/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
--genes $path2data/genomes/Homo_sapiens.GRCh38.112.gtf.gz \
--output_dir $path2data/genomes/GRCh38 &

nohup split-pipe \
--mode mkref \
--genome_name GRCm39 \
--fasta $path2data/genomes/Mus_musculus.GRCm39.dna.primary_assembly.fa \
--genes $path2data/genomes/Mus_musculus.GRCm39.112.gtf \
--output_dir $path2data/genomes/GRCm39 &

nohup split-pipe \
--mode mkref \
--genome_name PanTro3 \
--fasta $path2data/genomes/Pan_troglodytes.Pan_tro_3.0.dna.toplevel.fa \
--genes $path2data/genomes/Pan_troglodytes.Pan_tro_3.0.112.gtf \
--output_dir $path2data/genomes/PanTro3 &

nohup split-pipe \
--mode mkref \
--genome_name GorGor4 \
--fasta $path2data/genomes/Gorilla_gorilla.gorGor4.dna.toplevel.fa \
--genes $path2data/genomes/Gorilla_gorilla.gorGor4.112.gtf \
--output_dir $path2data/genomes/GorGor4 &

nohup split-pipe \
--mode mkref \
--genome_name MacFas6 \
--fasta $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.dna.toplevel.fa \
--genes $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.112.gtf \
--output_dir $path2data/genomes/MacFas6 &

# #downloading new primate genome assemblies from Telomere-to-Telomere Consortium (TTC)
# nohup split-pipe \
# --mode mkref \
# --genome_name PanTro3TTC\
# --fasta $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.fa.gz \
# --genes $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.gtf.gz  \
# --output_dir $path2data/genomes/PanTro3TTC &

# #downloading new primate genome assemblies from Telomere-to-Telomere Consortium
# nohup split-pipe \
# --mode mkref \
# --genome_name GorGor1_TTC\
# --fasta $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.fna.gz \
# --genes $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.gtf.gz   \
# --output_dir $path2data/genomes/GorGor1_TTC &

#making mixed reference genome (ENSEMBLE based)
nohup split-pipe \
--mode mkref \
--genome_name GRCh38 PanTro3 GorGor4 MacFas6 GRCm39\
--fasta $path2data/genomes/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz $path2data/genomes/Pan_troglodytes.Pan_tro_3.0.dna.toplevel.fa $path2data/genomes/Gorilla_gorilla.gorGor4.dna.toplevel.fa $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.dna.toplevel.fa $path2data/genomes/Mus_musculus.GRCm39.dna.primary_assembly.fa \
--genes $path2data/genomes/Homo_sapiens.GRCh38.112.gtf.gz $path2data/genomes/Pan_troglodytes.Pan_tro_3.0.112.gtf  $path2data/genomes/Gorilla_gorilla.gorGor4.112.gtf $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.112.gtf  $path2data/genomes/Mus_musculus.GRCm39.112.gtf \
--output_dir $path2data/genomes/ensemble_mixed_ref &

# #making mixed reference genome (including TTC)
# nohup split-pipe \
# --mode mkref \
# --genome_name GRCh38 PanTro3_TTC GorGor1_TTC MacFas6 GRCm39\
# --fasta $path2data/genomes/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.fna.gz $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.fna.gz $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.dna.toplevel.fa $path2data/genomes/Mus_musculus.GRCm39.dna.primary_assembly.fa \
# --genes $path2data/genomes/Homo_sapiens.GRCh38.112.gtf.gz $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.gtf.gz $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.gtf.gz $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.112.gtf  $path2data/genomes/Mus_musculus.GRCm39.112.gtf.gz \
# --output_dir $path2data/genomes/ensemble_ttc_mixed_ref &

