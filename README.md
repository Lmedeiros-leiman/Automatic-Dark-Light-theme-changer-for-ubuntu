># Script that auto switches Ubuntu Themes to Dark or Light, depending on the time of day.

[Original code created here.](https://askubuntu.com/questions/1234742/automatic-light-dark-mode/1491373#1491373)

# about this project

this is a simple linux bash script to automatically swap between light and dark mode based on the current time in the system. Instalation tutorial is included inside the .bs file.

it utilizes crontab to run the script at a specific time or just when the computer is rebooted.

by default it utilizes ubuntu Yaru red theme and can even change icons if that is you turn it on by deleting the # on the script.

Thank you for the original poster and all contributors on AskUbuntu for this code.

when running the script you may find a few errors.

first off this is an user script, so running it as root will result in a critical error, my guess is that it doesnt know to what user apply the changes since "root" may not be a valid one.
second off, this script wants to generate logs at the ~/Scripts folder, if it doesnt find the folder it will just give in some warnings and execute anyways.

# Installation.

 **[ Portugues ]** Tutorial: básicamente copia e cola este arquivo na pasta /usr/local/bin/
 
 Agora tecla crontab -e, seleciona teu editor e coloca as seguintes linhas

```sh
30 5 * * * bash /usr/local/bin/AutomaticThemeChanger.sh light
0 19 * * * bash /usr/local/bin/AutomaticThemeChanger.sh dark
@reboot bash /usr/bin/local/AutomaticThemeChanger.sh
```
e para finalizar a instalação, basta adicionar o arquivo na lista de propriedades do gnome.
para abrir a lista só executa o comando abaixo:
> gnome-session-properties

 agora tu só precisa inverter a cor do teu sistema e executar o arquivo para confirmar que esta funcionando.
 de preferencia tu pode só reiniciar o computador pra confirmar que o crontab tambem esta executando.


**[ English ]** Tutorial
Copy this script file to /usr/local/bin/AutomaticThemeChanger

Now just type crontab -e, select your editor and paste in the following lines:

´´´sh
30 5 * * * bash /usr/bin/local/AutomaticThemeChanger light
0 19 * * * bash /usr/bin/local/AutomaticThemeChanger dark
@reboot bash /usr/bin/local/AutomaticThemeChanger
´´´

and to finish this off, just add this the gnome-session properties, just run this command and add the file.
> gnome-session-properties

after this is done you can invert the system colors and either just run the script
or restart the machine, so its confirmed both the script and crontab are working.
