function playlist_creator(){
  (sed -e 's/#.*$//' -e '/^$/d' -e 's/[[:space:]]*$//' $1) | readarray -t playlist;
}
