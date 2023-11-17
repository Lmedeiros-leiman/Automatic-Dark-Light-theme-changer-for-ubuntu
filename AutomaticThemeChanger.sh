#!/bin/bash

set_theme() {
    # https://askubuntu.com/a/743024/1193214
    # PID may return multiple ids here, so I converted to to array and got just the first id.
    # Otherwise, you may try another suggestion in the link https://askubuntu.com/a/1437023/1193214

    # your favorite color for the UI.
    favoriteColor="red"
    
    PID=($(pgrep gnome-session))
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
    #
    # by default i made so that the script is light themed during the day and dark themed during the night
    #
    if [[ "$currenttime" > "19:00" || "$currenttime" < "5:20" ]]; then
        set_theme light
    else
        set_theme dark
    fi
else
    set_theme $1
fi
