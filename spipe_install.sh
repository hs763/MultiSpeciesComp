#instaling spipe on the cluster

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

