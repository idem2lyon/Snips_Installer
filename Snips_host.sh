# Install NPM
curl -L https://npmjs.com/install.sh | sudo sh

# Install Sound-Card & Drivers from : https://github.com/Psychokiller1888/snipsLedControl/
cd ~/
wget https://gist.githubusercontent.com/Psychokiller1888/a9826f92c5a3c5d03f34d182fda1ce4c/raw/e24882e8997730dcf7a308e303b3b88001dbbfa1/slc_download.sh
sudo chmod +x slc_download.sh
sudo ./slc_download.sh
cd ~/


#Install Snips Plateform 
sudo apt-get install snips-platform-voice

#Prepare for add satellites https://github.com/Psychokiller1888/satConnect
cd ~/
git clone https://github.com/Psychokiller1888/satConnect.git
cd satConnect
sudo pip install -r requirements.txt
sudo python server.py --remove-backup
cd ~/
