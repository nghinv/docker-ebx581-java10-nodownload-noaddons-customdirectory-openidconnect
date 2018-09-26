mkdir /tmp/jarlibs

for i in $*; do
    wget -P lib/ $i
done
