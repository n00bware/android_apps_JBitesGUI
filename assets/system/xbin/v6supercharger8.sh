#!/system/bin/sh
# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox.
echo "  REMINDER: ONLY USE BUSYBOX v1.18.2 OR LOWER!!"
#set -o errexit
cat > /sdcard/SuperCharger.html <<EOF
Hi! I hope that the V6 SuperCharger script is working well for you!<br>
<br>
First be sure to have <a href="http://market.android.com/details?id=com.jrummy.busybox.installer">BusyBox</a> installed or else the scripts won't work!<br>
Also, only install <b>BusyBox v1.18.2 or lower!</b> v1.18.3 and above sometimes give errors on some ROMs!<br>
<br>
A nice app for running the script is <a href="http://market.android.com/details?id=os.tools.scriptmanager">Script Manager</a><br>
It can even load scripts on boot - on ANY ROM!<br>
Plus, it even has WIDGETS!<br>
So you can actually put a V6 SuperCharger shortcut on your desktop, launch it, and have a quick peek at your current status!<br>
<br>
But first, you need to set up Script Manager properly!<br>
In the "Config" settings, enable "Browse as Root."<br>
Then browse to where you saved the V6 SuperCharger script, select it, and in the script's properties box, be sure to select "Run as Root."<br>
<b>Do NOT run this file at boot!</b> (You don't want to run the install on every boot, do you?)<br>
Run the V6 SuperCharger script, touch the screen to access the soft keyboard, and enter your choice :)<br>
<br>
<b>Stock ROMs</b>: After running the script, have Script Manager load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the "Config" settings, be sure that "Browse as Root" is enabled.<br>
Press the menu key and then Browser. Navigate up to the root, then click on the "data" folder.<br>
Click on 99SuperCharger.sh and select "Script" from the "Open As" menu.<br>
In the properties dialogue box, check "Run as root" and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically :)<br>
<br>
<b>Custom ROMs</b>: If you have a custom rom that loads /system/etc/init.d boot scripts,<br>
You DON'T need to use Script Manager to load a boot script. It will all be automatic!<br>
Also, if you can run boot scripts from the /system/etc/init.d folder, there are other options.<br>
For example you can use an app like Terminal Emulator to run the script.<br>
I've even made a special version for Terminal Emulator which has 60 colums :)<br>
If your ROM has the option, <b>DISABLE "Lock Home In Memory.</b> This takes effect immediately.<br>
Alternately, <u>if you need to free up extra ram</u>, you can use "Lock Home in Memory" as a "Saftey Lock".<br>
ie. Use it to toggle your launcher from "Bulletproof" (0) or Hard To Kill (1) to "Weak" (2) in the event that you want to make the launcher an easy kill and free up extra ram ;)<br>
<br>
<b>If Settings Don't Stick:</b> If you have Auto Memory Manager, DISABLE SuperUser permissions and if you have AutoKiller Memory Optimizer, DISABLE the apply settings at boot option!<br>
Also, if you have a <b>Custom ROM</b>, there might be something in the init.d folder that interferes with priorities and minfrees.<br>
If you can't find the problem, a quick fix is to have Script Manager run <b>/system/etc/init.d/99SuperCharger</b> "at boot" and "as root."<br>
<br>
For those with a <b>Milestone</b>, I made a version for <b>Androidiani Open Recovery</b> too :D<br>
Just extract the zip to the root of the sdcard (it contains the directory structure), load AOR, and there will be a SuperCharger Menu on the main screen! <br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
line=================================================
speed=2
sleep="sleep $speed"
unknown=0
ran=0
scminfree=
sccminfree=
smrun=`pgrep scriptmanager`
froyo=0
gb=0
launcheradj=$(cat /proc/`pidof com.android.launcher`/oom_adj);homeadj=`getprop ro.HOME_APP_ADJ`;FA=`getprop ro.FOREGROUND_APP_ADJ`;PA=`getprop ro.PERCEPTIBLE_APP_ADJ`;VA=`getprop ro.VISIBLE_APP_ADJ`
if [[ -z "$PA" ]]; then
	froyo=1
else
	gb=1
fi
while :
do
clear
echo "  REMINDER: ONLY USE BUSYBOX v1.18.2 OR LOWER!!"
echo ""
if [[ -n "$smrun" ]]; then
	echo "   Touch the screen to bring up soft keyboard."
else
	echo " Try Script Manager... it's easier!"
fi
echo ""
echo " Scrolling speed options..."
echo ""
echo " 0(no waiting), 1(fast), 2(normal), 3(slow)"
echo ""
echo -n " Please select scrolling speed (0 - 3): "
read cspeed
case $cspeed in
  0)sleep="sleep $cspeed";break;;
  1)sleep="sleep $cspeed";break;;
  2)sleep="sleep $cspeed";break;;
  3)sleep="sleep $cspeed";break;;
  *)echo ""
	echo "      Invalid entry... Please try again :)"
	$sleep;;
esac
done
if [[ -n "$launcheradj" ]] && [ "$launcheradj" -gt -20 ] 2>/dev/null; then
	HL="$launcheradj"
else
	HL="$homeadj"
	unknown=1
	echo ""
	echo $line
	echo ""
	$sleep
	echo " If Home is Locked in Memory..."
	echo ""
	$sleep
	echo " ..confirm status via Status Checker!(Option 1)"
fi
$sleep
if [ -f "/data/SuperChargerMinfree" ]; then
	cp -fr /data/SuperChargerMinfree /data/SuperChargerMinfreeOld
	scminfree=`cat /data/SuperChargerMinfree`
