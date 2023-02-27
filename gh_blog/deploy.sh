#!/bin/bash

echo "Deploying Updates To Github..."

# Build the project
hugo -t archie

# Go To Public Folder
cd public

# Add changes to git
git add .

msg="updating site `date`"

if [ $# -eq 1 ]
	then msg="$1"
fi

git commit -m "$msg"

git push origin main

cd ..

echo "Site Updated Successfully..."
