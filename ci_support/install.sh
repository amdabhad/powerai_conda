# Install miniconda
sudo apt-get update

arch=`uname -m`
recipe_dir=$1

echo "AMOL: arch: $arch"
echo "AMOL: OS:"
cat /etc/os-release

if [[ "$TRAVIS_PYTHON_VERSION" == "2.7" ]]; then
    wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-${arch}.sh -O miniconda.sh;
else
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-${arch}.sh -O miniconda.sh;
fi
chmod +x miniconda.sh 
bash miniconda.sh -b -p $HOME/miniconda
export PATH="$HOME/miniconda/bin:$PATH"
echo 'PATH =' $PATH
conda config --set always_yes yes
conda info -a

# Install conda build
conda install conda-build

# Install lftp
sudo apt-get install lftp

# Build conda package
cd conda-recipes/${recipe_dir}
conda build .