#!/bin/bash

# Directory to store Singularity images
IMAGES_DIR="images"

# Create the directory if it doesn't exist
if [ ! -d "$IMAGES_DIR" ]; then
    echo "Creating directory: $IMAGES_DIR"
    mkdir -p "$IMAGES_DIR"
else
    echo "Directory $IMAGES_DIR already exists."
fi

# List of Docker to Singularity image conversions
declare -A IMAGES
IMAGES=(
    ["nanoclust-consensus_classification"]="hecrp/nanoclust-consensus_classification"
    ["nanoclust-demultiplex"]="hecrp/nanoclust-demultiplex"
    ["nanoclust-demultiplex_porechop"]="hecrp/nanoclust-demultiplex_porechop"
    ["nanoclust-draft_selection"]="hecrp/nanoclust-draft_selection"
    ["nanoclust-fastqc"]="hecrp/nanoclust-fastqc"
    ["nanoclust-kmer_freqs"]="hecrp/nanoclust-kmer_freqs"
    ["nanoclust-medaka_pass"]="hecrp/nanoclust-medaka_pass"
    ["nanoclust-output_documentation"]="hecrp/nanoclust-output_documentation"
    ["nanoclust-plot_abundances"]="hecrp/nanoclust-plot_abundances"
    ["nanoclust-qc"]="hecrp/nanoclust-qc"
    ["nanoclust-racon_pass"]="hecrp/nanoclust-racon_pass"
    ["nanoclust-read_clustering"]="hecrp/nanoclust-read_clustering"
    ["nanoclust-read_correction"]="hecrp/nanoclust-read_correction"
    ["nanoclust-split_by_cluster"]="hecrp/nanoclust-split_by_cluster"
    ["ncbi-blast"]="ncbi/blast:latest"
)

# Loop through images and build if not already present
for IMAGE_NAME in "${!IMAGES[@]}"; do
    SIF_PATH="$IMAGES_DIR/$IMAGE_NAME.sif"
    DOCKER_PATH="docker://${IMAGES[$IMAGE_NAME]}"
    
    if [ -f "$SIF_PATH" ]; then
        echo "Image $SIF_PATH already exists. Skipping..."
    else
        echo "Building $SIF_PATH from $DOCKER_PATH..."
        singularity build "$SIF_PATH" "$DOCKER_PATH"
        if [ $? -ne 0 ]; then
            echo "Error building $SIF_PATH. Exiting..."
            exit 1
        fi
    fi
done

echo "All images are up to date."

