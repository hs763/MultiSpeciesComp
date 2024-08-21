#Reading in the low-coverage sequencing fastqc files form Kim to xeon. 
#Files stored: /cephfs2/hannas/MultiSpeciesComp/newvolume
#Working on teh cluster. 

conda activate spipe

#making combined reference genome 
path2data="/cephfs2/hannas/MultiSpeciesComp/newvolume"
nohup split-pipe \
--mode mkref \
--genome_name GRCh38 \
--fasta $path2data/genomes/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
--genes $path2data/genomes/Homo_sapiens.GRCh38.112.gtf.gz \
--output_dir $path2data/genomes/GRCh38 &

nohup split-pipe \
--mode mkref \
--genome_name GRCm39 \
--fasta $path2data/genomes/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz \
--genes $path2data/genomes/Mus_musculus.GRCm39.112.gtf.gz \
--output_dir $path2data/genomes/GRCm39 &

nohup split-pipe \
--mode mkref \
--genome_name MacFas6 \
--fasta $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.dna.toplevel.fa.gz \
--genes $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.112.gtf.gz \
--output_dir $path2data/genomes/MacFas6 &

#downloading new primate genome assemblies from Telomere-to-Telomere Consortium (TTC)
# echo "mkref_star_limitGenomeGenerateRAM 41888514314" > $path2data/genomes/parfile.txt
nohup split-pipe \
--mode mkref \
--genome_name PanTro3 \
--fasta $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.fna.gz \
--genes $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.gtf.gz \
--output_dir $path2data/genomes/PanTro3 &

# #downloading new primate genome assemblies from Telomere-to-Telomere Consortium
# echo "mkref_star_limitGenomeGenerateRAM 41888514314" > $path2data/genomes/parfile.txt
nohup split-pipe \
--mode mkref \
--genome_name GorGor1 \
--fasta $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.fna.gz \
--genes $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.gtf.gz \
--output_dir $path2data/genomes/GorGor1 &

echo "mkref_star_limitGenomeGenerateRAM 41888514314" > $path2data/genomes/parfile.txt
split-pipe \
--mode mkref \
--parfile $path2data/genomes/parfile.txt \
--genome_name GRCh38 PanTro3_TTC GorGor1_TTC MacFas6 GRCm39 \
--fasta $path2data/genomes/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.fna.gz $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.fna.gz $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.dna.toplevel.fa.gz $path2data/genomes/Mus_musculus.GRCm39.dna.primary_assembly.fa.gz \
--genes $path2data/genomes/Homo_sapiens.GRCh38.112.gtf.gz $path2data/genomes/GCF_028858775.2_NHGRI_mPanTro3-v2.0_pri_genomic.gtf.gz $path2data/genomes/GCF_029281585.2_NHGRI_mGorGor1-v2.0_pri_genomic.gtf.gz $path2data/genomes/Macaca_fascicularis.Macaca_fascicularis_6.0.112.gtf.gz $path2data/genomes/Mus_musculus.GRCm39.112.gtf.gz \
--output_dir $path2data/genomes/ensemble_ttc_ref 
--star_opts "--limitSjdbInsertNsj 1490662"

#runign as a job
sbatch -J individual_genomes -c 2 --mail-type=ALL --mail-user=hannas@mrc-lmb.cam.ac.uk --mem=300G individual_genomes.sh

sbatch -J comb_genome -c 2 --mail-type=ALL --mail-user=hannas@mrc-lmb.cam.ac.uk --mem=300G comb_genome.sh
#5060150


#runing spipe for all the libraries individually
path2data="/cephfs2/hannas/MultiSpeciesComp/newvolume"
echo "fastq_samp_slice 100000 865836" > $path2data/expdata/parfile.txt
split-pipe --mode all --parfile $path2data/expdata/parfile.txt --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_1_S81_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_1_S81_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib1_A5

path2data="/cephfs2/hannas/MultiSpeciesComp/newvolume"
split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_2_S82_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_2_S82_R2_001.fastq.gz \
--output_dir $path2data/analysis/indiv_sublib/sublib2_B5

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_3_S83_R1_001.fastq.gz  \
--fq2 $path2data/expdata/Hania_3_S83_R2_001.fastq.gz  \
--output_dir $path2data/analysis/indiv_sublib/sublib3_C5

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_3_S83_R1_001.fastq.gz  \
--fq2 $path2data/expdata/Hania_3_S83_R2_001.fastq.gz  \
--output_dir $path2data/analysis/indiv_sublib/sublib3_C5

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_4_S84_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_4_S84_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib4_D5

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_5_S85_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_5_S85_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib5_E5

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_6_S86_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_6_S86_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib6_F6

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_7_S87_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_7_S87_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib7_G5

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_8_S88_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_8_S88_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib8_H5

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_9_S89_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_9_S89_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib9_E3

split-pipe --mode all --kit WT_mega --chemistry v1 --kit_score_skip \
--genome_dir $path2data/genomes/ensemble_ttc_ref/ \
--fq1 $path2data/expdata/Hania_10_S90_R1_001.fastq.gz \
--fq2 $path2data/expdata/Hania_10_S90_R2_001.fastq.gz \
--output_dir $path2data/analysis/sublib10_F3


split-pipe --mode comb \
    --sublibraries $path2data/analysis/sublib10_F3 $path2data/analysis/sublib9_E3 $path2data/analysis/sublib8_H5 $path2data/analysis/sublib7_G5 $path2data/analysis/sublib6_F6 $path2data/analysis/sublib5_E5 $path2data/analysis/sublib3_C5 $path2data/analysis/sublib2_B5 $path2data/analysis/sublib1_A5 \
    --output_dir $path2data/analysis/combined

