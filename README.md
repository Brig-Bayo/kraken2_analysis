# Krak - Kraken2 Batch Processing Script

A powerful and user-friendly bash script for batch processing FASTA/FASTQ and derivative files using Kraken2 taxonomic classification.

## 🧬 Overview

Krak is a streamlined bash script designed to automate the taxonomic classification of multiple FASTA files using Kraken2. It processes all FASTA files in a specified directory and generates comprehensive output including classification results, reports, and separated classified/unclassified reads.

## ✨ Features

- **Batch Processing**: Automatically processes all FASTA files in a directory
- **Multiple File Format Support**: Handles `.fasta`, `.fa`, and `.fas` file extensions
- **Comprehensive Output**: Generates classification results, detailed reports, and separated read files
- **Progress Tracking**: Real-time progress updates with file counters
- **Error Handling**: Robust error checking for directories, databases, and file existence
- **Flexible Configuration**: Customizable input/output directories with sensible defaults
- **Multi-threading Support**: Configurable thread usage for optimal performance

## 📋 Requirements

### Software Dependencies
- **Kraken2**: Taxonomic classification system
- **Bash**: Version 4.0 or higher
- **Standard Unix utilities**: `find`, `wc`, `basename`, `mkdir`

### System Requirements
- Linux/Unix operating system
- Sufficient disk space for output files
- RAM requirements depend on the Kraken2 database size

### Database Requirements
- Kraken2 database (script is configured for standard 16GB database)
- Database path: `/path/database` (configurable in script)

## 🚀 Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/brightboamah/krak.git
   cd krak
   ```

2. **Make the script executable**:
   ```bash
   chmod +x krak.sh
   ```

3. **Install Kraken2** (if not already installed):
   ```bash
   # Using conda
   conda install -c bioconda kraken2
   
   # Or using apt (Ubuntu/Debian)
   sudo apt-get install kraken2
   ```

4. **Download Kraken2 database**:
   ```bash
   # Download standard database (adjust path as needed)
   kraken2-build --download-taxonomy --db /path/to/your/database
   kraken2-build --download-library bacteria --db /path/to/your/database
   kraken2-build --build --db /path/to/your/database
   ```

## 📖 Usage

### Basic Usage

```bash
./krak.sh [INPUT_DIR] [OUTPUT_DIR]
```

### Parameters

- `INPUT_DIR`: Directory containing files (default: current directory)
- `OUTPUT_DIR`: Directory for output files (default: `./kraken_output`)

### Help

```bash
./krak.sh -h
# or
./krak.sh --help
```

## 💡 Examples

### Example 1: Process files in current directory
```bash
./krak.sh
```
This will process all FASTA/FASTQ files in the current directory and save results to `./kraken_output/`.

### Example 2: Specify input and output directories
```bash
./krak.sh /path/to/fasta-fastq/files /path/to/results
```

### Example 3: Process files from a specific directory with default output
```bash
./krak.sh /home/user/sequences
```

## 📁 Output Files

For each input FASTA file, the script generates:

| File Type | Description | Example Filename |
|-----------|-------------|------------------|
| **Classification Output** | Kraken2 classification results | `sample_kraken2_output.txt` |
| **Report** | Taxonomic classification report | `sample_kraken2_report.txt` |
| **Unclassified Reads** | Reads that couldn't be classified | `sample_unclassified_reads.fastq` |
| **Classified Reads** | Successfully classified reads | `sample_classified_reads.fastq` |

## ⚙️ Configuration

### Modifying Database Path
Edit the `DB_PATH` variable in the script:
```bash
DB_PATH="/path/to/your/kraken2/database"
```

### Adjusting Thread Count
Modify the `THREADS` variable for your system:
```bash
THREADS=8  # Adjust based on your CPU cores
```

## 🔧 Troubleshooting

### Common Issues

1. **"Database directory is missing or empty"**
   - Ensure the Kraken2 database is properly downloaded and built
   - Verify the `DB_PATH` variable points to the correct location

2. **"No FASTA files found"**
   - Check that your input directory contains files with `.fasta`, `.fa`, or `.fas` or `.fastq` or `.fastq.gz`extensions
   - Verify the input directory path is correct

3. **Permission denied**
   - Make sure the script is executable: `chmod +x krak.sh`
   - Ensure you have write permissions for the output directory

4. **Kraken2 command not found**
   - Install Kraken2 or ensure it's in your PATH
   - Check installation with: `kraken2 --version`

## 📊 Performance Tips

- **Memory**: Ensure sufficient RAM for your Kraken2 database
- **Storage**: Allow adequate disk space for output files (can be substantial for large datasets)
- **Threads**: Adjust thread count based on your CPU cores and available memory
- **Database**: Use appropriate database size for your classification needs

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

### Development Guidelines
- Follow bash best practices
- Add comments for complex logic
- Test with various file formats and sizes
- Ensure error handling is robust

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Bright Boamah**

- GitHub: [@brightboamah](https://github.com/brightboamah)
- Email: [briteboafo@icloud.com](briteboafo@icloud.com)

## 🙏 Acknowledgments

- [Kraken2](https://github.com/DerrickWood/kraken2) development team for the excellent taxonomic classification tool
- The bioinformatics community for continuous support and feedback

## 📚 References

- Wood, D.E., Lu, J. & Langmead, B. Improved metagenomic analysis with Kraken 2. Genome Biol 20, 257 (2019). https://doi.org/10.1186/s13059-019-1891-0

---

⭐ If you find this script useful, please consider giving it a star on GitHub!

