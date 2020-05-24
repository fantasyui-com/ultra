function tempo_song(){

  original=$1;
  remastered=$2;
  oldbpm=$3;
  newbpm=$4;

  echo original: $original;
  echo remastered: $remastered;
  echo oldbpm: $oldbpm;
  echo newbpm: $newbpm;

  if [ -f "$remastered" ] && [ "$remastered" -nt "$original" ]; then
    # remastered exists, and is newer than original, nothing to do;
    # echo up to date: "$remastered"
    echo -ne "";
  elif [ -n "$oldbpm" ] && [ -n "$newbpm" ]; then

    echo adjusting tempo from $oldbpm $newbpm;

    

  else
    echo ERROR: missing arguments
    echo oldbpm: $oldbpm;
    echo newbpm: $newbpm;
    exit 1;
  fi

}