fi
while :
echo ""
do
 MB0=4;MB1=0;MB2=0;MB3=0;MB4=0;MB5=0;MB6=0
 SP1=0;SL1=0;SL2=0;SL3=0;SL4=0;SL5=0;SL6=0
 error=0;restore=0;rc=0;rcbu=0;UnSuperCharged=0;UnSuperChargerError=0;SuperChargerScriptManagerHelp=0;SuperChargerHelp=0
 rcpath="/system/etc/rootfs/init.mapphone_umts.rc"
 rcfile=${rcpath##*/}
 rcbackup="$rcpath.unsuper"
 if [ -e "$rcpath" ]; then
	rc=1
 fi
 if [ -e "$rcbackup" ]; then
	rcbu=1
 fi
 currentminfree=`cat /sys/module/lowmemorykiller/parameters/minfree`
 if [ -f "/data/SuperChargerCustomMinfree" ]; then
	sccminfree=`cat /data/SuperChargerCustomMinfree`
 fi
 echo $line
 echo "For help and info, see /sdcard/SuperCharger.html"
 echo $line
 $sleep
 echo "\\\\\\\\ V 6  S U P E R C H A R G E R - M E N U ////"
 echo " =============================================="
 echo " 1. SuperCharger & Launcher Status for Update 8"
 echo " 2. Aggressive 1 Settings  {6,8,24,30,40,50 mb}"
 echo " 3. Aggressive 2 Settings  {6,8,25,30,35,35 mb}"
 echo " 4. Balanced 1 Settings    {6,8,24,26,28,30 mb}"
 echo " 5. Balanced 2 Settings    {6,8,26,27,28,28 mb}"
 echo " 6. Balanced 3 Settings    {6,8,26,28,30,32 mb}"
 echo " 7. MultiTasking Settings  {6,8,22,24,26,26 mb}"
 echo " 8. MegaRAM 1 w/512mb    {6,12,40,60,80,100 mb}"
 echo " 9. MegaRAM 2 w/512mb  {6,12,75,100,125,150 mb}"
 echo -n "10. Cust-OOMizer"
 if [ -f "/data/SuperChargerCustomMinfree" ]; then
	awk -F , '{print "       {"$1/256","$2/256","$3/256","$4/256","$5/256","$6/256 " mb}"}' /data/SuperChargerCustomMinfree
 else
	echo " Settings  {Create Or Restore!}"
 fi
 echo "11. OOM Grouping Fixes + Hard To Kill Launcher"
 echo "12. OOM Grouping Fixes + BulletProof Launcher"
 echo "13. UnKernelizer - UnDo Kernel/Memory Tweaks"
 echo "14. UnSuperCharger"
 echo "15. Use V6 SuperCharger with Terminal Emulator!"
 echo "16. REBOOT! (WARNING - There is NO Warning!)"
 echo "17. Exit"
 echo ""
 echo -n "   Launcher is";
 if [ "$HL" -gt "$VA" ]; then
	echo ".... so.... weak.... :("
	status=4
 elif [ "$HL" -eq "$VA" ]; then
	echo " Locked In Memory ie. Very Weak!"
	status=3
 elif [ "$froyo" -eq 1 ]; then
	if [ "$HL" -eq "$FA" ]; then
		echo -n " BULLETPROOF!"
		status=1
	else
		echo -n " HARD TO KILL!"
		status=2
	fi
	echo " ie. SUPERCHARGED!"
 else
	if [ "$HL" -ge "$FA" ] && [ "$HL" -lt "$PA" ]; then
		echo -n " BULLETPROOF!"
		status=1
	else
		echo -n " HARD TO KILL!"
		status=2
	fi
	echo " ie. SUPERCHARGED!"
 fi
 if [ "$ran" -eq 0 ]; then
	if [[ -n "$scminfree" ]] && [ "$currentminfree" != "$scminfree" ]; then
		echo "   Current Values DON'T MATCH Prior SuperCharge!"
	elif [[ -n "$scminfree" ]] && [ "$currentminfree" == "$scminfree" ];then
		echo "   Current Values MATCH Prior SuperCharge!"
	fi
 fi
 if [[ -z "$scminfree" ]]; then
	echo "   SuperCharger Minfrees NOT FOUND! Have Fun!"
 fi
 echo ""
 awk -F , '{print "   Current minfrees = "$1/256","$2/256","$3/256","$4/256","$5/256","$6/256 " mb"}' /sys/module/lowmemorykiller/parameters/minfree
 if [ -f "/data/SuperChargerMinfreeOld" ]; then
	awk -F , '{print "  Prior V6 minfrees = "$1/256","$2/256","$3/256","$4/256","$5/256","$6/256 " mb"}' /data/SuperChargerMinfreeOld
 fi
 echo ""
 echo " Slot 3 Sets Free RAM & is your New Task Killer!"
 echo " Lag? Disable Lock Home in Memory & Compcache!"
 echo ""
 if [[ -n "$smrun" ]]; then
	echo " In Config, select Run as Root & Browse as Root!"
	echo " But DO NOT run this script at boot!"
	echo " For a quick status check..."
	echo " ...put a V6 SuperCharger WIDGET on the desktop!"
 else
	echo "   Optimized for display with Script Manager."
	echo ""
	echo " SM can give you a quick status check..."
	echo " ...Put a V6 SuperCharger WIDGET on the desktop!"
	echo "                                   ...Try it! :)"
	echo ""
 fi
 echo ""
 echo -n " Please enter option [1 - 17]: "
 read opt
 echo ""
 $sleep
 if [ "$opt" -ne 17 ] 2>/dev/null; then
	mount -o remount,rw /system 2>/dev/null
	for m in /dev/block/mtdblock*
	do
	mount -o remount,rw $m /system 2>/dev/null
	done
 fi
 echo $line
 echo "            \\\\\\\\ V6 SUPERCHARGER ////"
 echo "             ======================="
 echo ""
 $sleep
case $opt in
  1) echo "      V6 SUPERCHARGER AND LAUNCHER STATUS!";;
  2) echo "      AGGRESSIVE 1 + HARD TO KILL LAUNCHER!"
	 CONFIG="Aggressive 1"
	 MB1=6;MB2=8;MB3=24;MB4=30;MB5=40;MB6=50;;
  3) echo "      AGGRESSIVE 2 + HARD TO KILL LAUNCHER!"
	 CONFIG="Aggressive 2"
	 MB1=6;MB2=8;MB3=25;MB4=30;MB5=35;MB6=35;;
  4) echo "       BALANCED 1 + HARD TO KILL LAUNCHER!"
	 CONFIG="Balanced 1"
	 MB1=6;MB2=8;MB3=24;MB4=26;MB5=28;MB6=30;;
  5) echo "       BALANCED 2 + HARD TO KILL LAUNCHER!"
	 CONFIG="Balanced 2"
	 MB1=6;MB2=8;MB3=26;MB4=27;MB5=28;MB6=28;;
  6) echo "       BALANCED 3 + HARD TO KILL LAUNCHER!"
	 CONFIG="Balanced 3"
	 MB1=6;MB2=8;MB3=26;MB4=28;MB5=30;MB6=32;;
  7) echo "      MULTITASKING + HARD TO KILL LAUNCHER!"
	 CONFIG="MultiTasking"
	 MB1=6;MB2=8;MB3=22;MB4=24;MB5=26;MB6=26;;
  8) echo "       MEGA RAM 1 + HARD TO KILL LAUNCHER!"
	 CONFIG="MegaRAM 1"
	 MB1=6;MB2=12;MB3=40;MB4=60;MB5=80;MB6=100;;
  9) echo "       MEGA RAM 2 + HARD TO KILL LAUNCHER!"
	 CONFIG="MegaRAM 2"
	 MB1=6;MB2=12;MB3=75;MB4=100;MB5=125;MB6=150;;
  10)echo "      CUST-OOMIZER + HARD TO KILL LAUNCHER!"
	 CONFIG="CUST-OOMIZED"
	 if [ -f "/data/SuperChargerCustomMinfree" ]; then
		echo $line
		echo ""
		$sleep
		echo " Your Prior CUST-OOMIZED values are..."
		echo ""
		$sleep
		awk -F , '{print "               "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " mb"}' /data/SuperChargerCustomMinfree
		echo ""
		$sleep
		echo " Your Current Minfree values are..."
		echo ""
		$sleep
		awk -F , '{print "               "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " mb"}' /sys/module/lowmemorykiller/parameters/minfree
		echo ""
		$sleep
		if [ "$currentminfree" == "$sccminfree" ]; then
			echo " Even though they are the same..."
			echo ""
			$sleep
		fi
		echo -n " Restore Previous CUST-OOMIZED settings"
		if [ "$currentminfree" == "$sccminfree" ]; then
			echo " anyway?"
		else
			echo "?"
		fi
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read crestore
		echo ""
		echo $line
		case $crestore in
		  y|Y)restore=1
			  MB1=`awk -F , '{print $1/256}' /data/SuperChargerCustomMinfree`;MB2=`awk -F , '{print $2/256}' /data/SuperChargerCustomMinfree`;MB3=`awk -F , '{print $3/256}' /data/SuperChargerCustomMinfree`;MB4=`awk -F , '{print $4/256}' /data/SuperChargerCustomMinfree`;MB5=`awk -F , '{print $5/256}' /data/SuperChargerCustomMinfree`;MB6=`awk -F , '{print $6/256}' /data/SuperChargerCustomMinfree`;
			  echo "    Cust-OOMized Settings will be Restored!";;
		  *)echo " Running CUST-OOMIZER...";;
		esac
	 fi
	 if [ "$restore" -eq 0 ] 2>/dev/null; then
		echo $line
		echo ""
		$sleep
		echo " Enter your desired lowmemorykiller OOM levels!"
		echo ""
		$sleep
		echo " Slot 3 determines your fee ram the most!!"
		echo ""
		$sleep
		echo " To restart, enter a letter to go to main menu."
		echo ""
		$sleep
		echo -n "              Slot 1: ";read MB1
		if [ "$MB1" -gt 0 ] 2>/dev/null; then
			echo -n "                Slot 2: ";read MB2
			if [ "$MB2" -gt 0 ] 2>/dev/null; then
				echo -n "                  Slot 3: ";read MB3
				if [ "$MB3" -gt 0 ] 2>/dev/null; then
					echo -n "                    Slot 4: ";read MB4
					if [ "$MB4" -gt 0 ] 2>/dev/null; then
						echo -n "                      Slot 5: ";read MB5
						if [ "$MB5" -gt 0 ] 2>/dev/null; then
							echo -n "                        Slot 6: ";read MB6
							if [ "$MB6" -gt 0 ] 2>/dev/null; then
								echo ""
								echo $line
								echo "        Cust-OOMized Settings Accepted!"
							else
								error=1
							fi
						else
							error=1
						fi
					else
						error=1
					fi
				else
					error=1
				fi
			else
				error=1
			fi
		else
			error=1
		fi
	 fi;;
  11)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                      ...HARD TO KILL LAUNCHER!";;
  12)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                       ...BULLETPROOF LAUNCHER!";;
  13)echo "              ===================="
	 echo "             //// UNKERNELIZER \\\\\\\\"
	 if [ ! -f "/system/etc/init.d/99SuperCharger" ] && [ ! -f "/data/99SuperCharger.sh" ] && [ "$rc" -ne 1 ]; then
		 echo $line
		 echo ""
		 $sleep
		 echo " There's Nothing to UnKernelize!"
		 echo ""
		 opt=0
	 fi;;
  14)echo "             ======================"
	 echo "            //// UNSUPERCHARGER \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " WHAT? UnSuperCharge? Are you sure?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read unsuper
	 echo ""
	 echo $line
	 case $unsuper in
	   y|Y)echo " Well... okay then... be like that! :p";;
	   *)echo " False alarm... *whew*"
		 opt=0;;
	 esac;;
  15)echo "             ======================"
	 echo "            //// SYSTEM INSTALL \\\\\\\\";;
  16)echo "                    !!POOF!!"
	 $sleep
	 reboot;;
  17)echo " Did you find this useful? Feedback is welcome!";;
  *) echo "   #!*@%$*?%@&)&*#!*?(*)(*)&(!)%#!&?@#$*%&?&$%$*#?!"
	 echo ""
	 sleep 2
	 echo "     oops.. typo?!  $opt is an Invalid Option!"
	 echo ""
	 sleep 2
	 echo "            1 <= Valid Option => 17 !!";
	 echo ""
	 sleep 2
	 echo -n "    hehe... Press Enter key to continue... ;) ";
	 read enterKey
	 echo ""
	 opt=0;;
