#!/bin/bash

source /home/container/data/config

option_0 () { #manual setup
    echo "+=+ Manual setup selected"
}

option_1 () { #automatic setup
    echo "+=+ Automatic setup selected."
    echo "+=+ Downloading jar from $server."
    wget --continue -O /home/container/minecraft/$jar_name $server
    create_startscript
    create_eula

    echo "+==+ /minecraft $(ls /home/container/minecraft)"
    start_server
}

option_2 () {
    echo "+=+ I am a lazy dev."
    echo "+=+ warning, I never tested if option 2 actually works."

    echo "+=+ Download link(zip) selected."
    echo "+=+ Downloading file from $server."
    wget --continue -O /home/container/minecraft/serverzip.zip $server
    echo "+=+ Unzipping file."
    unzip -d /home/container/minecraft serverzip.zip
    echo "+=+ Removing zip file."
    rm --force serverzip.zip
}

start_server () {
    echo "+=+ Starting server."
    bash /home/container/minecraft/start.sh
}

create_startscript () {
    echo "+=+ Creating start.sh."
    echo "
    #!/bin/bash
    $start_command
    " > /home/container/minecraft/start.sh
}

create_eula () {
    echo "+=+ Creating eula.txt"
    echo "#By changing the setting below to TRUE you are indicating your agreement to our EULA (https://account.mojang.com/documents/minecraft_eula).
    #You also agree that Minecraft is tasty, and the best game in the world.
    eula=true
    " > /home/container/minecraft/eula.txt
}

cleanup () {
    echo "+=+ I am a lazy dev."
}

if [ "$option" == "0" ]; then
    option_0
elif [ "$option" == "1" ]; then
    option_1
elif [ "$option" == "2" ]; then
    option_2
elif [ "$option" == "3" ]; then
    option_3
else
    echo "+=+ Invalid option."
fi

echo "+=+ Exiting."