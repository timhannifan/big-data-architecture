# /bin/bash

for f in *.xz;
	do xz --decompress $f
done
