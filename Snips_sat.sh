#Dependances
sudo apt-get update
sudo apt-get install -y build-essential
sudo apt-get install -y raspberrypi-kernel-headers
sudo apt-get install -y dirmngr apt-transport-https
sudo apt-get install -y duplicity #https://blog.rom1v.com/2013/08/duplicity-des-backups-incrementaux-chiffres/
sudo apt-get install -y sshfs # https://codeandunicorns.com/duplicity-scpssh-backup-raspberry-pi/
#sudo apt-cache policy lsb-release
sudo apt-get install -y lsb-release


#Install Snips Plateform 
curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
sudo bash -c  'echo "deb   https://raspbian.snips.ai/$(lsb_release -cs) stable main" > /etc/apt/sources.list.d/snips.list'
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys D4F50CDCA10A2849
sudo apt-key adv --keyserver pgp.surfnet.nl --recv-keys D4F50CDCA10A2849
sudo apt-get update
sudo apt-get install -y snips-audio-server
sudo apt-get install -y snips-watch screen

#Install NodeJS + NPM : https://michaelborn.me/entry/installing-node-js-on-raspberry-pi-a
if $(uname -m | grep -Eq ^armv6); then
	  #NODE="$(curl -sL https://nodejs.org/dist/latest | grep 'armv6l.tar.xz' | cut -d'"' -f2)"
	  #wget https://nodejs.org/dist/latest/$NODE
	  NODE="$(curl -sL https://nodejs.org/dist/latest-v8.x | grep 'armv6l.tar.xz' | cut -d'"' -f2)"
	  rm -rf $NODE*  
	  wget https://nodejs.org/dist/latest-v8.x/$NODE &&  tar -xvf $NODE
	  cd ${NODE%%.tar*}/ && sudo cp -Rf * /usr/local/ 
	  cd .. && rm -rf ${NODE%%.tar*}/
	  cd ~/
  else
	  sudo apt-get install -y curl
	  curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	  sudo apt-get install -y nodejs
	  crontab -l | { cat; echo "@reboot sudo node ~/gladys-bluetooth/setup.js"; } | crontab -
	  sudo mkdir /media/freebox
	  sudo mount.cifs //freebox-server.local/SAMSUNG/ /media/freebox -o ip=192.168.0.254,user=freebox,password=[ChangeMe],vers=1.0 && crontab -l | { cat; echo "@reboot sudo mount.cifs //freebox-server.local/SAMSUNG/ /media/freebox -o ip=192.168.0.254,user=freebox,password=[ChangeMe],vers=1.0"; } | crontab - && mkdir /media/freebox/_BACKUPS_RASPYS/$HOSTNAME
          sudo mkdir /_backup  
	  sudo mount.cifs //freebox-server.local/SAMSUNG/_BACKUPS_RASPYS/$HOSTNAME /_backup -o ip=192.168.0.254,user=freebox,password=[ChangeMe],vers=1.0 && crontab -l | { cat; echo "@reboot //freebox-server.local/SAMSUNG/_BACKUPS_RASPYS/$HOSTNAME /_backup -o ip=192.168.0.254,user=freebox,password=[ChangeMe],vers=1.0"; } | crontab -
fi

#Install SAM
sudo apt-get update
sudo bash -c  'echo "deb https://debian.snips.ai/stretch stable main" > /etc/apt/sources.list.d/snips.list'
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys F727C778CCB0A455
sudo apt-key adv --keyserver pgp.surfnet.nl --recv-keys F727C778CCB0A455
sudo npm install -g snips-sam
sam connect $HOSTNAME
sam sound-feedback on

# Install NPM
# wget -O - https://raw.githubusercontent.com/audstanley/NodeJs-Raspberry-Pi/master/Install-Node.sh | sudo bash;
# sudo apt update && sudo apt dist-upgrade -y
# bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered) y y
# curl -L https://npmjs.com/install.sh | sudo sh
# sudo npm install -g snips-sam

# Install Gladys-Bluetooth
cd ~/
sudo apt-get install -y git
sudo npm install pm2 
sudo npm install -g pm2
sudo env PATH=$PATH:/usr/bin /usr/lib/node_modules/pm2/bin/pm2 startup systemd -u pi --hp /home/pi
ls -I* ~/gladys && git clone https://github.com/GladysAssistant/gladys-data.git
git clone https://github.com/gladysassistant/gladys-bluetooth
cd gladys-bluetooth/
rm config.js ; wget https://raw.githubusercontent.com/joe-achim/Snips_Installer/master/config.js

npm install
pm2 startup
sudo setcap cap_net_raw+eip $(eval readlink -f `which node`)
crontab -l | { cat; echo "@reboot sudo node ~/gladys-bluetooth/setup.js"; } | crontab -
pm2 start /home/pi/gladys-bluetooth/app.js --name gladys-bluetooth
pm2 save

# Install Sound-Card & Drivers from : https://github.com/Psychokiller1888/snipsLedControl/
cd ~/
wget https://raw.githubusercontent.com/joe-achim/Snips_Installer/master/.asoundrc
wget https://gist.githubusercontent.com/Psychokiller1888/a9826f92c5a3c5d03f34d182fda1ce4c/raw/e24882e8997730dcf7a308e303b3b88001dbbfa1/slc_download.sh
sudo chmod +x slc_download.sh
sudo ./slc_download.sh 1 1 1
#sudo ./snipsLedControl_v1.7/installers/respeakers.sh
ls -I* ~/seeed-voicecard && sudo mv /etc/asound.conf /etc/asound.conf.sav
ls -I* ~/seeed-voicecard && sudo mv -f ~/.asoundrc /etc/asound.conf
ls -I* ~/seeed-voicecard && sudo apt-get install -y i2c-tools
ls -I* ~/seeed-voicecard && sudo systemctl restart seeed-voicecard
cd ~/

#Prepare for add satellites https://github.com/Psychokiller1888/satConnect
sudo apt-get install python-pip
sudo pip install paho-mqtt
sudo pip install pytoml


cd ~/
git clone https://github.com/Psychokiller1888/satConnect.git
cd satConnect
sudo python connect.py
cd ~/
