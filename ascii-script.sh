#/bin/bash
sudo apt-get install cowsay -y
cowsay -f dragon "run i'm a scary dragon....rawrrr..." >> dragon.txt
grep -i "dragon" dragon.txt
cat dragon.txt
ls -ltra
