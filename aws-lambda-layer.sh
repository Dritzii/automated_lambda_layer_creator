#!/bin/bash

echo What python version are you looking for?

read -p 'Python Version default 3.12' pythonVersion

echo Selected Version $varname
# Check folder structure

if test -d /python/lib/python$pythonVersion/site-packages/; then
	echo "Directory Exists Continuing"
else
	echo "Directory does not exist - Creating Folder Dir now"
	mkdir -p python/lib/python$pythonVersion/site-packages

fi


# Run Docker Command
sudo docker run -v "$PWD":/var/task "public.ecr.aws/sam/build-python$pythonVersion" /bin/sh -c "pip install -r requirements.txt -t python/lib/python$pythonVersion/site-packages/; exit"


echo zipping folder and removing original folder 

read -p 'What zip folder name would you like?  ' zipfilename

zip -r $zipfilename python

echo Deleting python folder

rm -rf python
