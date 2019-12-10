#!/usr/bin/env bash
function changeCredentials(){
	# Open File, Create if it donot exist.
	echo -n "Username: "
	read username
	echo -n "Enter password for '$username': "
	stty -echo; read password; stty echo;
	echo "https://securelogin.pu.ac.in/cgi-bin/login?username=$username&password=$password" > $HOME/.pucampus/.cred
	echo "Credentials successfully changed!!"	
}

function pulogin(){
	# Login to the network
	creds="`cat $HOME/.pucampus/.cred`"
	curl -k $creds
}

function pulogout(){
	# Logout from the network
	curl -k https://securelogin.pu.ac.in/cgi-bin/login\?cmd\=logout
}

function install(){
	# Creates App Directory
	echo "Copying files"
	cp ./pucampus.sh pucampus
	chmod +x ./pucampus
	sudo mv ./pucampus /usr/local/bin/
	echo "Copied successfully"

	mkdir -p $HOME/.pucampus

	# Creates Credentials File
	touch $HOME/.pucampus/.cred
	echo "0" > $HOME/.pucampus/.autologin

	if [ "`uname`" = "Linux" ]; then
		# Linux Case
		# Install in $HOME/.config/argos/
		mkdir -p $HOME/.config/argos/
		cp launcher.sh PULogin.5s.sh
		chmod +x PULogin.5s.sh
		mv PULogin.5s.sh $HOME/.config/argos/

	else
		# Mac Case
		# Install it in $HOME/Documents/bitbar
		mkdir -p $HOME/Documents/bitbar
		cp launcher.sh PULogin.5s.sh
		chmod +x PULogin.5s.sh
		mv PULogin.5s.sh $HOME/Documents/bitbar
	fi

}

function autoLoginEnable(){
	echo "1" > $HOME/.pucampus/.autologin
}

function autoLoginDisable(){
	echo "0" > $HOME/.pucampus/.autologin
}

function checkAutoLogin(){
	cat $HOME/.pucampus/.autologin
}

case "$1" in 
	"install")
		install
	;;
	"login")
		pulogin
	;;
	"logout")
		pulogout
	;;
	"change-credentials")
		changeCredentials
	;;
	"auto-login-enable")
		autoLoginEnable
	;;
	"auto-login-disable")
		autoLoginDisable
	;;
	"auto-login-status")
		checkAutoLogin
	;;
	*)
		echo "Invalid Command";

esac