function trim_song(){

  original=$1;
  remastered=$2;
  start=$3;
  end=$4;

  # echo original: $original;
  # echo remastered: $remastered;
  # echo start: $start;
  # echo end: $end;

  if [ -f "$remastered" ] && [ "$remastered" -nt "$original" ]; then

    # remastered exists, and is newer than original, nothing to do;
    # echo up to date: "$remastered"
    echo -ne "";


  elif [ -n "$start" ] && [ -n "$end" ]; then
    echo Trimming start and end: $start $end
    ffmpeg -hide_banner -loglevel panic -y -i $original -ss $start -to $end $remastered;
  elif [ -n "$start" ]; then
    echo Trimming start: $start
    ffmpeg -hide_banner -loglevel panic -y -i $original -ss $start $remastered;
  elif [ -n "$end" ]; then
    echo Trimming end: $end
    ffmpeg -hide_banner -loglevel panic -y -i $original -to $end $remastered;
  else
    cp $original $remastered;
  fi

}