esac
echo $line
echo ""
$sleep
if [ "$error" -eq 1 ]; then
	echo "           Input Error! Try again :)"
	sleep 2
elif [ "$opt" -eq 1 ]; then
	echo " Out Of Memory (OOM) / lowmemorykiller values:"
	echo ""
	$sleep
	echo "        "$currentminfree pages
	echo ""
	$sleep
	awk -F , '{print "  Which means: "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " mb"}' /sys/module/lowmemorykiller/parameters/minfree
	echo ""
	echo $line
	echo ""
	$sleep
	if [ "$unknown" -eq 1 ]; then
		echo " Is Home is Locked in Memory?"
		echo ""
		$sleep
		echo -n " If it is, Enter Y for Yes, any key for No: "
		read homelocked
		echo ""
		echo $line
		echo ""
		$sleep
		case $homelocked in
		  y|Y)unknown=0
			  HL="$VA"
			  if [ "$HL" -gt "$VA" ]; then
				status=4
			  elif [ "$HL" -eq "$VA" ]; then
				status=3
			  elif [ "$froyo" -eq 1 ]; then
				if [ "$HL" -eq "$FA" ]; then
					status=1
				else
					status=2
				fi
			  else
				if [ "$HL" -ge "$FA" ] && [ "$HL" -lt "$PA" ]; then
					status=1
				else
					status=2
				fi
			  fi;;
		  *)unknown=0;;
		esac
	fi
	echo "           Home Launcher Priority is: $HL"
	echo ""
	$sleep
	echo "          Foreground App Priority is: $FA"
	echo ""
	$sleep
	if [ "$gb" -eq 1 ]; then
		echo "         Perceptible App Priority is: $PA"
		echo ""
		$sleep
	fi
	echo "             Visible App Priority is: $VA"
	echo ""
	echo $line
	echo ""
	$sleep
	if [ "$status" -eq 4 ]; then
		echo " Launcher is greater than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "     Wow, that's one weak ass launcher! :("
	elif [ "$status" -eq 3 ]; then
		echo " Launcher is equal to Visible App..."
		echo ""
		$sleep
		echo "          ...Home Launcher is Locked In Memory!"
		echo ""
		$sleep
		echo $line
		echo "      meh... that's still pretty weak! :P"
	elif [ "$status" -eq 1 ]; then
		if [ "$froyo" -eq 1 ]; then
			echo " Launcher is equal to Foreground App..."
		else
			echo " Launcher is greater than Foreground App..."
			echo ""
			$sleep
			echo "           ...is less than Perceptible App..."
		fi
		echo ""
		$sleep
		echo "             ...and is less than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "         Home Launcher is BULLETPROOF!"
	else
		echo " Launcher is greater than Foreground App..."
		echo ""
		$sleep
		if [ "$gb" -eq 1 ]; then
			echo "            ...is equal to Perceptible App..."
			echo ""
			$sleep
		fi
		echo "             ...and is less than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "      Home Launcher is very HARD TO KILL!"
	fi
	echo $line
	echo ""
	$sleep
	echo " SuperCharger and Launcher Status..."
	echo ""
	$sleep
	echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
	sleep 2
