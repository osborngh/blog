#!/bin/bash

echo "Starting Site Update"

hugo -t archie
cd public
git add .
git commit -m "update blog"
git push origin main

echo "Site Updated Successfully"
