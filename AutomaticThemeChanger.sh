#!/bin/bash

# Script that auto switches Ubuntu themes to Dark or Light, 
# depending on the time of day
#
# [ Portugues] Tutorial: básicamente copia e cola este arquivo na pasta /usr/local/bin/
# Agora tecla crontab -e, seleciona teu editor e coloca as seguintes linhas
#
# 30 5 * * * bash /usr/bin/local/AutomaticThemeChanger.sh light
# 0 19 * * * bash /usr/bin/local/AutomaticThemeChanger.sh dark
# @reboot bash /usr/bin/local/AutomaticThemeChanger.sh
#
# agora só inverte a cor do teu computador e reinicia ele, pra confirmar que esta funcionando.
#
# [ English ] Tutorial
# Copy this script file to /usr/local/bin/AutomaticThemeChanger
# Now just type crontab -e, select your editor and paste in the following lines:
#
# 30 5 * * * bash /usr/bin/local/AutomaticThemeChanger light
# 0 19 * * * bash /usr/bin/local/AutomaticThemeChanger dark
# @reboot bash /usr/bin/local/AutomaticThemeChanger

set_theme() {
    # https://askubuntu.com/a/743024/1193214
    # PID may return multiple ids here, so I converted to to array and got just the first id.
    # Otherwise, you may try another suggestion in the link https://askubuntu.com/a/1437023/1193214
    PID=($(pgrep gnome-session))
    favoriteColor="red"
    export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)
    echo `date` Starting script execution - setting theme $1 >> ~/Scripts/switch-theme.log
    if [[ "$1" == "dark" ]]; then
        new_gtk_theme="Yaru-$favoriteColor-dark"
        # Some apps also need color scheme
        new_color_scheme="prefer-dark"
        new_icon_theme="Yaru-$favoriteColor-dark"
    elif [[ "$1" == "light" ]]; then
        new_gtk_theme="Yaru-$favoriteColor"
        new_color_scheme="prefer-light"
        new_icon_theme="Yaru-$favoriteColor"the
    else
        echo "[!] Unsupported theme: $1"
        return
    fi
           
    current_gtk_theme=$(gsettings get org.gnome.desktop.interface gtk-theme)
    current_color_scheme=$(gsettings get org.gnome.desktop.interface color-scheme)
    if [[ "${current_gtk_theme}" == "'${new_gtk_theme}'" ]]; then
        echo "`date` [i] Already using gtk '${new_gtk_theme}' theme" >> ~/Scripts/switch-theme.log
    else
        echo "`date` [-] Setting gtk theme to ${new_gtk_theme}" >> ~/Scripts/switch-theme.log
        # i don't mind about icon-themes. if you do just uncomment it.
        #gsettings set org.gnome.desktop.interface icon-theme "${new_icon_theme}" 

        gsettings set org.gnome.desktop.interface gtk-theme "${new_gtk_theme}"
        gsettings set org.gnome.desktop.interface color-scheme "${new_color_scheme}"
        
        echo "`date` [✓] gtk theme changed to ${new_gtk_theme}" >> ~/Scripts/switch-theme.log
    fi
}

# If script run without argument
if [[ -z "$1" ]]; then
    currenttime=$(date +%H:%M)

    if [[ "$currenttime" > "19:00" || "$currenttime" < "5:20" ]]; then
        set_theme dark
    else
        set_theme light
    fi
else
    set_theme $1
fi
