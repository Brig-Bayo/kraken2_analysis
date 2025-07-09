
# Kraken2 Metagenomic Analysis Script

**Author:** Bright Boamah  
**Date:** July 2025

## Description

This comprehensive bash script automates the analysis of metagenomic files using Kraken2, a taxonomic classification system. The script handles database setup, file validation, and provides detailed analysis results with summary statistics.

## Features

- **Automated Database Setup**: Downloads and builds Kraken2 databases automatically
- **Comprehensive Error Handling**: Validates input files and checks for dependencies
- **Flexible Configuration**: Supports custom thread counts and confidence thresholds
- **Detailed Logging**: Color-coded output with timestamps
- **Summary Statistics**: Provides classification rates and top results
- **Safe Execution**: Uses bash strict mode for error prevention

## Prerequisites

Before running the script, ensure you have:

1. **Kraken2** installed on your system
2. **bc** (basic calculator) for percentage calculations
3. Sufficient disk space for database files (typically 50-100 GB)
4. Internet connection for downloading database libraries

### Installing Kraken2

```bash
# Ubuntu/Debian
sudo apt-get update
sudo apt-get install kraken2

# CentOS/RHEL
sudo yum install kraken2

# Or compile from source
git clone https://github.com/DerrickWood/kraken2.git
cd kraken2
./install_kraken2.sh $HOME/kraken2
```

## Usage

### Basic Usage

```bash
./analyze_metagenome.sh <input_file> <output_file> <database_name>
```

### Advanced Usage

```bash
./analyze_metagenome.sh sample.fastq results.txt my_db --threads 8 --confidence 0.1
```

### Options

- `-t, --threads NUM`: Number of threads to use (default: 4)
- `-c, --confidence NUM`: Confidence threshold (default: 0.0)
- `-h, --help`: Show help message

### Examples

```bash
# Basic analysis with default settings
./analyze_metagenome.sh sample.fastq results.txt bacterial_db

# High-performance analysis with 16 threads
./analyze_metagenome.sh sample.fastq results.txt bacterial_db --threads 16

# Conservative analysis with higher confidence threshold
./analyze_metagenome.sh sample.fastq results.txt bacterial_db --confidence 0.5
```

## Input File Formats

The script accepts various sequence file formats supported by Kraken2:
- FASTA (.fasta, .fa)
- FASTQ (.fastq, .fq)
- Gzipped files (.gz)

## Output Files

The script generates two main output files:

1. **Main Output File**: Contains classification results for each read
2. **Report File** (`.report`): Contains taxonomic summary with read counts

## Database Information

The script automatically downloads and builds bacterial databases. The database building process includes:

1. **Taxonomy Download**: NCBI taxonomic information
2. **Library Download**: Bacterial genome sequences
3. **Database Building**: Creating the Kraken2 index

**Note**: Database building can take several hours and requires significant disk space.

## Performance Considerations

- **Memory Usage**: Kraken2 databases require substantial RAM (typically 8-32 GB)
- **Disk Space**: Database files can be 50-100 GB or larger
- **CPU Usage**: More threads generally improve performance
- **Network**: Initial database download requires stable internet connection

## Troubleshooting

### Common Issues

1. **Out of Memory**: Reduce thread count or use a smaller database
2. **Disk Space**: Ensure sufficient space for database files
3. **Network Issues**: Database download may fail; script will retry
4. **Permission Errors**: Ensure write permissions for output directory

### Error Messages

The script provides detailed error messages with suggested solutions:

- Dependency checks ensure required software is installed
- File validation prevents analysis of missing/empty files
- Progress logging helps identify where issues occur

## Example Output

```
[2025-07-03 06:15:00] Input file: sample.fastq (1.2G)
[2025-07-03 06:15:00] Output file: results.txt
[2025-07-03 06:15:00] Database: bacterial_db
[2025-07-03 06:15:00] Threads: 8
[2025-07-03 06:15:00] Confidence threshold: 0.1
[2025-07-03 06:15:00] Starting Kraken2 analysis...
[SUCCESS] Analysis completed in 450 seconds

=== ANALYSIS SUMMARY ===
Total reads processed: 100000
Classified reads: 75000
Unclassified reads: 25000
Classification rate: 75.00%

Output files:
  - Main output: results.txt
  - Report: results.txt.report
```

## License

This script is provided as-is for educational and research purposes. Please cite appropriately if used in publications.

## Contact

For questions or issues, please contact Bright Boamah.

---

**Note**: This script is designed for research purposes. Always validate results and consider computational resources before running large-scale analyses.
