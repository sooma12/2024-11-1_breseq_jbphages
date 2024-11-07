#!/bin/bash
source ./config.cfg

mkdir -p ${CAT_OUT_PATH}

find ${BRESEQ_OUTPATH} -maxdepth 1 -mindepth 1 -type d > output_dirs.list

# Written for filepaths like: /Users/mws/Documents/geisinger_lab_research/bioinformatics_in_acinetobacter/lirL_suppressor_mutations_breseq/2023-10-20_breseq/breseq_output/output_zips/MSA152
paste output_dirs.list | while read directory ;
do
  rootname=$(basename ${directory})
  python ${SCRIPT_DIR}/cat_breseq.py -i ${directory} -o ${CAT_OUT_PATH}
  mv ${CAT_OUT_PATH}/Predicted_Mutations_all.txt ${CAT_OUT_PATH}/${rootname}_predicted_mutations.txt || echo 'mv failed'
  mv ${CAT_OUT_PATH}/Unassigned_new_junction_evidence_all.txt ${CAT_OUT_PATH}/${rootname}_unassigned_new_junction_evidence.txt || echo 'mv failed'
done