else
	if [ "$opt" -ge 2 ] && [ "$opt" -le 14 ]; then
		if [ "$opt" -le 10 ]; then
			SP1=$(($MB0*256));SL1=$(($MB1*256));SL2=$(($MB2*256));SL3=$(($MB3*256));SL4=$(($MB4*256));SL5=$(($MB5*256));SL6=$(($MB6*256))
			echo " zoom... zoom..."
			echo ""
			$sleep
		fi
		if [ "$opt" -le 12 ]; then
			echo "=============  Information Section  ============"
			echo "             ======================="
			echo ""
			$sleep
		fi
		if [ "$opt" -ne 13 ]; then
			if [ -f "/sdcard/UnSuperCharged.html" ]; then
				rm /sdcard/UnSuperCharged.html
			fi
			if [ -f "/sdcard/UnSuperChargerError.html" ]; then
				rm /sdcard/UnSuperChargerError.html
			fi
			if [ -f "/sdcard/SuperChargerScriptManagerHelp.html" ]; then
				rm /sdcard/SuperChargerScriptManagerHelp.html
			fi
			if [ -f "/sdcard/SuperChargerHelp.html" ]; then
				rm /sdcard/SuperChargerHelp.html
			fi
			if [ -f "/data/local/userinit.sh" ]; then
				sed -i '/.*99SuperCharger/d' /data/local/userinit.sh
			fi
			if [ -f "/data/local.prop" ]; then
				sed -i '/.*_ADJ/d' /data/local.prop
			fi
		fi
		if [ "$opt" -le 13 ] && [ "$rc" -eq 1 ]; then
			echo " Found "$rcpath
			echo ""
			$sleep
			if [ "$opt" -eq 11 ] || [ "$opt" -eq 12 ]; then
				echo " $rcfile will be OOM Fixed!"
			elif [ "$opt" -eq 13 ]; then
				echo " $rcfile to be UnKernelized!"
			else
				echo " $rcfile to be SuperCharged!"
			fi
			echo ""
			$sleep
			if [ "$rcbu" -eq 1 ]; then
				echo " Backup already exists... leaving backup intact"
			else
				cp -r $rcpath $rcbackup
				echo " Backing up ORIGINAL settings..."
			fi
			echo ""
			$sleep
		fi
		if [ "$opt" -eq 14 ]; then
			echo " UNSUPERCHARGE..."
			echo ""
			sleep 1
			echo "       ...UNFIX OOM GROUPINGS..."
			echo ""
			sleep 1
			echo "                   ...RESTORE WEAK ASS LAUNCHER"
			echo ""
			echo $line
			echo ""
			$sleep
			echo " UnSuperCharging Performance...."
			echo ""
			$sleep
			scminfree=
			sccminfree=
			if [ ! -f "/system/etc/init.d/99SuperCharger" ] && [ ! -f "/data/99SuperCharger.sh" ] && [ "$rc" -ne 1 ] && [ "$rcbu" -ne 1 ]; then
				echo " I Got Nothing To Do! Try SuperCharging first!"
				echo ""
				$sleep
				UnSuperCharged=1
cat > /sdcard/UnSuperCharged.html <<EOF
There was nothing to uninstall!<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
				echo $line
				echo " See /sdcard/UnSuperCharged.html for assistance!"
				echo $line
				echo ""
				$sleep
			fi
			if [ "$rcbu" -eq 1 ]; then
				echo "                 BACKUP FOUND!"
				echo ""
				$sleep
				echo " Restore"$rcpath
				echo ""
				$sleep
				cp -fr $rcbackup $rcpath
				rm $rcbackup
			elif [ "$rc" -eq 1 ]; then
				echo "      ERROR... ERROR... ERROR... ERROR..."
				echo ""
				$sleep
				echo "               BACKUP NOT FOUND!"
				echo ""
				$sleep
				echo "CAN'T restore your ROM's default minfree values!"
				echo ""
				sleep 3
				UnSuperChargerError=1
