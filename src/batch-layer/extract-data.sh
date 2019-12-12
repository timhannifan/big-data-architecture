# /bin/bash

echo "Extracting..."
for f in *.xz;
	do xz --decompress $f;
done
