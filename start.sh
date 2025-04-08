#!/bin/bash

# Define the folder containing the Kubernetes YAML files
K8S_FOLDER="$(pwd)/infra/K8S"

# Check if the folder exists
if [ ! -d "$K8S_FOLDER" ]; then
  echo "Error: Folder $K8S_FOLDER does not exist."
  exit 1
fi

# Iterate through all YAML files in the folder
for file in "$K8S_FOLDER"/*.yml; do
  if [ -f "$file" ]; then
    echo "Applying $file..."
    kubectl apply -f "$file"
    if [ $? -ne 0 ]; then
      echo "Error applying $file. Exiting."
      exit 1
    fi
  else
    echo "No YAML files found in $K8S_FOLDER."
    exit 1
  fi
done

echo "All files applied successfully."