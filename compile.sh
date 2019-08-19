clear
clear
apt --assume-yes update && upgrade
apt install --assume-yes crontab
apt install --assume-yes wget
apt install --assume-yes gcc
clear
clear
pkill vfc
rm vfc
rm /usr/bin/vfc
gcc -pthread base58.c crc64.c ecc.c sha3.c main.c -lm -o vfc
cp vfc /usr/bin/vfc
chmod 0777 /usr/bin/vfc

crontab -l > ncron
if grep -qxF '*/5 * * * * /usr/bin/vfc' ncron; then
    echo "Cron1 Exists";
else
    echo "*/5 * * * * /usr/bin/vfc" >> ncron
    crontab ncron
    echo "Cron1 Added";
fi

if grep -qxF '0 0 * * * pkill vfc && /usr/bin/vfc update' ncron; then
    echo "Cron2 Exists";
else
    echo "0 0 * * * pkill vfc && /usr/bin/vfc update" >> ncron
    crontab ncron
    echo "Cron2 Added";
fi
rm ncron

pkill vfc
vfc master_resync

echo "Compiled and Installed /usr/bin/vfc and /srv/.vfc or ~/.vfc "
echo "Don't forget to forward UDP port 8787 if behind a router."
echo "For more information type; vfc help"
