#!/bin/bash

echo "Starting Site Update"

cd public
git add .
git commit -m "update site"
git push origin main

echo "Site Updated Successfully"
