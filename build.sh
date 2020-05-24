#!/usr/bin/env bash

echo "#!/usr/bin/env bash" > ./ultra;
chmod +x ./ultra;
for filename in src/*.bash; do
  echo >> ./ultra;
  cat $filename >> ./ultra;
  echo >> ./ultra;
done;

cat ./index.sh >> ./ultra;
