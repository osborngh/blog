#!/bin/bash

echo "Updating Site"

git add .
git commit -m "$1"

git push origin main

echo "Finished Updating Site"
