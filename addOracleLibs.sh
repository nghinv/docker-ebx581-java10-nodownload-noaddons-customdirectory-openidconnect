mkdir /tmp/oraclejarlibs

for i in $*; do
    wget -P /tmp/oraclejarlibs --no-check-certificate -c --header "Cookie: oraclelicense=accept-securebackup-cookie" $i
done

unzip '/tmp/oraclejarlibs/*.zip' -d /tmp/oraclejarlibs

for D in /tmp/oraclejarlibs/*; do
    if [ -d "${D}" ]; then
        cp "${D}/mail.jar" lib/
        cp "${D}/activation.jar" lib/
    fi
done

rm -rf /tmp/oraclejarlibs