cat > /sdcard/UnSuperChargerError.html <<EOF
The backup file, $rcbackup, WAS NOT found!<br>
Please do a manual restore of $rcfile from your ROM's update file!<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
				echo $line
				echo " See /sdcard/UnSuperChargerError.html for help!"
				echo $line
				echo ""
				sleep 4
				echo " Clean "$rcpath
				echo ""
				sed -i '/.*_ADJ/d' $rcpath
				sed -i '/parameters\/adj/d' $rcpath
				sed -i '/vm\/.*oom.*/d' $rcpath
				sed -i '/kernel\/panic.*/d' $rcpath
				$sleep
			fi
		fi
		if [ "$opt" -le 10 ] || [ "$opt" -eq 14 ]; then
			if [ -f "/data/local.prop" ]; then
				sed -i '/.*_MEM/d' /data/local.prop
			fi
		fi
		if [ "$opt" -ne 13 ]; then
			if [ -f "/system/etc/init.d/99SuperCharger" ]; then
				if [ "$opt" -ne 11 ] && [ "$opt" -ne 12 ]; then
					echo " Cleaning Up SuperCharge from /init.d folder"
					echo ""
					$sleep
				fi
				echo " Cleaning Up Grouping Fixes from /init.d folder"
				echo ""
				rm /system/etc/init.d/99SuperCharger
				$sleep
			fi
			if [ -f "/data/99SuperCharger.sh" ]; then
				if [ "$opt" -ne 11 ] && [ "$opt" -ne 12 ]; then
					echo " Cleaning Up SuperCharge from /data folder"
					echo ""
					$sleep
				fi
				echo " Cleaning Up Grouping Fixes from /data folder"
				echo ""
				rm /data/99SuperCharger.sh
				$sleep
			fi
		fi
		if [ "$opt" -eq 14 ]; then
			if [ -f "/data/SuperChargerAdj" ]; then
				rm /data/SuperChargerAdj
			fi
			if [ -f "/data/SuperChargerMinfree" ]; then
				rm /data/SuperChargerMinfree
			fi
			if [ -f "/data/SuperChargerMinfreeOld" ]; then
				rm /data/SuperChargerMinfreeOld
			fi
			if [ -f "/data/SuperChargerCustomMinfree" ]; then
				rm /data/SuperChargerCustomMinfree
			fi
			if [ "$UnSuperCharged" -ne 1 ]; then
				echo " Removed Kernel/Memory Tweaks..."
				echo ""
				$sleep
				if [ "$UnSuperChargerError" -ne 1 ]; then
					echo " Your ROM's default minfree values are restored!"
					echo ""
					$sleep
				fi
				echo " Out Of Memory (OOM) Groupings UnFixed..."
				echo ""
				$sleep
				echo "                ...OOM Priorities UnFixed..."
				echo ""
				$sleep
				echo "                  Weak Ass Launcher Restored :("
				echo ""
				$sleep
				echo " UnSuperCharging Complete..."
				echo ""
				echo $line
				echo ""
				$sleep
				echo " REBOOT NOW..."
				echo ""
				$sleep
				echo "           ...FOR UNSUPERCHARGE TO TAKE EFFECT!"
				echo ""
				echo $line
				echo ""
				$sleep
			fi
			echo " UnSuperCharging..."
			echo ""
			$sleep
			echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
			sleep 2
		fi
		if [ "$opt" -le 13 ]; then
			if [ "$opt" -eq 13 ]; then
				echo " Removing Kernel/Memory Tweaks..."
				echo ""
				$sleep
			fi
			if [ "$rc" -eq 1 ]; then
				if [ "$opt" -ne 13 ]; then
					sed -i '/.*_ADJ/d' $rcpath
				fi
				if [ "$opt" -eq 11 ] || [ "$opt" -eq 12 ]; then
					sed -i '/parameters\/adj/d' $rcpath
				fi
				if [ "$opt" -le 10 ]; then
					sed -i '/.*_MEM/d' $rcpath
					sed -i '/lowmemorykiller/d' $rcpath
				fi
				sed -i '/vm\/.*oom.*/d' $rcpath
				sed -i '/kernel\/panic.*/d' $rcpath
			fi
			if [ -f "/system/etc/init.d/99SuperCharger" ]; then
				sed -i '/.*oom.*/d' /system/etc/init.d/99SuperCharger
				sed -i '/.*panic.*/d' /system/etc/init.d/99SuperCharger
			fi
			if [ -f "/data/99SuperCharger.sh" ]; then
				sed -i '/.*oom.*/d' /data/99SuperCharger.sh
				sed -i '/.*panic.*/d' /data/99SuperCharger.sh
			fi
			if [ "$opt" -eq 13 ]; then
				echo "               ...Kernel/Memory Tweaks Removed!"
				$sleep
			fi
		fi
		if [ "$opt" -le 12 ]; then
			echo "0,3,5,7,14,15" > /data/SuperChargerAdj
			scadj=`cat /data/SuperChargerAdj`
			adj1=`awk -F , '{print $1}' /data/SuperChargerAdj`;adj2=`awk -F , '{print $2}' /data/SuperChargerAdj`;adj3=`awk -F , '{print $3}' /data/SuperChargerAdj`;adj4=`awk -F , '{print $4}' /data/SuperChargerAdj`;adj5=`awk -F , '{print $5}' /data/SuperChargerAdj`;adj6=`awk -F , '{print $6}' /data/SuperChargerAdj`
			if [ "$opt" -le 10 ]; then
				if [ -f "/data/SuperChargerMinfree" ]; then
					cp -fr /data/SuperChargerMinfree /data/SuperChargerMinfreeOld
				fi
				echo "$SL1,$SL2,$SL3,$SL4,$SL5,$SL6" > /data/SuperChargerMinfree
				scminfree=`cat /data/SuperChargerMinfree`
				if [ "$opt" -eq 10 ]; then
					if [ "$restore" -eq 1 ]; then
						echo "   Restoring Prior CUST-OOMIZED Settings!"
					else
						if [ -f "/data/SuperChargerCustomMinfree" ]; then
							echo " Removing Prior Cust-OOMized Settings..."
							echo ""
							$sleep
						fi
						echo "   Backing Up Your New CUST-OOMIZED Settings!"
					fi
					cp -fr /data/SuperChargerMinfree /data/SuperChargerCustomMinfree
					echo ""
					$sleep
				fi
			fi
			echo $line
			if [ "$opt" -le 10 ]; then
				echo " SuperCharging Performance: $CONFIG!"
				echo $line
				echo ""
				$sleep
				echo " Out Of Memory (OOM) / lowmemorykiller values:"
				echo ""
				$sleep
				awk -F , '{print "    Old MB = "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " mb"}' /sys/module/lowmemorykiller/parameters/minfree
				echo "    New MB = $MB1, $MB2, $MB3, $MB4, $MB5, $MB6 mb"
				echo ""
				$sleep
				echo " Old Pages = "$currentminfree
				echo " New Pages = $scminfree"
			fi
			echo ""
			$sleep
			echo " Fixing Out Of Memory (OOM) Groupings..."
			echo ""
			$sleep
			if [ "$rc" -eq 1 ]; then
				sed -i '/on boot/ a\
    write /sys/module/lowmemorykiller/parameters/adj '$scadj $rcpath
				echo "                    ...Fixing OOM Priorities..."
				echo ""
				$sleep
				sed -i '/on early/ a\
    setprop ro.FOREGROUND_APP_ADJ '$adj1 $rcpath
				sed -i '/ro.FOREGROUND_APP_ADJ/ a\
    setprop ro.VISIBLE_APP_ADJ '$adj2 $rcpath
				sed -i '/ro.VISIBLE_APP_ADJ/ a\
    setprop ro.SECONDARY_SERVER_ADJ '$adj3 $rcpath
				sed -i '/ro.SECONDARY_SERVER_ADJ/ a\
    setprop ro.BACKUP_APP_ADJ '$(($adj4-1)) $rcpath
				sed -i '/ro.BACKUP_APP_ADJ/ a\
    setprop ro.HOME_APP_ADJ '$adj2 $rcpath
				sed -i '/ro.HOME_APP_ADJ/ a\
    setprop ro.HIDDEN_APP_MIN_ADJ '$adj4 $rcpath
				sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
    setprop ro.EMPTY_APP_ADJ '$adj6 $rcpath
				if [ "$gb" -eq 1 ]; then
					sed -i '/ro.VISIBLE_APP_ADJ/ a\
    setprop ro.PERCEPTIBLE_APP_ADJ '$(($adj2-1)) $rcpath
					sed -i '/ro.PERCEPTIBLE_APP_ADJ/ a\
    setprop ro.HEAVY_WEIGHT_APP_ADJ '$(($adj3-1)) $rcpath
				else
					sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
    setprop ro.CONTENT_PROVIDER_ADJ '$(($adj5-6)) $rcpath
				fi
				echo " ...OOM Groupings and Priorities are now fixed!"
				echo ""
				$sleep
				if [ "$opt" -eq 12 ]; then
					echo " Applying BulletProof Launcher..."
					echo ""
					$sleep
					if [ "$froyo" -eq 1 ]; then
						sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$adj1/ $rcpath
					else
						sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$(($adj2-2))/ $rcpath
					fi
					echo " Launcher is no Longer Hard To Kill..."
					echo ""
					$sleep
					echo "                           ...It's BULLETPROOF!"
				else
					echo " Applying Hard To Kill Launcher..."
					echo ""
					$sleep
					if [ "$froyo" -eq 1 ]; then
						sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$(($adj2-2))/ $rcpath
					else
						sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$(($adj2-1))/ $rcpath
					fi
					echo "              ...Hard To Kill Launcher APPLIED!"
				fi
				echo ""
				$sleep
				if [ "$opt" -le 10 ]; then
					sed -i '/lowmemorykiller/ a\
    write /sys/module/lowmemorykiller/parameters/minfree '$scminfree $rcpath
					sed -i '/ro.EMPTY_APP_ADJ/ a\
    setprop ro.FOREGROUND_APP_MEM '$SL1 $rcpath
					sed -i '/ro.FOREGROUND_APP_MEM/ a\
    setprop ro.VISIBLE_APP_MEM '$SL2 $rcpath
					sed -i '/ro.VISIBLE_APP_MEM/ a\
    setprop ro.SECONDARY_SERVER_MEM '$SL3 $rcpath
					sed -i '/ro.SECONDARY_SERVER_MEM/ a\
    setprop ro.BACKUP_APP_MEM '$SL4 $rcpath
					sed -i '/ro.BACKUP_APP_MEM/ a\
    setprop ro.HOME_APP_MEM '$SP1 $rcpath
					sed -i '/ro.HOME_APP_MEM/ a\
    setprop ro.HIDDEN_APP_MEM '$SL4 $rcpath
					sed -i '/ro.HIDDEN_APP_MEM/ a\
    setprop ro.EMPTY_APP_MEM '$SL6 $rcpath
					if [ "$gb" -eq 1 ]; then
						sed -i '/ro.VISIBLE_APP_MEM/ a\
    setprop ro.PERCEPTIBLE_APP_MEM '$SP1 $rcpath
						sed -i '/ro.PERCEPTIBLE_APP_MEM/ a\
    setprop ro.HEAVY_WEIGHT_APP_MEM '$SL3 $rcpath
					else
						sed -i '/ro.HIDDEN_APP_MEM/ a\
    setprop ro.CONTENT_PROVIDER_MEM '$SL5 $rcpath
					fi
				fi
				echo " Applying Kernel/Memory Tweaks..."
				echo ""
				$sleep
				echo "     oom_kill_allocating_task = 0"
				echo "                 panic_on_oom = 0"
				echo "                panic_on_oops = 1"
				echo "                        panic = 0"
				echo ""
				$sleep
				sed -i '/minfree/ a\
    write /proc/sys/vm/oom_kill_allocating_task 0' $rcpath
				sed -i '/oom_kill_allocating_task/ a\
    write /proc/sys/vm/panic_on_oom 0' $rcpath
				sed -i '/panic_on_oom/ a\
    write /proc/sys/kernel/panic_on_oops 1' $rcpath
				sed -i '/panic_on_oops/ a\
    write /proc/sys/kernel/panic 0' $rcpath
			else
				echo "                    ...Fixing OOM Priorities..."
				echo ""
				$sleep
				echo "ro.FOREGROUND_APP_ADJ=$adj1" >> /data/local.prop
				echo "ro.VISIBLE_APP_ADJ=$adj2" >> /data/local.prop
				if [ "$gb" -eq 1 ]; then
					echo "ro.PERCEPTIBLE_APP_ADJ=$(($adj2-1))" >> /data/local.prop
					echo "ro.HEAVY_WEIGHT_APP_ADJ=$(($adj3-1))" >> /data/local.prop
				fi
				echo "ro.SECONDARY_SERVER_ADJ=$adj3" >> /data/local.prop
				echo "ro.BACKUP_APP_ADJ=$(($adj4-1))" >> /data/local.prop
				echo "ro.HOME_APP_ADJ=$adj2" >> /data/local.prop
				echo "ro.HIDDEN_APP_MIN_ADJ=$adj4" >> /data/local.prop
				if [ "$froyo" -eq 1 ]; then
					echo "ro.CONTENT_PROVIDER_ADJ=$(($adj5-6))" >> /data/local.prop
				fi
				echo "ro.EMPTY_APP_ADJ=$adj6" >> /data/local.prop
				echo " ...OOM Groupings and Priorities are now fixed!"
				echo ""
				$sleep
				if [ "$opt" -eq 12 ]; then
					echo " Applying BulletProof Launcher..."
					echo ""
					$sleep
					if [ "$froyo" -eq 1 ]; then
						sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$adj1/ /data/local.prop
					else
						sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$(($adj2-2))/ /data/local.prop
					fi
					echo " Launcher is no Longer Hard To Kill..."
					echo ""
					$sleep
					echo "                           ...It's BULLETPROOF!"
				else
					echo " Applying Hard To Kill Launcher..."
					echo ""
					$sleep
					if [ "$froyo" -eq 1 ]; then
						sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$(($adj2-2))/ /data/local.prop
					else
						sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$(($adj2-1))/ /data/local.prop
					fi
					echo "              ...Hard To Kill Launcher APPLIED!"
				fi
				echo ""
				$sleep
				if [ "$opt" -le 10 ]; then
					echo "ro.FOREGROUND_APP_MEM=$SL1" >> /data/local.prop
					echo "ro.VISIBLE_APP_MEM=$SL2" >> /data/local.prop
					if [ "$gb" -eq 1 ]; then
						echo "ro.PERCEPTIBLE_APP_MEM=$SP1" >> /data/local.prop
						echo "ro.HEAVY_WEIGHT_APP_MEM=$SL3" >> /data/local.prop
					fi
					echo "ro.SECONDARY_SERVER_MEM=$SL3" >> /data/local.prop
					echo "ro.BACKUP_APP_MEM=$SL4" >> /data/local.prop
					echo "ro.HOME_APP_MEM=$SP1" >> /data/local.prop
					echo "ro.HIDDEN_APP_MEM=$SL4" >> /data/local.prop
					if [ "$froyo" -eq 1 ]; then
						echo "ro.CONTENT_PROVIDER_MEM=$SL5" >> /data/local.prop
					fi
					echo "ro.EMPTY_APP_MEM=$SL6" >> /data/local.prop
				fi
				echo " Applying Kernel/Memory Tweaks..."
				echo ""
				$sleep
				echo "         oom_kill_allocating_task = 0"
				echo "                     panic_on_oom = 0"
				echo "                    panic_on_oops = 1"
				echo "                            panic = 0"
				echo ""
				$sleep
