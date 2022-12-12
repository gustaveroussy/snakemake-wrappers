#!/usr/bin/env bash

script_dir=$(dirname $0)
script_dir=$(readlink -e "${script_dir}")

params_demux=""

if [ -n "$(find input/*/archive/*/unaligned/Stats/ -name "Stats.json.zip" | head -1)" ]; then
    # Special case demux
    bash "${script_dir}/run.sh" fastqc_multiqc -p demux output/multiqc.html "$@"
else
    echo "Stats not found"
    # Classic case, must fit demux-like behaviour
    mkdir -p input/tmp_stats/archive/tmp_stats/unaligned/Stats/
    echo "[]" > Stats.json
    zip input/tmp_stats/archive/tmp_stats/unaligned/Stats/Stats.json.zip Stats.json 
    bash "${script_dir}/run.sh" fastqc_multiqc -p demux output/multiqc.html "$@"
    if [ -d "multiqc" ] ; then 
        mv --verbose multiqc output
    fi
fi
