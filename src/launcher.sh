#!/usr/bin/env bash

SSID="`iwgetid -r`"

if [ "$SSID" = "PU@CAMPUS" ]; then
	LOGINCHECKSTRING="`curl http://www.gstatic.com/generate_204`"
	LOGGEDOUT="`echo "$LOGINCHECKSTRING" | grep -c "html"`"

	if [ "$LOGGEDOUT" = "2" ]; then
		# If autoLogin Enabled, then Login 
		if [[ "`pucampus auto-login-status`" = "1" ]]; then
			pucampus login
		fi
		echo "<span color='orange'>PU CAMPUS</span> | refresh=true"
	else
		echo "<span color='lightgreen'>PU CAMPUS</span> | refresh=true"
	fi;

	echo "---"
	echo "✍Change Password | bash='pucampus change-credentials' terminal=true refresh=true"
	echo "🤟AutoLogin"
	echo "--Enable | bash='pucampus auto-login-enable' terminal=false refresh=true"
	echo "--Disable | bash='pucampus auto-login-disable' terminal=false refresh=true"
	echo "👋Logout | bash='pucampus logout' terminal=false refresh=true"
	echo "👆Login | bash='pucampus login'  terminal=false refresh=true"
else
	echo "<p></p>"
fi