cat > /data/99SuperCharger.sh <<EOF
#!/system/bin/sh
# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox.
execute=0;
currentadj=\`cat /sys/module/lowmemorykiller/parameters/adj\`;
currentminfree=\`cat /sys/module/lowmemorykiller/parameters/minfree\`;
scadj=\`cat /data/SuperChargerAdj\`;
scminfree=\`cat /data/SuperChargerMinfree\`;
if [ "\$currentadj" != "\$scadj" ]; then
	execute=1;
elif [[ -n "\$scminfree" ]] && [ "\$currentminfree" != "\$scminfree" ]; then
	execute=1;
fi;
if [ "\$execute" -eq 1 ]; then
	echo \$scadj > /sys/module/lowmemorykiller/parameters/adj;
EOF
				if [ -f "/data/SuperChargerMinfree" ]; then
					echo "	echo "\$scminfree" > /sys/module/lowmemorykiller/parameters/minfree;" >> /data/99SuperCharger.sh
				fi
cat >> /data/99SuperCharger.sh <<EOF
	echo "0" > /proc/sys/vm/oom_kill_allocating_task;
	echo "0" > /proc/sys/vm/panic_on_oom;
	busybox sysctl -w kernel.panic_on_oops=1;
	busybox sysctl -w kernel.panic=0;
fi;
EOF
				chown 0.0 /data/99SuperCharger.sh
				chmod 777 /data/99SuperCharger.sh
					if [ ! -f "/data/local/userinit.sh" ]; then
						echo "#!/system/bin/sh" > /data/local/userinit.sh;
					fi
					echo "sh /data/99SuperCharger.sh;" >> /data/local/userinit.sh
					chown 0.0 /data/local/userinit.sh
					chmod 777 /data/local/userinit.sh
				if [ -d "/system/etc/init.d" ]; then
					cp -fr /data/99SuperCharger.sh /system/etc/init.d/99SuperCharger
					echo "sh /data/99SuperCharger.sh;" >> /system/etc/init.d/99SuperCharger
					chown 0.0 /system/etc/init.d/99SuperCharger
					chmod 777 /system/etc/init.d/99SuperCharger
					echo "sh /system/etc/init.d/99SuperCharger;" >> /data/local/userinit.sh
				else
					echo $line
					echo ""
					$sleep
					echo " Stock ROM? - Additional Configuration Required!"
					echo ""
					$sleep
					if [ "$opt" -le 10 ]; then
						echo " Some Changes are TEMPORARY & WON'T PERSIST!"
						echo ""
						$sleep
						echo " To enable PERSISTENT SuperCharger settings..."
						echo ""
						$sleep
						echo "     ...HTK Launcher and OOM Grouping Fixes..."
					else
						echo " To enable PERSISTENT OOM Grouping Fixes..."
					fi
					echo ""
					$sleep
					if [[ -n "$smrun" ]]; then
					SuperChargerScriptManagerHelp=1
cat > /sdcard/SuperChargerScriptManagerHelp.html <<EOF
Yay! You already have <a href="http://market.android.com/details?id=os.tools.scriptmanager">Script Manager!</a><br>
After running the script, have Script Manager load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the "Config" settings, enable "Browse as Root."<br>
Press the menu key and then Browser.<br>
Navigate up to the root, then click on the "data" folder.<br>
Click on 99SuperCharger.sh and select "Script" from the "Open As" menu.<br>
In the properties dialogue box, check "Run as root" and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically :)<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
						echo "Use THIS app to load 99SuperCharger.sh on boot!"
						echo ""
						$sleep
						echo $line
						echo " See /sdcard/SuperChargerScriptManagerHelp.html"
						echo $line
					else
						echo " ..Please ENABLE boot scripts to be run from..."
						echo "                  .../system/etc/init.d folder!"
						echo " Easier: Script Manager can solve everything ;)"
						echo ""
						$sleep
						SuperChargerHelp=1
cat > /sdcard/SuperChargerHelp.html <<EOF
To enable init.d boot scripts, go <a href="http://forum.xda-developers.com/showthread.php?t=1017291">HERE</a><br>
This is for Motorolas! At least some of them anyway.<br>
If that page is incompatible with your phone, do some reasearch!<br>
<br>
A very nice and easy solution is to simply use<br>
Script Manager to load scripts on boot - on ANY ROM!<br>
Here is the <a href="http://market.android.com/details?id=os.tools.scriptmanager">Market Link</a><br>
So first, you use Script Manager to run the V6 SuperCharger script.<br>
Then use it again to load the newly created <b>/data/99SuperCharger.sh</b> on boot<br>
In the 99SuperCharger.sh properties dialogue box, check "Run as root" and "Run at boot" and "Save".<br>
And that's it!<br>
Script Manager will load your most recent settings on boot!<br>
If you run the script later and with different settings, you don't have to reconfigure anything.<br>
Script Manager will just load the new /data/99SuperCharger.sh on boot automagically :)<br>
<br>
For more SuperCharging help and info,<br>
See the <a href="http://forum.xda-developers.com/showthread.php?t=991276">V6 SuperCharger Thread</a><br>
Feedback is Welcome!<br>
<br>
-=zeppelinrox=- @ <a href="http://forum.xda-developers.com/showthread.php?t=991276">XDA</a> & <a href="http://www.droidforums.net/forum/droid-hacks/148268-script-v6-supercharger-htk-bulletproof-launchers-fix-memory-all-androids.html">Droid</a> Forums<br>
EOF
						echo $line
						echo "See /sdcard/SuperChargerHelp.html for more help!"
						echo $line
					fi
					echo ""
					$sleep
				fi
			fi
			echo "$scadj" > /sys/module/lowmemorykiller/parameters/adj
			if [ "$opt" -le 10 ]; then
				if [ -d "/system/etc/init.d" ]; then
					echo $line
					echo ""
					$sleep
				fi
				echo " Setting lowmemorykiller to $MB1,$MB2,$MB3,$MB4,$MB5,$MB6 mb"
				echo ""
				echo "$scminfree" > /sys/module/lowmemorykiller/parameters/minfree
				currentminfree=`cat /sys/module/lowmemorykiller/parameters/minfree`
				ran=1
				$sleep
				echo " OOM minfrees levels are now set to..."
				echo ""
				$sleep
				echo "         ..."$currentminfree
				echo ""
				$sleep
				echo $line
				echo "      SUPERCHARGE IN EFFECT IMMEDIATELY!!"
			fi
			if [ "$opt" -gt 10 ] && [ ! -d "/system/etc/init.d" ]; then
				nl=1
			else
				echo $line
				echo ""
				$sleep
			fi
			if [ "$opt" -le 10 ]; then
				echo " If this is your first V6 SuperCharge...."
				echo ""
				$sleep
			fi
			echo " REBOOT NOW TO ENABLE..."
			echo ""
			$sleep
			if [ "$opt" -eq 12 ]; then
				echo "          ...BULLETPROOF LAUNCHER..."
			else
				echo "          ...HARD TO KILL LAUNCHER..."
			fi
			echo ""
			$sleep
			echo "                     ...AND OOM GROUPING FIXES!"
			echo ""
			$sleep
			echo $line
			if [ "$SuperChargerHelp" -eq 1 ]; then
				echo "   ...AND RE-RUN THIS SCRIPT AFTER EACH REBOOT!"
			elif [ "$SuperChargerScriptManagerHelp" -eq 1 ]; then
				echo " DON'T FORGET to have Script Manager load..."
				echo "            .../data/99SuperCharger.sh on boot!"
			elif [ "$opt" -le 10 ]; then
				echo "$CONFIG Settings WILL PERSIST after reboot!"
				echo $line
				echo ""
				$sleep
				echo "   If they don't persist, check the help file!"
				echo ""
			else
				$sleep
				echo ""
				echo " If OOM Fixes are not in effect after reboot..."
				echo ""
				$sleep
				echo "                 ...and the Launcher is weak..."
				echo ""
				$sleep
				echo "                        ...check the help file!"
				echo ""
			fi
			echo $line
			echo ""
			$sleep
		fi
	fi
	if [ "$opt" -eq 15 ]; then
		echo " This will copy V6 SuperCharger to /system/xbin"
		echo ""
		$sleep
		echo " To use this script with Terminal Emulator..."
		echo ""
		$sleep
		echo " Run Terminal Emulator..."
		echo ""
		$sleep
		echo "             ...Type su and enter..."
		echo ""
		$sleep
		echo "                   ...type bash V6 and enter..."
		echo ""
		$sleep
		echo "                   THAT'S IT!"
		echo ""
		$sleep
		echo " Note that su is short for SuperUser..."
		echo ""
		$sleep
		echo " So... continue installation?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read v6xbin
		echo ""
		echo $line
		case $v6xbin in
		  y|Y)if [ "$0" == "V6" ]; then
				echo " You are already running it from system/xbin!"
			  else
				dd if=$0 of=/system/xbin/V6 2>/dev/null
				echo "    Installation was incredibly successful!"
			  fi;;
		  *)echo " Well... forget it then...";;
		esac
		echo $line
		echo ""
		$sleep
	fi
	if [ "$opt" -ge 2 ] && [ "$opt" -le 12 ] || [ "$opt" -eq 15 ] || [ "$opt" -eq 17 ]; then
		echo " SuperCharging, OOM Grouping & Priority Fixes.."
		echo ""
		$sleep
		echo "     ...BulletProof & Hard To Kill Launchers..."
		echo ""
		$sleep
		echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
		sleep 2
	fi
	if [ "$opt" -eq 17 ]; then
		echo ""
		echo "                                     Buh Bye :)"
		echo ""
		$sleep
		exit 0
	fi
fi
mount -o remount,ro /system 2>/dev/null
for m in /dev/block/mtdblock*
do
mount -o remount,ro $m /system 2>/dev/null
done
done
