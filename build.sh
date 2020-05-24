#!/usr/bin/env bash

echo "#!/usr/bin/env bash" > ./ultra;
chmod +x ./ultra;
for filename in src/*.bash; do
  echo "source ./$filename;" >> ./ultra;
done;

cat ./index.sh >> ./ultra;
