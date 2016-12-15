#!/bin/bash

# Install all the packages I use for most development tasks
echo "Installing basic software for apnorton"
echo "Categories of installation:"
echo "  - Basic Editing"
echo "  - Python3 packages"
echo "  - GCC tools"
echo "  - Sun/Oracle Java"
echo "  - LaTeX and content generation"
echo "  - git configuration"

# Basic editing
echo "Installing vim"
sudo apt-get install vim

# Python3: install pip and some default packages
echo "Installing pip and associated packages"
sudo apt-get install python3-pip
sudo -H pip3 install --upgrade pip
sudo -H pip3 install numpy
sudo -H pip3 install scipy 
sudo -H pip3 install matplotlib
sudo -H pip3 install sklearn
sudo -H pip3 install pandas
sudo -H pip3 install jupyter

# GCC Tools
git clone https://github.com/longld/peda.git ~/peda
echo "source ~/peda/peda.py" >> ~/.gdbinit
echo "DONE! debug your program with gdb and enjoy"

# Java
# Using http://askubuntu.com/a/55960/135770
echo "Download the most recent JDK here and save as jdk.tar.gz in the current directory:"
echo "http://www.oracle.com/technetwork/java/javase/downloads/index.html"
read -n 1 -p "Press key when finished..." key

if [ -f jdk.tar.gz ]; then
  echo "Found archive. Extracting..."
  tar -xf jdk.tar.gz
  mv jdk1.8* jdk1.8

  sudo mkdir -p /usr/lib/jvm/
  sudo mv ./jdk1.8 /usr/lib/jvm

  sudo update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8/bin/java" 1
  sudo update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8/bin/javac" 1
  sudo update-alternatives --install "/usr/bin/javadoc" "javadoc" "/usr/lib/jvm/jdk1.8/bin/javadoc" 1
  sudo update-alternatives --install "/usr/bin/javaws" "javaws" "/usr/lib/jvm/jdk1.8/bin/javaws" 1

  sudo chmod a+x /usr/bin/java
  sudo chmod a+x /usr/bin/javac
  sudo chmod a+x /usr/bin/javaws
  sudo chmod a+x /usr/bin/javadoc
  sudo chown -R root:root /usr/lib/jvm/jdk1.8

  sudo update-alternatives --config java
  echo "Done installing Java"
  rm -rf jdk.tar.gz
else
  echo "Archive not found; skipping Java installation..."
fi

# LaTeX and displaying things
sudo apt-get install texlive-full
sudo apt-get install graphviz

# git setup
echo "Installing git..."
sudo apt-get install git
echo "Configuring git..."
git config --global user.name "Andrew Norton"
git config --global user.email "hskrus@gmail.com"
echo "Generating ssh keys..."
ssh-keygen -t rsa -b 4096 -C "hskrus@gmail.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa


