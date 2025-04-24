nextflow run -config /public/singularity/containers/nextflow/lmb-nextflow/genomes.config,/public/singularity/containers/nextflow/ParseNIP/nextflow.config \
-profile lmb_cluster /public/singularity/containers/nextflow/ParseNIP/main.nf \
--genome_dir /cephfs2/hannas/MultiSpeciesComp/final/genome/GENOME_INDEX \
--samp_list /cephfs2/hannas/MultiSpeciesComp/final/expdata/pipeline_Parse_np/SampleLoadingTable_MultiSpieciesComp.txt \
--fastq /cephfs2/hannas/MultiSpeciesComp/final/expdata/FASTQ --chemistry v1 --concatenate -bg

screen -S spipe_processing_24

srun -c 32 --mem=100G --pty bash
singularity shell --bind /cephfs/swingett/hania/making_multispecies_genome/results/:/srv,$PWD:/mnt /public/singularity/containers/nextflow/pbp_v0.2.sif

nohup split-pipe \
    --mode all \
    --chemistry v1 \
    --genome_dir /srv/GENOME_INDEX \
    --fq1 /mnt/SLX-25498.ParseWT21.22K75GLT4.r_1.fq.gz \
    --fq2 /mnt/SLX-25498.ParseWT21.22K75GLT4.r_2.fq.gz \
    --output_dir output \
    --samp_list /mnt/SampleLoadingTable_MultiSpieciesComp.txt > log_parse.out &


#to adress the multimapping question I will rerun the pipeline with jsut the human reference genome
cd /cephfs2/hannas/MultiSpeciesComp/final/expdata/parsnip_only_human_ref

nextflow run -config /public/singularity/containers/nextflow/lmb-nextflow/genomes.config,/public/singularity/containers/nextflow/ParseNIP/nextflow.config \
-profile lmb_cluster /public/singularity/containers/nextflow/ParseNIP/main.nf \ 
--genome homo_sapiens.GRCh38.release_102 --genome_name homo_sapiens.GRCh38.release_102 \
--samp_list /cephfs2/hannas/MultiSpeciesComp/final/expdata/parsnip_only_human_ref/SampleLoadingTable_MultiSpieciesComp.txt \
--fastq /cephfs2/hannas/MultiSpeciesComp/final/expdata/FASTQ --chemistry v1 --concatenate -bg
