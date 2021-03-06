
configuration;
ensure;

# echo conf_cache_dir: $conf_cache_dir;

playlist_file=$1;
lower_bpm=$2;
upper_bpm=$3;
output_dir=$4;

# echo playlist_file: $playlist_file;
# echo lower_bpm: $lower_bpm;
# echo upper_bpm: $upper_bpm;
# echo output_dir: $output_dir;

if [ ! -d "$output_dir" ]; then
  echo ERROR: $output_dir not a directory;
  exit 1;
else
  if [ $(ls -A "$output_dir" | wc -l) -ne 0 ]; then
    echo WARN: $output_dir directory not empty;
    #exit 1;
  fi
fi;

playlist_creator $playlist_file;

# printf '%s\n' "${playlist[@]}"

for entry in "${playlist[@]}"; do

  if [ -n "$entry" ]; then

      song=(${entry});

      song_id=${song[0]};

      if [ ! -f "$song_id" ]; then
        echo ERROR: Playlist item $song_id does not exist.
        exit 1;
      fi;

      echo $song_id ---------------------------------- ;


      song_location=$(eval echo $song_id);
      song_bpm=${song[1]};
      song_start=${song[2]};
      song_end=${song[3]};
      id_size=${#song_id};

      file_basename=$(basename -- "$song_location")
      file_extname="${file_basename##*.}"
      file_name="${file_basename%.*}"
      file_md5=$(md5sum $song_location | awk '{print $1}');
      file_newname="${file_md5}.${file_extname}";
      file_mp3name="${file_md5}.mp3";
      trimmed_location="$trimmed_directory/$file_newname";

      file_metaname="${file_md5}.txt";
      meta_location="$meta_directory/$file_metaname";
      entry_stamp=$(echo $entry | md5sum | awk '{print $1}');
      last_stamp=$(touch "$meta_location"; cat "$meta_location" | head -n 1 | md5sum | awk '{print $1}');

      new_bpm=$(shuf -i $lower_bpm-$upper_bpm -n 1)

      tempo_bpmlocation="$tempo_directory/$new_bpm";
      mkdir -p $tempo_bpmlocation;
      tempo_location="$tempo_directory/$new_bpm/$file_mp3name";

      # echo song_id: $song_id;
      # echo song_location: $song_location;
      # echo song_bpm: $song_bpm;
      # echo song_start: $song_start;
      # echo song_end: $song_end;
      # echo id_size: $id_size;
      #
      # echo file_basename: $file_basename;
      # echo file_extname: $file_extname;
      # echo file_name: $file_name;
      # echo file_md5: $file_md5;
      # echo file_newname: $file_newname;
      # echo trimmed_location: $trimmed_location;
      #
      # echo entry_stamp: $entry_stamp;
      # echo last_stamp: $last_stamp;

      ## BEGIN FUNCTIONS

      trim_song $song_location $trimmed_location $song_start $song_end;
      tempo_song $song_location $tempo_location $song_bpm $new_bpm;

      # at this point, copy $tempo_location into the playlist
      cp $tempo_location $output_dir/

      ## END FUNCTIONS

      echo "$entry" > "$meta_location";
  fi;

done;
