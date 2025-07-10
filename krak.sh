#!/bin/bash
set -e

#nbf_jul - Updated to process all FASTA files with organized output directories

DIR="/media/paa/fyles/1602095876/Data-analyses/July/krak/"

# Define variables
DB_PATH="/path/to/database/"
THREADS=10
CURRENT_DIR="/path/to/directory"

# Create output directories if they don't exist
OUTPUT_BASE="$DIR/kraken_output"
REPORT_DIR="$OUTPUT_BASE/reports"
CLASSIFIED_DIR="$OUTPUT_BASE/classified"
UNCLASSIFIED_DIR="$OUTPUT_BASE/unclassified"
RAW_OUTPUT_DIR="$OUTPUT_BASE/raw_output"

mkdir -p "$REPORT_DIR" "$CLASSIFIED_DIR" "$UNCLASSIFIED_DIR" "$RAW_OUTPUT_DIR"
echo "Created output directory structure:"
echo "  $OUTPUT_BASE/"
echo "  ├── reports/          (will contain classification reports)"
echo "  ├── classified/       (will contain classified reads)"
echo "  ├── unclassified/     (will contain unclassified reads)"
echo "  └── raw_output/       (will contain raw Kraken2 output)"
echo ""

# Check if database directory exists and contains data
if [ -d "$DB_PATH" ] && [ "$(ls -A $DB_PATH)" ]; then
    echo "Database directory exists and is not empty."
else
    echo "Error: Database directory is missing or empty."
    exit 1
fi

# Find all FASTA files and process each one
echo "Looking for FASTA files in $CURRENT_DIR..."
fasta_files=("$CURRENT_DIR"/*.fasta "$CURRENT_DIR"/*.fa "$CURRENT_DIR"/*.fas "$CURRENT_DIR"/*.fastq "$CURRENT_DIR"/*.fastq.gz)

# Check if any FASTA files exist
fasta_found=false
for file in "${fasta_files[@]}"; do
    if [ -f "$file" ]; then
        fasta_found=true
        break
    fi
done

if [ "$fasta_found" = false ]; then
    echo "Error: No FASTA files found in $CURRENT_DIR"
    exit 1
fi

# Process each FASTA file
for INPUT_FILE in "${fasta_files[@]}"; do
    # Skip if file doesn't exist (handles glob expansion when no files match)
    if [ ! -f "$INPUT_FILE" ]; then
        continue
    fi
    
    # Extract filename without path and extension for output naming
    BASENAME=$(basename "$INPUT_FILE" | sed 's/\.[^.]*$//')
    
    # Define output files for this specific input using organized directory structure
    OUTPUT_FILE="$RAW_OUTPUT_DIR/${BASENAME}_kraken2_output.txt"
    REPORT_FILE="$REPORT_DIR/${BASENAME}_kraken2_report.txt"
    UNCLASSIFIED="$UNCLASSIFIED_DIR/${BASENAME}_unclassified_reads.fastq"
    CLASSIFIED="$CLASSIFIED_DIR/${BASENAME}_classified_reads.fastq"
    
    echo "Processing $INPUT_FILE..."
    echo "Output files will be prefixed with: $BASENAME"
    echo "  - Raw output: raw_output/${BASENAME}_kraken2_output.txt"
    echo "  - Report: reports/${BASENAME}_kraken2_report.txt"
    echo "  - Classified: classified/${BASENAME}_classified_reads.fastq"
    echo "  - Unclassified: unclassified/${BASENAME}_unclassified_reads.fastq"
    
    # Run Kraken2
    kraken2 --db $DB_PATH --threads $THREADS --output $OUTPUT_FILE --report $REPORT_FILE \
            --unclassified-out $UNCLASSIFIED --classified-out $CLASSIFIED "$INPUT_FILE"
    
    echo "Kraken2 processing complete for $INPUT_FILE"
    echo "Files successfully written to their respective directories"
    echo "----------------------------------------"
done

echo "All FASTA files processed successfully!"
echo "Output directory structure:"
echo "  $OUTPUT_BASE/"
echo "  ├── reports/          (Kraken2 classification reports)"
echo "  ├── classified/       (Classified reads)"
echo "  ├── unclassified/     (Unclassified reads)"
echo "  └── raw_output/       (Raw Kraken2 output)"
echo ""
echo "Files processed:"
for INPUT_FILE in "${fasta_files[@]}"; do
    if [ -f "$INPUT_FILE" ]; then
        BASENAME=$(basename "$INPUT_FILE" | sed 's/\.[^.]*$//')
        echo "  - $BASENAME (from $(basename "$INPUT_FILE"))"
    fi
done


