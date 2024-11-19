#!/bin/bash

# Create the main database directory
DB_DIR="$(pwd)/db"
TAXDB_DIR="$DB_DIR/taxdb"

# Create directories if they don't exist
echo "Creating directories..."
mkdir -p "$DB_DIR"
mkdir -p "$TAXDB_DIR"

# Change to the main database directory
cd "$DB_DIR" || { echo "Failed to change directory to $DB_DIR"; exit 1; }

# Download and extract the 16S_ribosomal_RNA database
echo "Downloading and extracting 16S_ribosomal_RNA database..."
wget https://ftp.ncbi.nlm.nih.gov/blast/db/16S_ribosomal_RNA.tar.gz
if [ -f "16S_ribosomal_RNA.tar.gz" ]; then
    tar -xzvf 16S_ribosomal_RNA.tar.gz && rm -f 16S_ribosomal_RNA.tar.gz
else
    echo "Failed to download 16S_ribosomal_RNA.tar.gz"
    exit 1
fi

# Change to the taxdb directory
cd "$TAXDB_DIR" || { echo "Failed to change directory to $TAXDB_DIR"; exit 1; }

# Download and extract the taxdb database
echo "Downloading and extracting taxdb database..."
wget https://ftp.ncbi.nlm.nih.gov/blast/db/taxdb.tar.gz
if [ -f "taxdb.tar.gz" ]; then
    tar -xzvf taxdb.tar.gz && rm -f taxdb.tar.gz
else
    echo "Failed to download taxdb.tar.gz"
    exit 1
fi

echo "Databases downloaded and extracted successfully."

