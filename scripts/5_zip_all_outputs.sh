# zip_all_outputs.sh
source ./config.cfg

# breseq
#   ./MSA11
#     ../output
#   ./MSA13
#     ../output
#   ./MSA132
#     ../output
#   ./MSA141
#     ../output

mkdir -p $BRESEQ_OUTPATH/output_zips

# Make a file with the list of all 'MSA#/output' filepaths
find $BRESEQ_OUTPATH -maxdepth 2 -name "output" > dirs.list

paste dirs.list | while read dir ;
do
    # shellcheck disable=SC2164
    cd $dir/..
    file_base=$(basename $(pwd))
    mv -T ./output ./${file_base}_output
    zip -r ${file_base}_output.zip ./${file_base}_output
    mv ./${file_base}_output ./output
    mv ${file_base}_output.zip $BRESEQ_OUTPATH/output_zips/
done

rm dirs.list
