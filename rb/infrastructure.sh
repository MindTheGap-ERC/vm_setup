
# github authentication
# (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) \
# 	&& sudo mkdir -p -m 755 /etc/apt/keyrings \
# 	&& out=$(mktemp) && wget -nv -O$out https://cli.github.com/packages/githubcli-archive-keyring.gpg \
# 	&& cat $out | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
# 	&& sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
# 	&& sudo mkdir -p -m 755 /etc/apt/sources.list.d \
# 	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
# 	&& sudo apt update \
# 	&& sudo apt install gh -y
#   gh auth login

sudo apt install r-base-dev libssl-dev libcurl4-openssl-dev build-essential cmake libboost-all-dev r-base-dev
mkdir -p documents/github/

Rscript r_packages.R

# compile revBayes and add to path
cd ~/documents/github/
git clone --branch development https://github.com/revbayes/revbayes.git revbayes
cd revbayes/projects/cmake
./build.sh
echo 'export PATH="$HOME/documents/github/revbayes/projects/cmake/build:$PATH"' >> ~/.bashrc
source ~/.bashrc

# install conda
cd ~
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh
source ~/.bashrc
conda activate
conda config --set auto_activate_base false
conda deactivate

# install snakemake
cd ~/documents/github
conda create -c conda-forge -c bioconda -n phylostrat snakemake

# install ibridges & connect to yoda
git clone -b switch-to-ibridges https://github.com/qubixes/snakemake-storage-plugin-irods
conda activate phylostrat
cd ~/documents/github/snakemake-storage-plugin-irods
pip install .
cd ~/documents/github/
pip install ibridges-servers-uu
ibridges setup --list
ibridges setup uu-geo
ibridges init
# test connection
ibridges list "irods://nluu11p/home/research-mindthegap"

# get main repo
cd ~/documents/github
git clone https://github.com/MindTheGap-ERC/phylostrat
cd phylostrat

