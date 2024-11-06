#!/bin/bash
## 2_make_sample_sheet.sh
# Generate a sample sheet containing
# Usage: `bash 2_make_sample_sheet.sh`

# Output filepath; bash magic below will make individual output filepaths by strain ID

source ./config.cfg

# Location of fastq.gz files.

echo "Fastq files found in: " $FASTQDIR_3

# bash magic to get file lists and create a sample sheet (lists paired files for each strain)
# See https://www.biostars.org/p/449164/

# Create .list files with R1 and R2 fastqs.  Sort will put them in same orders, assuming files are paired
find $FASTQDIR_3 -maxdepth 1 -name "*.fastq.gz" | grep -e "_R1" | sort > R1.list ;
find $FASTQDIR_3 -maxdepth 1 -name "*.fastq.gz" | grep -e "_R2" | sort > R2.list ;

# For debug purposes... delete sample sheet if it exists
if [ -f "${SAMPLE_SHEET}" ] ; then
  rm "${SAMPLE_SHEET}"
fi

# make sample sheet from R1 and R2 files.  Format on each line looks like (space separated):
# MSA# /path/to/MSA#_R1.fastq /path/to/MSA#_R2.fastq
# from sample sheet, we can access individual items from each line with e.g. `awk '{print $3}' sample_sheet.txt`
paste R1.list R2.list | while read R1 R2 ;
do
    outdir_root=$(basename "${R2}" | cut -f1,2 -d"_") ;
    sample_line="${outdir_root} ${R1} ${R2}" ;
    echo "${sample_line}" >> $SAMPLE_SHEET
done

rm R1.list
rm R2.list

echo 'Sample sheet contents:'
cat $SAMPLE_SHEET
