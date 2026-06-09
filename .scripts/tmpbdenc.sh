#!/bin/bash

set -e

infn="$1"
outfn="$2"
qual="$3"
atrack="$4"

ffmpeg -i "$infn" -vcodec hevc_qsv -preset veryslow -global_quality $qual "${outfn}.hevc"
ffmpeg -i "$infn" -map 0:a:$atrack "${outfn}.wav"
qaac64 -V 127 "${outfn}.wav"
mkvmerge -o "${outfn}.mkv" -T --no-global-tags "${outfn}.hevc" \
    --language 0:jpn -T --no-global-tags "${outfn}.m4a" \
    --chapter-charset UTF-8 --chapter-language und --chapters "${outfn}_chapters.txt"
rm "${outfn}.hevc" "${outfn}.m4a" "${outfn}.wav"
