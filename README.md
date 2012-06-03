haskellifi-trayicon
===================

Detect wifis and suggest predefined passwords.

Disclaimer
==========

THIS IS IMPORTANT. This program is not intended for hacker wannabes.  This is
meant ONLY for network administrators. I WILL DENY ANY RESPONSIBILITY FOR ANY
DAMAGE CAUSED BY IMPROPER OR ILLEGAL USE OF THIS PROGRAM.

Introduction
============

More often than not, network administrators have to deal with clients or other
administrators how know very little about wifi security. It is not uncommon to
find wifis with default passwords. This program suggests passwords for the
wifis it detects, and it presents the information in a visually attractive way
(tray icon with popup menu) so that your collaborators fully understand HOW
EASY IT IS TO BREAK INTO THEIR NETWORKS.

NOTE: at the present time, this works only with Telefonica Spain's WPA2
default passwords. If the default password of your wifi can be automatically
generated from "open" or publicly visible parameters, feel free to write the
algorithm in Haskell, send it to me and I'll see if I can add it here.

Jazztel wifis in Spain might also work (AFAIK, the algorithm is the same), but
because I never had one of those, I can't corroborate it. Feel free to send me
a message if you make it work for your network.

Installation
============
You neet to have the Network Manager's CLI installed (running 'which nmcli'
should tell you whether it is available or not).

Install https://github.com/ivanperez-keera/keera-hails (download, unpack, cabal
install).

Download, unpack and run 'cabal install' from
https://github.com/ivanperez-keera/haskellifi-trayicon.

Running
=======
Execute haskellifi-trayicon. You should see an icon on your traybar or
notification area.  Left click will show a menu with the list of wifis it can
suggest a password for. Clicking on one will copy the suggested password to the
clipboard.

Right click on the icon to clear the wifi list or quit the program.

Bugs and contact
================
Send bugs, suggestions, ideas, etc. to:

ivan DOT perez _delete_this_ AT keera DOT es

ivanperezdominguez+haskellifi _delete_this_as_well AT gmail DOT com

Back in the good old days(tm), this program was based on iwconfig. There's a
module on Network/Wifi/Iwconfig.hs with the old code I used to use. Feel free
to modify it to get information about wifis from other sources. I am told that
you can get a lot of stuff using airodump-ng, but that might not be legal where
you live so, check the law, then check airodump-ng, then send me pull request.

Licence
=======
The code of this tool is BSD3. The icon has a different licence. I have not been
able to locate the original author, but the icon was definitely installed on my
system and Radio Tray (http://radiotray.sourceforge.net/) also uses it, so I am
assuming it is free as in 'freedom'. If it's yours and you have a problem with
me using it, let me know ASAP and I'll remove it right away.

If you can create an icon for this program and send it to me I'll be happy to
use yours if it's nice.

Legal
=====
This program does not hack into wifis. It also does not break into networks. It
suggests a password calculating it from open, publicly available data (without
seeing or capturing private data). It does not check whether the password is
correct. All it will do is copy it in the clipboard when instructed to do so by
the user. The password might not even be the right one.

I no longer live in Spain. This program is not being distributed from Spain.
As far as I am concerned, it might not even work. If somebody uses this to
break into somebody else's wifi, it's their fault, not mine. Sue them. They
were warned before they downloaded and used the program. They knew perfectly
well what they were doing.
