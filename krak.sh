#!/bin/bash
set -e

# Usage function
show_usage() {
    echo "Usage: $0 [INPUT_DIR] [OUTPUT_DIR]"
    echo "  INPUT_DIR:  Directory containing FASTA files (default: current directory)"
    echo "  OUTPUT_DIR: Directory for output files (default: ./kraken_output)"
    echo "  "
    echo "Example: $0 /path/to/input /path/to/output"
    echo "Author: Bright Boamah"
    exit 1
}

# Check for help flag
if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    show_usage
fi

# Define input and output directories
INPUT_DIR="${1:-.}"
OUTPUT_DIR="${2:-./kraken_output}"

# Create output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Define variables
DB_PATH="/path/to/database"
THREADS=7

# Check if input directory exists
if [ ! -d "$INPUT_DIR" ]; then
    echo "Error: Input directory $INPUT_DIR does not exist."
    exit 1
fi

# Check if database directory exists and contains data
if [ -d "$DB_PATH" ] && [ "$(ls -A $DB_PATH)" ]; then
    echo "Database directory exists and is not empty."
else
    echo "Error: Database directory is missing or empty."
    exit 1
fi

# Count total files to process
total_files=$(find "$INPUT_DIR" -name "*.fasta" -o -name "*.fa" -o -name "*.fastq" -o -name "*.fastq.gz" | wc -l)
if [ "$total_files" -eq 0 ]; then
    echo "No FASTA files found in $INPUT_DIR"
    exit 1
fi

echo "Found $total_files FASTA file(s) to process in $INPUT_DIR"
echo "Output directory: $OUTPUT_DIR"
echo "Starting Kraken2 processing..."
echo "======================================"

# Initialize counter
processed=0

# Loop through all FASTA/FASTQ files in the input directory
for INPUT_FILE in "$INPUT_DIR"/*.fasta "$INPUT_DIR"/*.fa "$INPUT_DIR"/*.fas "$INPUT_DIR"/*.fastq "$INPUT_DIR"/*.fastq.gz; do
    # Skip if file doesn't exist (handles case when no files match pattern)
    [ -f "$INPUT_FILE" ] || continue
    
    # Get basename without extension
    BASENAME=$(basename "$INPUT_FILE")
    BASENAME_NO_EXT="${BASENAME%.*}"
    
    # Define output files based on basename
    OUTPUT_FILE="$OUTPUT_DIR/${BASENAME_NO_EXT}_kraken2_output.txt"
    REPORT_FILE="$OUTPUT_DIR/${BASENAME_NO_EXT}_kraken2_report.txt"
    UNCLASSIFIED="$OUTPUT_DIR/${BASENAME_NO_EXT}_unclassified_reads.fastq"
    CLASSIFIED="$OUTPUT_DIR/${BASENAME_NO_EXT}_classified_reads.fastq"
    
    # Increment counter
    ((processed++))
    
    echo "Processing file $processed/$total_files: $BASENAME"
    
    # Run Kraken2
    kraken2 --db "$DB_PATH" --threads "$THREADS" --output "$OUTPUT_FILE" --report "$REPORT_FILE" \
            --unclassified-out "$UNCLASSIFIED" --classified-out "$CLASSIFIED" "$INPUT_FILE"
    
    echo "  ✓ Output written to: $OUTPUT_FILE"
    echo "  ✓ Report written to: $REPORT_FILE"
    echo "  ✓ Unclassified reads: $UNCLASSIFIED"
    echo "  ✓ Classified reads: $CLASSIFIED"
    echo "  ✓ Processing of $BASENAME complete."
    echo "--------------------------------------"
done

echo "All files processed successfully!"
echo "Results saved in: $OUTPUT_DIR"
echo "Total files processed: $processed"

