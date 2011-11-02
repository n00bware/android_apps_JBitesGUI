#!/system/bin/sh
# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox.
echo ""
echo "================================================"
echo " NOTE: BUSYBOX v1.16.2 OR HIGHER IS RECOMMENDED!"
echo "================================================"
sleep 2
#set -o errexit
cat > /sdcard/SuperCharger.html <<EOF
Hi! I hope that the V6 SuperCharger script is working well for you!<br>
<br>
First be sure to have <a href="http://market.android.com/details?id=com.jrummy.busybox.installer">BusyBox</a> installed or else the scripts won't work!<br>
Also, only install <b>BusyBox v1.16.2 or higher!</b> v1.18.3 and above sometimes give errors on some ROMs!<br>
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
If your ROM has the option, <b>DISABLE "Lock Home In Memory.</b> This takes effect immediately.<br>
Alternately, <u>if you need to free up extra ram</u>, you can use "Lock Home in Memory" as a "Saftey Lock".<br>
ie. Use it to toggle your launcher from "Bulletproof" (0) or Hard To Kill (1) to "Weak" (2) in the event that you want to make the launcher an easy kill and free up extra RAM ;)<br>
<br>
<b>If Settings Don't Stick:</b> If you have Auto Memory Manager, DISABLE SuperUser permissions and if you have AutoKiller Memory Optimizer, DISABLE the apply settings at boot option!<br>
Also, if you have a <b>Custom ROM</b>, there might be something in the init.d folder that interferes with priorities and minfrees.<br>
If you can't find the problem, a quick fix is to have Script Manager run <b>/system/etc/init.d/99SuperCharger</b> "at boot" and "as root."<br>
<br>
Another option is to make a Script Manager widget for <b>/system/etc/init.d/99SuperCharger</b> or <b>/data/99SuperCharger.sh</b> on your homescreen and simply launch it after each reboot.<br>
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
echo "      Test Driving Your Android Device..."
echo "================================================"
test1=;test2=;test3=
echo ""
sleep 2
if [ ! -f "/system/xbin/busybox" ] && [ ! -f "/xbin/busybox" ] && [ ! -f "/system/bin/busybox" ] && [ ! -f "/bin/busybox" ] && [ ! -f "/system/sbin/busybox" ] && [ ! -f "/sbin/busybox" ]; then
	echo " BusyBox NOT FOUND..."
	echo ""
	sleep 4
	echo "                           ...No Supe for you!!"
	echo ""
	sleep 4
	echo " If you continue, problems can occur..."
	echo ""
	sleep 4
	echo "                         ...and even bootloops!"
	echo ""
	sleep 4
	echo "  ...Please install BusyBox and try again..."
	echo ""
	sleep 4
	echo " Loading Market..."
	echo ""
	sleep 4
	am start http://market.android.com/details?id=com.jrummy.busybox.installer
	echo " I hope that helped! :)"
	echo ""
	sleep 4
	echo " Continue anyway...?"
	echo ""
	sleep 2
	echo -n " Enter Y for Yes, any key for No: "
	read bbnotfound
	echo ""
	case $bbnotfound in
	  y|Y)echo " uh... right... okay..."
		  echo ""
		  sleep 2;;
	  *)echo " Buh Bye..."
		exit 69;;
	esac
else
	test1=`busybox | head -n 1 | awk '{print $1}'`
	test2=`busybox | head -n 1 | awk '{print $2}'`
	if [[ -n "$test2" ]]; then
		echo -n " BusyBox "
		echo "$test2 Found!"
	else
		echo " ERROR! Can't determine BusyBox version!"
	fi
	echo ""
	sleep 1
	if [ "$test1" = "BusyBox" ]; then
		echo "   AWKing Awesome... AWK test passed!"
		echo ""
		sleep 1
		test3=`pgrep ini`
		if [[ -n "$test3" ]]; then
			echo "          Groovy... pgrep test passed too!"
		else
			echo " BusyBox has holes in it..."
			echo ""
			sleep 4
			echo " ...BulletProof Apps ain't gonna work..."
			echo ""
			sleep 4
			echo "                          ...pgrep test FAILED!"
		fi
	else
		echo " There was an AWK error..."
		echo ""
		sleep 4
		echo "                              ...what the AWK!?"
		echo ""
		sleep 4
		echo " If you continue, problems can occur..."
		echo ""
		sleep 4
		echo "                         ...and even bootloops!"
		echo ""
		sleep 4
		echo " ...Please reinstall BusyBox and try again..."
		echo ""
		sleep 4
		echo " Loading Market..."
		echo ""
		sleep 4
		am start http://market.android.com/details?id=com.jrummy.busybox.installer
		echo " I hope that helped! :)"
		echo ""
		sleep 4
		echo " Continue anyway...?"
		echo ""
		sleep 2
		echo -n " Enter Y for Yes, any key for No: "
		read awkerror
		echo ""
		case $awkerror in
		  y|Y)echo " uh... right... okay...";;
		  *)echo " Buh Bye..."
			exit 69;;
		esac
	fi
	echo ""
	sleep 1
fi
uid=`id | grep =0`
if [[ -n "$uid" ]]; then
	echo "        Nice! You're Running as Root/SuperUser!"
else
	echo " You are NOT running this script as root..."
	echo ""
	sleep 4
	echo "                      ...No SuperUser for you!!"
	echo ""
	sleep 4
	echo "     ...Please Run as Root and try again..."
	echo ""
	sleep 4
	echo " Loading Help File..."
	echo ""
	sleep 4
	am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file:///sdcard/SuperCharger.html
	echo " I hope that helped! :)"
	echo ""
	sleep 4
	exit 69
fi
echo ""
sleep 1
line=================================================
echo $line
echo "              Test Drive Complete!"
echo $line
echo ""
sleep 3
if [ ! -d "/sdcard/V6_SuperCharger" ]; then
	mkdir /sdcard/V6_SuperCharger
fi
if [ ! -d "/sdcard/V6_SuperCharger/PowerShift_Scripts" ]; then
	mkdir /sdcard/V6_SuperCharger/PowerShift_Scripts
fi
if [ ! -d "/sdcard/V6_SuperCharger/BulletProof_One_Shots" ]; then
	mkdir /sdcard/V6_SuperCharger/BulletProof_One_Shots
fi
speed=2
sleep="sleep $speed"
ran=0
scminfree=
sccminfree=
scadj=
smrun=`pgrep scriptmanager`
gb=0
rambytes=`free | awk '{ print $2 }' | sed -n 2p`
ram=$(($rambytes/1024))
ram1=3843
bbfullinfo=`busybox | head -n 1`
bbversion=`busybox | head -n 1 | awk '{print $1,$2}'`
oomstick=0
memory=c
newsupercharger=0
rcpath="/system/etc/rootfs/init.mapphone_umts.rc"
rcfile=${rcpath##*/}
rcbackup="$rcpath.unsuper"
initrcpath1="/init.rc"
initrcfile=${initrcpath1##*/}
initrcpath="/data/$initrcfile"
initrcbackup="$initrcpath.unsuper"
buildprop=
animation=
initrc=
if [ -f "/data/SuperChargerOptions" ]; then
	buildprop=`awk -F , '{print $2}' /data/SuperChargerOptions`
	animation=`awk -F , '{print $3}' /data/SuperChargerOptions`
	initrc=`awk -F , '{print $4}' /data/SuperChargerOptions`
fi
if [[ -z "$animation" ]] || [ "$animation" -eq 1 ]; then
	clear;sleep 1;echo $line;sleep 1
	clear;echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo $line;sleep 1
	clear;echo "";echo $line;echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "    ||   //  #    #" ;echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 1
	clear;echo "";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 2
	clear;echo "";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #           -=SUPERCHARGER=-";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #";echo "    |/   #####";echo "";echo $line;sleep 2
	clear;echo " zOOM...";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #           -=SUPERCHARGER=-";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #  Presented by:";echo "    |/   #####";echo "";echo $line;sleep 2
	clear;echo " zOOM... zOOM...";echo $line;echo "";echo "    ||    //  #####";echo "    ||   //  #    #";echo "    ||  //  #           -=SUPERCHARGER=-";echo "    || //  #####";echo "    ||//  #    #";echo "    | /  #    #  Presented by:";echo "    |/   #####                 -=zeppelinrox=-";echo "";echo $line;sleep 2
fi
if [[ -z "$animation" ]]; then
	echo ""
	echo " Disable AWESOME V6 Animation?"
	echo ""
	$sleep
	echo "    ...This can be changed later under Options!"
	echo ""
	echo $line
	$sleep
	animation=1
elif [ "$animation" -eq 0 ]; then
	clear
	echo ""
	echo $line
fi
echo " NOTE: BUSYBOX v1.16.2 OR HIGHER IS RECOMMENDED!"
echo $line
echo ""
$sleep
if [[ -n "$smrun" ]]; then
	echo "   Touch the screen to bring up soft keyboard"
else
	echo " Try Script Manager... it's easier!"
fi
echo ""
echo $line
echo ""
sleep 1
echo " Additional BusyBox Info:"
echo ""
sleep 1
echo " $bbfullinfo"
echo ""
sleep 1
echo "        BE SURE IT'S A COMPLETE VERSION!"
echo ""
sleep 1
echo " You are currently using $bbversion..."
echo ""
$sleep
if [ "$bbversion" \> "BusyBox v1.18.2" ] && [ "$bbversion" \< "BusyBox v1.19.0" ]; then
	echo $line
	echo " WARNING!  Your BusyBox is greater than v1.18.2"
	echo ""
	$sleep
	echo "                      ...and less that v1.19.0!"
	echo $line
	echo ""
	$sleep
	echo " These versions can cause problems..."
	echo ""
	$sleep
	echo " ...You may have issues such as bootloops..."
	echo ""
	$sleep
	echo "                  ...proceed at your own risk!!"
	echo ""
	$sleep
	echo " Oh yeah... Loading Market..."
	echo ""
	$sleep
	am start http://market.android.com/details?id=com.jrummy.busybox.installer
elif [ "$bbversion" \< "BusyBox v1.16.2" ]; then
	echo $line
	echo " WARNING! Your BusyBox is less than v1.16.2"
	echo $line
	echo ""
	$sleep
	echo " Some commands may not even work..."
	echo ""
	$sleep
	echo " And you may have issues such as bootloops..."
	echo ""
	$sleep
	echo "                  ...proceed at your own risk!!"
	echo ""
	$sleep
	echo " Oh yeah... Loading Market..."
	echo ""
	$sleep
	am start http://market.android.com/details?id=com.jrummy.busybox.installer
else
	echo "           ...which is fine - if it's COMPLETE!"
fi
echo ""
$sleep
echo $line
if [[ -z "$buildprop" ]] && [ -f "/data/local.prop" ]; then
	echo " LOCAL.PROP to be used for SuperCharging!"
	buildprop=0
elif [[ -z "$buildprop" ]] && [ ! -f "/data/local.prop" ]; then
	echo " WARNING: You don't have a /data/local.prop!"
	echo $line
	echo ""
	sleep 3
	echo "    BUILD.PROP to be used for SuperCharging!"
	echo ""
	sleep 3
	echo " There is a small chance of bootloops..."
	echo ""
	sleep 3
	echo "                 ...so have a backup available!"
	echo ""
	buildprop=1
elif [ "$buildprop" -eq 0 ]; then
	echo " LOCAL.PROP to be used for SuperCharging!"
elif [ "$buildprop" -eq 1 ]; then
	echo " BUILD.PROP to be used for SuperCharging!"
fi
echo $line
echo ""
$sleep
echo " This can be changed later under Options!"
echo ""
echo $line
echo ""
$sleep
speed=
if [ -f "/data/SuperChargerOptions" ]; then
	speed=`awk -F , '{print $1}' /data/SuperChargerOptions`
fi
if [[ -z "$speed" ]]; then
	echo " Scrolling speed options..."
	echo ""
	$sleep
	echo " 1(fast), 2(normal), 3(slow)"
	echo ""
	$sleep
	while :
	do
	 echo -n " Please select scrolling speed (1 - 3): "
	 read speed
	 case $speed in
	   0)sleep="sleep $speed";break;;
	   1)sleep="sleep $speed";break;;
	   2)sleep="sleep $speed";break;;
	   3)sleep="sleep $speed";break;;
	   *)echo ""
		 echo "      Invalid entry... Please try again :)"
		 echo ""
		 $sleep;;
	 esac
	done
	echo ""
	$sleep
	echo " Scrolling Speed is now set to $speed..."
else
	sleep="sleep $speed"
	echo " Prior scrolling speed of $speed has been loaded..."
	echo ""
	$sleep
	echo "        ...it can be changed under Options too!"
fi
echo ""
echo $line
echo ""
$sleep
if [[ -z "$initrc" ]]; then
	echo " System Integration - $initrcpath1 options..."
	echo ""
	$sleep
	echo " SuperCharger can attempt proper integration..."
	echo ""
	$sleep
	echo "  ...with system files on boot using init.rc..."
	echo ""
	$sleep
	echo " If it sticks, it makes for a much cleaner mod!"
	echo ""
	$sleep
	echo " Root access issues are rare, but can occur..."
	echo ""
	$sleep
	echo $line
	echo " Regardless, a SuperCharged init.rc file..."
	echo ""
	$sleep
	echo "               ...can always be found in /data!"
	echo $line
	echo ""
	$sleep
	echo -n " Integrate? Enter Y for Yes, any key for No: "
	read bake
	echo ""
	case $bake in
	  y|Y)initrc=1
		  echo " System Integration of $initrcpath1 is ON...";;
		*)initrc=0
		  echo " System Integration of $initrcpath1 is OFF...";;
	esac
elif [ "$initrc" -eq 1 ]; then
	echo " System Integration of $initrcpath1 is ON..."
	echo ""
	$sleep
	echo " Go to Options and DISABLE..."
	echo ""
	$sleep
	echo "         ...if you have root/permission issues!"
else
	echo " System Integration of $initrcpath1 is OFF..."
	echo ""
	$sleep
	echo " Go to Options and ENABLE..."
	echo ""
	$sleep
	echo "            ...for possible System Integration!"
fi
if [ ! -f "/data/SuperChargerOptions" ]; then
	echo ""
	echo $line
	echo ""
	$sleep
	echo " All settings will be saved!"
	echo ""
	$sleep
	echo " They can be changed again under Options!"
fi
echo "$speed,$buildprop,$animation,$initrc" > /data/SuperChargerOptions
if [ -f "/proc/`pidof com.android.launcher`/oom_adj" ]; then
	launcheradj=$(cat /proc/`pidof com.android.launcher`/oom_adj)
elif [ -f "/proc/`pidof com.htc.launcher`/oom_adj" ]; then
	launcheradj=$(cat /proc/`pidof com.htc.launcher`/oom_adj)
else
	launcheradj=
fi
homeadj=`getprop ro.HOME_APP_ADJ`;FA=`getprop ro.FOREGROUND_APP_ADJ`;PA=`getprop ro.PERCEPTIBLE_APP_ADJ`;VA=`getprop ro.VISIBLE_APP_ADJ`
if [[ -n "$PA" ]]; then
	gb=1
fi
if [[ -n "$launcheradj" ]] && [ "$launcheradj" -gt -20 ] 2>/dev/null; then
	HL="$launcheradj"
else
	echo ""
	echo $line
	echo ""
	$sleep
	echo " Is Home is Locked in Memory?"
	echo ""
	$sleep
	echo -n " If it is, Enter Y for Yes, any key for No: "
	read homelocked
	echo ""
	case $homelocked in
	  y|Y)HL="$VA"
		  echo " WHAT? You need to disable that feature!";;
		*)HL="$homeadj"
		  echo " Good Stuff!";;
	esac
fi
echo ""
echo $line
echo ""
$sleep
echo -n " Press Return Key... and Come Get Some!!"
read getsome
if [ -f "/data/SuperChargerMinfree" ]; then
	cp -fr /data/SuperChargerMinfree /data/SuperChargerMinfreeOld
	scminfree=`cat /data/SuperChargerMinfree`
fi
if [ -f "/data/SuperChargerAdj" ]; then
	scadj=`cat /data/SuperChargerAdj`
fi
while :
do
 MB0=4;MB1=0;MB2=0;MB3=0;MB4=0;MB5=0;MB6=0
 SP1=0;SL1=0;SL2=0;SL3=0;SL4=0;SL5=0;SL6=0
 restore=0;quickcharge=0;UnSuperCharged=0;UnSuperChargerError=0;SuperChargerScriptManagerHelp=0;SuperChargerHelp=0
 showbuildpropopt=0
 low=w
 newlauncher=0
 vroomverifier=
 madesqlitefolder=0
 currentminfree=`cat /sys/module/lowmemorykiller/parameters/minfree`
 currentadj=`cat /sys/module/lowmemorykiller/parameters/adj`
 ram2=`$low$memory "$0" | awk '{print $1}'`
 if [ -f "/data/SuperChargerCustomMinfree" ]; then
	sccminfree=`cat /data/SuperChargerCustomMinfree`
 fi
 echo ""
 echo $line
 echo "For help and info, see /sdcard/SuperCharger.html"
 echo $line
 $sleep
 echo " \\\\\\\\ T H E  V 6   S U P E R C H A R G E R ////"
 echo "  ============================================"
 echo "        \\\\\\\\    Driver's Console    ////"
 echo "         =============================="
 echo ""
 echo "1. SuperCharger & Launcher Status for Update 9 }"
 echo ""
 echo "==================== 256 HP ===================="
 echo "2. UnLedded  (Multitasking) {6,8,22,24,26,28 MB}"
 echo "3. Ledded        (Balanced) {6,8,26,28,30,32 MB}"
 echo "4. Super UL    (Aggressive) {6,8,28,30,35,50 MB}"
 echo ""
 echo "==================== 512 HP ===================="
 echo "5. UnLedded (Multitasking){6,12,40,50,60, 75 MB}"
 echo "6. Ledded       (Balanced){6,12,55,70,85,100 MB}"
 echo "7. Super UL   (Aggressive){6,12,75,90,95,125 MB}"
 echo ""
 echo "=================== 768+ HP ===================="
 echo "8. Super 768HP(Aggressive){6,12,150,165,180,200}"
 echo "9. Super 1000HP(Agressive){6,12,200,220,240,275}"
 echo ""
 echo $line
 echo -n "10. Quick V6 Cust-OOMizer "
 if [ -f "/data/SuperChargerCustomMinfree" ]; then
	awk -F , '{print "{"$1/256","$2/256","$3/256","$4/256","$5/256","$6/256"}"}' /data/SuperChargerCustomMinfree
 else
	echo "  {Create Or Restore!}"
 fi
 echo $line
 echo "11. OOM Grouping Fixes + Hard To Kill Launcher }"
 echo "12. OOM Grouping Fixes + Die-Hard Launcher     }"
 echo "13. OOM Grouping Fixes + BulletProof Launcher  }"
 echo $line
 echo "14. UnKernelizer         {UnDo Kernel/VM Tweaks}"
 echo "15. UnSuperCharger      {Revert Memory Settings}"
 echo $line
 echo "16. The OOM STICK         {Verify OOM Groupings}"
 echo "17. BulletProof Apps               {Hit or Miss}"
 echo "18. Engine Flush        {ReCoupe RAM & Kill Lag}"
 echo "19. Nitro Lag Nullifier           {Experimental}"
 echo $line
 echo "20. System Installer            {Terminal Usage}"
 echo "21. Re-SuperCharger        {Restore V6 Settings}"
 echo "22. PowerShifting         {Switch Presets FAST!}"
 echo $line
 echo "23. Help File           {Open SuperCharger.html}"
 echo "24. Updates & Help          {Open XDA SC Thread}"
 echo "25. Driver Options                             }"
 echo "26. Gimme Some Sugar               {Gotta Buck?}"
 echo "27. SuperCharge Your Health {No, I'm not crazy!}"
 echo "28. ReStart Your Engine       {Reboot Instantly}"
 echo "29. SuperClean & ReStart  {Wipe Caches & Reboot}"
 echo "30. Exit                                       }"
 echo $line
 echo ""
 echo -n "   Launcher is"
 if [ "$HL" -gt "$VA" ]; then
	echo ".... so.... weak.... :("
	status=4
 elif [ "$HL" -eq "$VA" ]; then
	echo " Locked In Memory ie. Very Weak!"
	status=3
 else
	if [ "$HL" -eq "$FA" ]; then
		echo -n " BULLETPROOF!"
		status=0
	elif [ "$HL" -eq "$(($FA+1))" ]; then
		echo -n " DIE-HARD!"
		status=1
	else
		echo -n " HARD TO KILL!"
		status=2
	fi
	echo " ie. SUPERCHARGED!"
	oomstick=1
 fi
 echo ""
 echo $line
 if [ "$ran" -eq 0 ]; then
	if [[ -n "$scadj" ]] && [ "$status" -eq 3 ]; then
		echo ""
		echo "   Home Launcher is Locked in Memory!"
		echo "   You need to DISABLE this shi... feature..."
		echo "          ...In both ROM and Launcher settings!"
	elif [[ -n "$scadj" ]] && [ "$oomstick" -eq 0 ] && [ "$buildprop" -eq 0 ]; then
		echo ""
		echo "   SuperCharged Launcher Is NOT In Effect!"
		echo "   You may need to use the build.prop option..."
		echo "   Select 2 - 12 from the menu NOW to access it!"
		showbuildpropopt=1
	fi
	if [[ -n "$scadj" ]] && [ "$currentadj" != "$scadj" ]; then
		echo ""
		echo "   OOM Grouping Fixes ARE NOT In Effect!"
		echo "   That means the boot script did NOT run..."
		echo "   Select Help File! from the menu for Repairs!"
	elif [[ -n "$scadj" ]] && [ "$currentadj" = "$scadj" ]; then
		echo ""
		echo "   OOM Grouping Fixes ARE In Effect!"
		echo "   That means the boot script ran!"
	else
		newsupercharger=1
	fi
	if [[ -n "$scminfree" ]] && [ "$currentminfree" != "$scminfree" ]; then
		echo ""
		echo "   Current Values DON'T MATCH Prior SuperCharge!"
		echo "   Select Help File! from the menu for Repairs!"
	elif [[ -n "$scminfree" ]] && [ "$currentminfree" = "$scminfree" ];then
		echo ""
		echo "   Current Values MATCH Prior SuperCharge!"
		echo "   That means that it's working! ;)"
	fi
	if [[ -n "$scadj" ]]; then
		echo ""
		echo $line
	fi
 fi
 if [[ -z "$scminfree" ]]; then
	echo "   SuperCharger Minfrees NOT FOUND! Have Fun!"
	echo $line
 fi
 awk -F , '{print "   Current minfrees = "$1/256","$2/256","$3/256","$4/256","$5/256","$6/256 " MB"}' /sys/module/lowmemorykiller/parameters/minfree
 if [ -f "/data/SuperChargerMinfreeOld" ]; then
	awk -F , '{print "  Prior V6 minfrees = "$1/256","$2/256","$3/256","$4/256","$5/256","$6/256 " MB"}' /data/SuperChargerMinfreeOld
 fi
 echo $line
 echo ""
 echo " You have $ram MB of RAM on your device..."
 if [ "$ram" -le 256 ]; then
	echo -n " 256 HP"
 elif [ "$ram" -le 512 ]; then
	echo -n " 512 HP"
 elif [ "$ram" -le 768 ]; then
	echo -n " 768 HP"
 else
	echo -n " 1000 HP"
 fi
 echo " settings are recommended!"
 echo ""
 echo $line
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
 fi
 echo $line
 echo -n " Please enter option [1 - 30]: "
 read opt
 echo $line
 echo "            \\\\\\\\ V6 SUPERCHARGER ////"
 echo "             ======================="
 echo ""
 $sleep
 if [ "$opt" -lt 28 ] 2>/dev/null; then
	busybox mount -o remount,rw / 2>/dev/null
	busybox mount -o remount,rw rootfs 2>/dev/null
	busybox mount -o remount,rw /system 2>/dev/null
	for m in /dev/block/mtdblock*
	do
	busybox mount -o remount,rw $m /system 2>/dev/null
	done
	if [ ! -d "/sqlite_stmt_journals" ]; then
		mkdir /sqlite_stmt_journals
		madesqlitefolder=1
	fi
 fi
 case $opt in
  1) echo "      V6 SUPERCHARGER AND LAUNCHER STATUS!";;
  2) echo "      256HP UNLEDDED + DIE-HARD LAUNCHER!"
	 CONFIG="256HP UnLedd"
	 MB1=6;MB2=8;MB3=22;MB4=24;MB5=26;MB6=28;;
  3) echo "       256HP LEDDED + DIE-HARD LAUNCHER!"
	 CONFIG="256HP Ledded"
	 MB1=6;MB2=8;MB3=26;MB4=28;MB5=30;MB6=32;;
  4) echo "   256HP SUPER UNLEDDED + DIE-HARD LAUNCHER!"
	 CONFIG="256HP Super"
	 MB1=6;MB2=8;MB3=28;MB4=30;MB5=35;MB6=50;;
  5) echo "      512HP UNLEDDED + DIE-HARD LAUNCHER!"
	 CONFIG="512HP UnLedd"
	 MB1=6;MB2=12;MB3=40;MB4=50;MB5=60;MB6=75;;
  6) echo "       512HP LEDDED + DIE-HARD LAUNCHER!"
	 CONFIG="512HP Ledded"
	 MB1=6;MB2=12;MB3=55;MB4=70;MB5=85;MB6=100;;
  7) echo "   512HP SUPER UNLEDDED + DIE-HARD LAUNCHER!"
	 CONFIG="512HP Super"
	 MB1=6;MB2=12;MB3=75;MB4=90;MB5=95;MB6=125;;
  8) echo "   768HP SUPER UNLEDDED + DIE-HARD LAUNCHER!"
	 if [ "$ram" -le 256 ]; then
		 echo $line
		 echo "      WHOA! There's NOT Enough RAM! lulz!"
		 opt=22
	 else
		 CONFIG="768HP Super"
		 MB1=6;MB2=12;MB3=150;MB4=165;MB5=180;MB6=200
	 fi;;
  9) echo "   1000HP SUPER UNLEDDED + DIE-HARD LAUNCHER!"
	 if [ "$ram" -le 256 ]; then
		 echo $line
		 echo "      WHOA! There's NOT Enough RAM! lulz!"
		 opt=22
	 else
		 CONFIG="1000HP Super"
		 MB1=6;MB2=12;MB3=200;MB4=220;MB5=240;MB6=275
	 fi;;
  10)echo "       CUST-OOMIZER + DIE-HARD LAUNCHER!"
	 CONFIG="CUST-OOMIZED"
	 echo $line
	 echo ""
	 $sleep
	 echo " Your Current Minfree values are..."
	 echo ""
	 $sleep
	 awk -F , '{print "               "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " MB"}' /sys/module/lowmemorykiller/parameters/minfree
	 echo ""
	 $sleep
	 if [ -f "/data/SuperChargerCustomMinfree" ]; then
		 echo " Your Prior Cust-OOMizer values are..."
		 echo ""
		 $sleep
		 awk -F , '{print "               "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " MB"}' /data/SuperChargerCustomMinfree
		 echo ""
		 $sleep
	 fi
	 if [ "$currentminfree" != "$sccminfree" ] 2>/dev/null && [ "$currentminfree" != "$scminfree" ] 2>/dev/null; then
		 echo " Do a Quick SuperCharge of Current Minfrees?"
		 echo ""
		 $sleep
		 echo " If Yes, these become your Cust-OOMizer values."
		 echo ""
		 $sleep
		 echo -n " Enter Y for Yes, any key for No: "
		 read quick
		 echo ""
		 case $quick in
		  y|Y)quickcharge=1
			  MB1=`awk -F , '{print $1/256}' /sys/module/lowmemorykiller/parameters/minfree`;MB2=`awk -F , '{print $2/256}' /sys/module/lowmemorykiller/parameters/minfree`;MB3=`awk -F , '{print $3/256}' /sys/module/lowmemorykiller/parameters/minfree`;MB4=`awk -F , '{print $4/256}' /sys/module/lowmemorykiller/parameters/minfree`;MB5=`awk -F , '{print $5/256}' /sys/module/lowmemorykiller/parameters/minfree`;MB6=`awk -F , '{print $6/256}' /sys/module/lowmemorykiller/parameters/minfree`
			  echo $line
			  echo "   Quick Cust-OOMizer Settings will be Saved!";;
		    *);;
		 esac
	 fi
	 if [ "$currentminfree" != "$sccminfree" ] 2>/dev/null && [ "$quickcharge" -eq 0 ]; then
		 echo $line
		 echo ""
		 $sleep
		 echo " Restore Previous Cust-OOMizer settings?"
		 echo ""
		 $sleep
		 echo -n " Enter Y for Yes, any key for No: "
		 read crestore
		 echo ""
		 echo $line
		 case $crestore in
		  y|Y)restore=1
			  MB1=`awk -F , '{print $1/256}' /data/SuperChargerCustomMinfree`;MB2=`awk -F , '{print $2/256}' /data/SuperChargerCustomMinfree`;MB3=`awk -F , '{print $3/256}' /data/SuperChargerCustomMinfree`;MB4=`awk -F , '{print $4/256}' /data/SuperChargerCustomMinfree`;MB5=`awk -F , '{print $5/256}' /data/SuperChargerCustomMinfree`;MB6=`awk -F , '{print $6/256}' /data/SuperChargerCustomMinfree`
			  echo "    Cust-OOMizer Settings will be Restored!";;
			*)echo " Running Cust-OOMizer...";;
		 esac
	 fi
	 if [ "$restore" -eq 0 ] && [ "$quickcharge" -eq 0 ]; then
		 echo $line
		 echo "            \\\\\\\\ V6 CUST-OOMIZER ////"
		 echo "             ======================="
		 echo ""
		 $sleep
		 echo " Enter your desired lowmemorykiller OOM levels!"
		 echo ""
		 $sleep
		 echo " Slot 3 determines your fee RAM the most!!"
		 echo ""
		 echo $line
		 echo ""
		 $sleep
		 while :; do
		   echo -n "               Slot 1: ";read MB1
		   if [ "$MB1" -gt 0 ] 2>/dev/null; then break; fi
			echo " Input Error!                      Try again :)";sleep 2
		 done
		 while :; do
		   echo -n "                 Slot 2: ";read MB2
		   if [ "$MB2" -gt 0 ] 2>/dev/null; then break; fi
			echo " Input Error!                      Try again :)";sleep 2
		 done
		 while :; do
		   echo -n "                   Slot 3: ";read MB3
		   if [ "$MB3" -gt 0 ] 2>/dev/null; then break; fi
			echo " Input Error!                      Try again :)";sleep 2
		 done
		 while :; do
		   echo -n "                     Slot 4: ";read MB4
		   if [ "$MB4" -gt 0 ] 2>/dev/null; then break; fi
			echo " Input Error!                      Try again :)";sleep 2
		 done
		 while :; do
		   echo -n "                       Slot 5: ";read MB5
		   if [ "$MB5" -gt 0 ] 2>/dev/null; then break; fi
			echo " Input Error!                      Try again :)";sleep 2
		 done
		 while :; do
		   echo -n "                         Slot 6: ";read MB6
		   if [ "$MB6" -gt 0 ] 2>/dev/null; then break; fi
			echo " Input Error!                      Try again :)";sleep 2
		 done
		 echo ""
		 $sleep
		 echo $line
		 echo " CONFIRM: Cust-OOMize $MB1, $MB2, $MB3, $MB4, $MB5, $MB6 MB?"
		 echo $line
		 echo ""
		 $sleep
		 echo -n " Enter N for No, any key for Yes: "
		 read custOOM
		 echo ""
		 case $custOOM in
		  n|N)opt=22;;
		    *)echo $line
			  echo "        Cust-OOMizer Settings Accepted!";;
		 esac
	 fi;;
  11)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                      ...HARD TO KILL LAUNCHER!"
	 if [ "$gb" -eq 0 ]; then
		 echo $line
		 echo ""
		 echo " Sorry, Hard To Kill Launcher..."
		 echo ""
		 $sleep
		 echo "    ...is only available on Gingerbread ROMS..."
		 echo ""
		 $sleep
		 echo "                                 ...or Greater!"
		 echo ""
		 opt=22
	 fi;;
  12)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                          ...DIE-HARD LAUNCHER!";;
  13)echo " OOM GROUPING FIXES PLUS..."
	 echo ""
	 echo "                       ...BULLETPROOF LAUNCHER!";;
  14)echo "              ===================="
	 echo "             //// UNKERNELIZER \\\\\\\\"
	 if [ ! -f "/system/etc/init.d/99SuperCharger" ] && [ ! -f "/system/etc/init.d/S99SuperCharger" ] && [ ! -f "/data/99SuperCharger.sh" ] && [ ! -f "$rcpath" ] && [ ! -f "$initrcpath" ]; then
		 echo $line
		 echo "        There's Nothing to UnKernelize!"
		 opt=22
	 fi;;
  15)echo "             ======================="
	 echo "            //// UN-SUPERCHARGER \\\\\\\\"
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
		 opt=22;;
	 esac;;
  16)echo "             ======================"
	 echo "            //// THE OOM STICK! \\\\\\\\";;
  17)echo "            ========================"
	 echo "           //// BULLETPROOF APPS \\\\\\\\";;
  18)echo "              ===================="
	 echo "             //// ENGINE FLUSH \\\\\\\\";;
  19)echo "           ==========================="
	 echo "          //// NITRO LAG NULLIFIER \\\\\\\\";;
  20)echo "             ======================"
	 echo "            //// SYSTEM INSTALL \\\\\\\\";;
  21)echo "             ======================="
	 echo "            //// RE-SUPERCHARGER \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Restore previous V6 SuperCharger Settings..."
	 echo ""
	 $sleep
	 echo "                          ...from your SD Card?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read resuper
	 echo ""
	 echo $line
	 $sleep
	 case $resuper in
		y|Y)echo " Re-SuperCharging from your SD Card..."
			echo ""
			$sleep
			if [ -f "/sdcard/V6_SuperCharger/97BulletProof_Apps.sh" ]; then
				cp -fr /sdcard/V6_SuperCharger/97BulletProof_Apps.sh /data/97BulletProof_Apps.sh
			fi
			if [ -f "/sdcard/V6_SuperCharger/97BulletProof_Apps" ]; then
				cp -fr /sdcard/V6_SuperCharger/97BulletProof_Apps /system/etc/init.d/97BulletProof_Apps
			fi
			if [ -f "/sdcard/V6_SuperCharger/S97BulletProof_Apps" ]; then
				cp -fr /sdcard/V6_SuperCharger/S97BulletProof_Apps /system/etc/init.d/S97BulletProof_Apps
			fi
			if [ -f "/sdcard/V6_SuperCharger/Fast_Engine_Flush.sh" ]; then
				cp -fr /sdcard/V6_SuperCharger/Fast_Engine_Flush.sh /data/Fast_Engine_Flush.sh
			fi
			if [ -f "/sdcard/V6_SuperCharger/SuperChargerAdj" ]; then
				cp -fr /sdcard/V6_SuperCharger/SuperChargerAdj /data/SuperChargerAdj
			fi
			if [ -f "/sdcard/V6_SuperCharger/SuperChargerMinfree" ]; then
				cp -fr /sdcard/V6_SuperCharger/SuperChargerMinfree /data/SuperChargerMinfree
			fi
			if [ -f "/sdcard/V6_SuperCharger/SuperChargerCustomMinfree" ]; then
				cp -fr /sdcard/V6_SuperCharger/SuperChargerCustomMinfree /data/SuperChargerCustomMinfree
			fi
			if [ -f "/sdcard/V6_SuperCharger/SuperChargerOptions" ]; then
				cp -fr /sdcard/V6_SuperCharger/SuperChargerOptions /data/SuperChargerOptions
			fi
			if [ -f "/sdcard/V6_SuperCharger/99SuperCharger" ]; then
				cp -fr /sdcard/V6_SuperCharger/99SuperCharger /system/etc/init.d/99SuperCharger
			fi
			if [ -f "/sdcard/V6_SuperCharger/S99SuperCharger" ]; then
				cp -fr /sdcard/V6_SuperCharger/S99SuperCharger /system/etc/init.d/S99SuperCharger
			fi
			if [ -f "/sdcard/V6_SuperCharger/99SuperCharger.sh" ]; then
				cp -fr /sdcard/V6_SuperCharger/99SuperCharger.sh /data/99SuperCharger.sh
			fi
			echo " To avoid conflicts (different rom, etc)..."
			echo ""
			$sleep
			echo "        ...some system files were not restored!"
			echo ""
			$sleep
			echo " Select a launcher to complete Re-SuperCharge..."
			echo ""
			$sleep
			while :
			do
			 echo -n " Enter 1 (HTK) 2 (Die-Hard) 3 (BulletProof): "
			 read launcher
			 case $launcher in
			   1)opt=11;break;;
			   2)opt=12;break;;
			   3)opt=13;break;;
			   *)echo ""
				 echo "      Invalid entry... Please try again :)"
				 echo ""
				 $sleep;;
			 esac
			done;;
		*)echo " Re-SuperCharging declined... meh...";;
	 esac;;
  22)echo "              ====================="
	 echo "             //// POWERSHIFTING \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Now you can quickly switch minfree settings!"
	 echo ""
	 $sleep
	 echo " When you run a preset or the Cust-OOMizer..."
	 echo ""
	 $sleep
	 echo "                      ...a PowerShift Script..."
	 echo ""
	 $sleep
	 echo "                   ...is saved to your SD Card!"
	 echo ""
	 echo $line
	 $sleep
	 echo " You can find them in the folder..."
	 echo ""
	 $sleep
	 echo ".../sdcard/V6_SuperCharger/PowerShift_Scripts :D"
	 echo $line
	 echo ""
	 $sleep
	 echo " Just create Script Manager widgets for them..."
	 echo ""
	 $sleep
	 echo "            ...and PowerShift between settings!"
	 echo ""
	 $sleep
	 echo " They will have descriptive names..."
	 echo ""
	 $sleep
	 echo "                  ...indicating minfree values."
	 echo ""
	 $sleep
	 echo " Different Cust-OOMizer settings will be saved!"
	 echo "";;
  23)echo "                ================="
	 echo "               //// HELP FILE \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Loading Help File..."
	 echo ""
	 $sleep
	 am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity -d file:///sdcard/SuperCharger.html
	 echo " I hope that helped! :)"
	 echo "";;
  24)echo "          ============================="
	 echo "         //// UPDATES & HELP ONLINE \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Loading web site for more help & updates..."
	 echo ""
	 $sleep
	 am start http://forum.xda-developers.com/showthread.php?t=991276
	 echo " I hope that helped! :)"
	 echo "";;
  25)echo "                 ==============="
	 echo "                //// OPTIONS \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Scrolling speed options..."
	 echo ""
	 $sleep
	 echo " 1(fast), 2(normal), 3(slow)"
	 echo ""
	 $sleep
	 while :
	 do
	  echo -n " Please select scrolling speed (1 - 3): "
	  read speed
	  case $speed in
		0)sleep="sleep $speed";break;;
		1)sleep="sleep $speed";break;;
		2)sleep="sleep $speed";break;;
		3)sleep="sleep $speed";break;;
		*)echo ""
		  echo "      Invalid entry... Please try again :)"
		  echo ""
		  $sleep;;
	  esac
	 done
	 echo ""
	 $sleep
	 echo " Scrolling Speed is now set to $speed..."
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " Build.prop vs Local.prop..."
	 echo ""
	 $sleep
	 echo " If your launcher does NOT stay SuperCharged..."
	 echo ""
	 $sleep
	 echo " You can apply MEM and ADJ values..."
	 echo ""
	 $sleep
	 echo "        ...to build.prop instead of local.prop!"
	 echo ""
	 $sleep
	 echo " This is more likely to stick but is riskier..."
	 echo ""
	 $sleep
	 echo $line
	 echo " WARNING: There is a small chance of bootloops!"
	 echo ""
	 $sleep
	 echo "                 ...so have a backup available!"
	 echo $line
	 echo ""
	 $sleep
	 echo " Do you want to use Build.prop?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read buildpropopt
	 echo ""
	 case $buildpropopt in
	   y|Y)echo " Okay... will use the build.prop method!"
		   buildprop=1;;
		 *)if [ -f "/data/local.prop" ]; then
			   echo " Okay... will try local.prop method again..."
			   buildprop=0
		   else
			   echo " Oops... sorry, you have no local.prop!"
		   fi;;
	 esac
	 showbuildpropopt=0
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " System Integration - $initrcpath1 options..."
	 echo ""
	 $sleep
	 echo " SuperCharger can attempt proper integration..."
	 echo ""
	 $sleep
	 echo "  ...with system files on boot using init.rc..."
	 echo ""
	 $sleep
	 echo " If it sticks, it makes for a much cleaner mod!"
	 echo ""
	 $sleep
	 echo " Root access issues are rare, but can occur..."
	 echo ""
	 $sleep
	 echo $line
	 echo " Regardless, a SuperCharged init.rc file..."
	 echo ""
	 $sleep
	 echo "               ...can always be found in /data!"
	 echo $line
	 $sleep
	 echo " Note: You can bake $initrcpath into your ROM!"
	 echo $line
	 echo ""
	 $sleep
	 echo -n " Integrate? Enter Y for Yes, any key for No: "
	 read bake
	 echo ""
	 case $bake in
	  y|Y)initrc=1
		  echo " System Integration of $initrcpath1 is now ON!";;
		*)initrc=0
		  echo " System Integration of $initrcpath1 is now OFF!";;
	 esac
	 echo ""
	 echo $line
	 echo ""
	 $sleep
	 echo " Disable AWESOME V6 Animation?"
	 echo ""
	 $sleep
	 echo -n " Enter Y for Yes, any key for No: "
	 read animate
	 echo ""
	 case $animate in
	  y|Y)animation=0
		  echo " Boo... Animation is OFF...";;
		*)animation=1
		  echo " Yay... Animation is ON...";;
	 esac
	 echo ""
	 $sleep
	 echo "$speed,$buildprop,$animation,$initrc" > /data/SuperChargerOptions
	 echo $line
	 echo " Settings have been saved!";;
  26)echo "                 ==============="
	 echo "                //// DONATE! \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Gimme some sugar, baby..."
	 echo ""
	 $sleep
	 echo "                    ...before my hand goes bad!"
	 echo ""
	 $sleep
	 echo " I've done ALOT of work to make this GREAT..."
	 echo ""
	 $sleep
	 echo "            ...possibly the BEST script EVER..."
	 echo ""
	 $sleep
	 echo "    ...hours, weeks, months... almost a YEAR..."
	 echo ""
	 $sleep
	 echo " So if you think I deserve a few bucks..."
	 echo ""
	 $sleep
	 echo "                ...I'd really appreciate it! :D"
	 echo ""
	 $sleep
	 echo " Come give some! hehe..."
	 echo ""
	 $sleep
	 echo "                                   ...AOD FTW!!"
	 echo ""
	 $sleep
	 am start http://forum.xda-developers.com/donatetome.php?u=3357461
	 echo " I hope you helped! :)"
	 echo "";;
  27)echo "                ================="
	 echo "               //// OFF TOPIC \\\\\\\\"
	 echo $line
	 echo ""
	 $sleep
	 echo " Ok this is \"Off Topic\"..."
	 echo ""
	 $sleep
	 echo " ...but maybe there's a good reason..."
	 echo ""
	 $sleep
	 echo "            ...why this script is so popular :p"
	 echo ""
	 $sleep
	 echo " It's profound... so just read the link..."
	 echo ""
	 $sleep
	 echo "  ...and decide for yourself if it makes sense!"
	 echo ""
	 $sleep
	 echo " If you don't like it... remember..."
	 echo ""
	 $sleep
	 echo "                  ...don't shoot the messenger!"
	 echo ""
	 $sleep
	 echo " Either way... I'm not crazy..."
	 echo ""
	 $sleep
	 echo "      ...and you may learn something..."
	 echo ""
	 $sleep
	 echo "                    ...even if you're a doctor!"
	 echo ""
	 $sleep;$sleep
	 am start http://www.cancertutor.com/
	 echo "";;
  28)echo $line
	 echo "                    !!POOF!!"
	 echo $line
	 echo ""
	 busybox sync
	 echo 1 > /proc/sys/kernel/sysrq
	 echo b > /proc/sysrq-trigger
	 $sleep
	 echo "  If it don't go poofie, just reboot manually!"
	 reboot
	 echo "";;
  29)echo "              ==================="
	 echo "             //// SUPERCLEAN! \\\\\\\\";;
  30)echo " Did you find this useful? Feedback is welcome!";;
  *) echo "   #!*@%$*?%@&)&*#!*?(*)(*)&(!)%#!&?@#$*%&?&$%$*#?!"
	 echo ""
	 sleep 2
	 echo "     oops.. typo?!  $opt is an Invalid Option!"
	 echo ""
	 sleep 2
	 echo "            1 <= Valid Option => 30 !!"
	 echo ""
	 sleep 2
	 echo -n "    hehe... Press Enter key to continue... ;) "
	 read return
	 opt=69;;
 esac
if [ "$opt" -ne 1 ] && [ "$opt" -ne 14 ] && [ "$opt" -ne 15 ] && [ "$opt" -ne 16 ] && [ "$opt" -le 22 ] && [ "$ram1" -ne "$ram2" ]; then opt=69; fi
if [ "$opt" -ne 30 ] && [ "$opt" -ne 69 ]; then
	echo $line
	echo ""
	$sleep
fi
if [ "$opt" -eq 1 ]; then
	echo " Out Of Memory (OOM) / lowmemorykiller values:"
	echo ""
	$sleep
	echo "        "$currentminfree pages
	echo ""
	$sleep
	awk -F , '{print "  Which means: "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " MB"}' /sys/module/lowmemorykiller/parameters/minfree
	echo ""
	echo $line
	echo ""
	$sleep
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
	elif [ "$status" -eq 0 ]; then
		echo " Launcher is equal to Foreground App..."
		echo ""
		$sleep
		if [ "$gb" -eq 1 ]; then
			echo "           ...is less than Perceptible App..."
			echo ""
			$sleep
		fi
		echo "             ...and is less than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "         Home Launcher is BULLETPROOF!"
	elif [ "$status" -eq 1 ]; then
		echo " Launcher is greater than Foreground App..."
		echo ""
		$sleep
		if [ "$gb" -eq 1 ]; then
			echo "           ...is less than Perceptible App..."
			echo ""
			$sleep
		fi
		echo "             ...and is less than Visible App..."
		echo ""
		$sleep
		echo $line
		echo "          Home Launcher is DIE-HARD!"
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
elif [ "$opt" -ge 2 ] && [ "$opt" -le 30 ]; then
	if [ "$opt" -le 15 ]; then
		if [ "$opt" -le 10 ]; then
			SP1=$(($MB0*256));SL1=$(($MB1*256));SL2=$(($MB2*256));SL3=$(($MB3*256));SL4=$(($MB4*256));SL5=$(($MB5*256));SL6=$(($MB6*256))
			echo " zOOM... zOOM..."
			echo ""
			$sleep
		fi
		if [ "$opt" -le 13 ]; then
			echo "=============  Information Section  ============"
			echo "             ======================="
			echo ""
			$sleep
			if [ "$showbuildpropopt" -eq 1 ];then
				echo " Even though you SuperCharged before..."
				echo ""
				$sleep
				echo "        ...Your launcher is NOT SuperCharged..."
				echo ""
				$sleep
				echo " To apply MEM and ADJ values..."
				echo ""
				$sleep
				echo "   ...You can try and use build.prop..."
				echo ""
				$sleep
				echo "                      ...instead of local.prop!"
				echo ""
				$sleep
				echo " This is more likely to work but riskier..."
				echo ""
				$sleep
				echo $line
				echo " WARNING: There is a small chance of bootloops!"
				echo ""
				$sleep
				echo "                 ...so have a backup available!"
				echo $line
				echo ""
				$sleep
				echo " Do you want to use Build.prop?"
				echo ""
				$sleep
				echo -n " Enter Y for Yes, any key for No: "
				read buildpropopt
				echo ""
				case $buildpropopt in
				  y|Y)echo " Okay... will try using the build.prop method!"
					  buildprop=1;;
					*)if [ -f "/data/local.prop" ]; then
						echo " Okay... will try local.prop method again..."
						buildprop=0
					  else
						echo " Sorry, you have no local.prop!"
					  fi;;
				esac
				echo ""
				$sleep
				echo "$speed,$buildprop,$animation,$initrc" > /data/SuperChargerOptions
				echo " Settings have been saved!"
				echo ""
				$sleep
				echo " Note: This can be changed later under Options!"
				echo ""
				echo $line
				echo ""
				$sleep
			fi
			echo -n " MEM and ADJ values to be applied to "
			if [ "$buildprop" -eq 0 ];then
				echo "LOCAL.PROP!"
			else
				echo "BUILD.PROP!"
			fi
			echo ""
			$sleep
			if [ -f "/system/build.prop.unsuper" ]; then
				echo " Leaving ORIGINAL build.prop backup intact..."
			else
				echo " Backing up ORIGINAL build.prop..."
				echo ""
				$sleep
				cp -r /system/build.prop /system/build.prop.unsuper
				echo "              ...as /system/build.prop.unsuper!"
			fi
			if [ -f "/system/bin/build.prop" ] && [ ! -f "/system/bin/build.prop.unsuper" ]; then
				cp -r /system/bin/build.prop /system/bin/build.prop.unsuper
			fi
			echo ""
			$sleep
			if [ -f "/data/local.prop" ]; then
				if [ -f "/data/local.prop.unsuper" ]; then
					echo " Leaving ORIGINAL local.prop backup intact..."
				else
					echo " Backing up ORIGINAL local.prop..."
					echo ""
					$sleep
					cp -r /data/local.prop /data/local.prop.unsuper
					echo "                ...as /data/local.prop.unsuper!"
				fi
			echo ""
			$sleep
			fi
		fi
		if [ "$opt" -ne 14 ]; then
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
		fi
		if [ "$opt" -le 14 ]; then
			if [ -f "$initrcpath1" ] && [ ! -f "$initrcpath" ]; then
				cp -r $initrcpath1 $initrcpath
			fi
			if [ -f "$rcpath" ]; then
				echo " Found "$rcpath
				echo ""
				$sleep
				echo $line
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ]; then
					echo " $rcfile will be OOM Fixed!"
				elif [ "$opt" -eq 14 ]; then
					echo " $rcfile to be UnKernelized!"
				else
					echo " $rcfile will be SuperCharged!"
				fi
				echo $line
				echo ""
				$sleep
				if [ -f "$rcbackup" ]; then
					echo " Backup already exists... leaving backup intact"
				else
					cp -r $rcpath $rcbackup
					echo " Backing up ORIGINAL settings..."
				fi
				if [ -f "$initrcpath1" ] && [ ! -f "$initrcbackup" ]; then
					cp -r $initrcpath1 $initrcbackup
				fi
			elif [ -f "$initrcpath1" ]; then
				echo " Found "$initrcpath1
				echo ""
				$sleep
				if [ "$initrc" -eq 0 ]; then
					echo " System Integration of $initrcpath1 is OFF..."
					echo ""
					$sleep
					echo " But for cooking/baking into ROMs..."
					echo ""
					$sleep
				fi
				echo $line
				if [ "$initrc" -eq 0 ]; then
					echo -n "         .../data/"
				else
					echo -n "                 "
				fi
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ]; then
					echo "$initrcfile will be OOM Fixed!"
				elif [ "$opt" -eq 14 ]; then
					echo "$initrcfile to be UnKernelized!"
				else
					echo "$initrcfile will be SuperCharged!"
				fi
				echo $line
				echo ""
				$sleep
				if [ -f "$initrcbackup" ]; then
					echo " Backup already exists... leaving backup intact"
				else
					cp -r $initrcpath1 $initrcbackup
					echo " Backing up ORIGINAL settings..."
				fi
			fi
			echo ""
			$sleep
		fi
		if [ "$opt" -eq 15 ]; then
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
			if [ ! -f "/system/etc/init.d/99SuperCharger" ] && [ ! -f "/system/etc/init.d/S99SuperCharger" ] && [ ! -f "/data/99SuperCharger.sh" ] && [ ! -f "$rcpath" ] && [ ! -f "$initrcpath" ] && [ ! -f "$rcbackup" ] && [ ! -f "$initrcbackup" ]; then
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
			if [ -f "$initrcpath" ]; then
				rm $initrcpath
			fi
			if [ -f "$initrcbackup" ]; then
				echo "                 BACKUP FOUND!"
				echo ""
				$sleep
				echo " Restoring $initrcfile..."
				echo ""
				$sleep
				cp -fr $initrcbackup $initrcpath1
				rm $initrcbackup
			fi
			if [ -f "$rcbackup" ]; then
				echo "                 BACKUP FOUND!"
				echo ""
				$sleep
				echo " Restoring $rcfile..."
				echo ""
				$sleep
				cp -fr $rcbackup $rcpath
				rm $rcbackup
			elif [ -f "$rcpath" ]; then
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
				sed -i '/.*SuperCharger/,/.*SuperCharged/d' $rcpath
				sed -i '/.*_ADJ/d' $rcpath
				sed -i '/parameters\/adj/d' $rcpath
				sed -i '/lowmemorykiller/d' $rcpath
				sed -i '/vm\/.*oom.*/d' $rcpath
				sed -i '/kernel\/panic.*/d' $rcpath
				$sleep
			fi
		fi
		if [ "$opt" -ne 14 ]; then
			if [ -f "/data/local.prop" ]; then
				echo " Cleaning MEM and ADJ values from local.prop..."
				echo ""
				$sleep
				sed -i '/BEGIN OOM_ADJ_Settings/,/.*SuperCharged/d' /data/local.prop
				sed -i '/.*_ADJ/d' /data/local.prop
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ] && [[ -z "$scminfree" ]]; then
					sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' /data/local.prop
				fi
			fi
			echo " Cleaning MEM and ADJ values from build.prop..."
			echo ""
			$sleep
			sed -i '/BEGIN OOM_ADJ_Settings/,/.*SuperCharged/d' /system/build.prop
			sed -i '/.*_ADJ/d' /system/build.prop
			if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ] && [[ -z "$scminfree" ]]; then
				sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' /system/build.prop
			fi
			if [ -f "/system/bin/build.prop" ]; then
				sed -i '/BEGIN OOM_ADJ_Settings/,/.*SuperCharged/d' /system/bin/build.prop
				sed -i '/.*_ADJ/d' /system/bin/build.prop
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ] && [[ -z "$scminfree" ]]; then
					sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' /system/bin/build.prop
				fi
			fi
			if [ -f "/data/local/userinit.sh" ]; then
				sed -i '/.*99SuperCharger/d' /data/local/userinit.sh
			fi
			if [ -f "/system/etc/hw_config.sh" ]; then
				echo " Cleaning Up SuperCharge from hw_config.sh..."
				echo ""
				$sleep
				sed -i '/.*SuperCharger/,/.*SuperCharged/d' /system/etc/hw_config.sh
			fi
			if [ "$opt" -le 10 ] || [ "$opt" -eq 15 ]; then
				if [ -f "/data/local.prop" ]; then
					sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' /data/local.prop
					sed -i '/.*_MEM/d' /data/local.prop
				fi
				sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' /system/build.prop
				sed -i '/.*_MEM/d' /system/build.prop
				if [ -f "/system/bin/build.prop" ]; then
					sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' /system/bin/build.prop
					sed -i '/.*_MEM/d' /system/bin/build.prop
				fi
				if [ -f "/system/etc/init.d/99SuperCharger" ] || [ -f "/system/etc/init.d/S99SuperCharger" ]; then
					echo " Cleaning Up SuperCharge from /init.d folder"
					echo ""
					$sleep
					echo " Cleaning Up Grouping Fixes from /init.d folder"
					if [ -f "/system/etc/init.d/99SuperCharger" ]; then
						rm /system/etc/init.d/99SuperCharger
					else
						rm /system/etc/init.d/S99SuperCharger
					fi
					echo ""
					$sleep
				fi
				if [ -f "/data/99SuperCharger.sh" ]; then
					echo " Cleaning Up SuperCharge from /data folder"
					echo ""
					$sleep
					echo " Cleaning Up Grouping Fixes from /data folder"
					echo ""
					rm /data/99SuperCharger.sh
					$sleep
				fi
			fi
		fi
		if [ "$opt" -eq 15 ]; then
			if [ -f "/system/build.prop.unsuper" ]; then
				echo " Restoring ORIGINAL build.prop..."
				echo ""
				$sleep
				cp -fr /system/build.prop.unsuper /system/build.prop
				rm /system/build.prop.unsuper
			fi
			if [ -f "/system/bin/build.prop.unsuper" ]; then
				cp -fr /system/bin/build.prop.unsuper /system/bin/build.prop
				rm /system/bin/build.prop.unsuper
			fi
			if [ -f "/data/local.prop.unsuper" ]; then
				echo " Restoring ORIGINAL local.prop..."
				echo ""
				$sleep
				cp -fr /data/local.prop.unsuper /data/local.prop
				rm /data/local.prop.unsuper
			fi
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
			if [ -f "/data/SuperChargerOptions" ]; then
				rm /data/SuperChargerOptions
			fi
			if [ -f "/data/97BulletProof_Apps.sh" ]; then
				rm /data/97BulletProof_Apps.sh
			fi
			if [ -f "/system/etc/init.d/97BulletProof_Apps" ]; then
				rm /system/etc/init.d/97BulletProof_Apps
			fi
			if [ -f "/system/etc/init.d/S97BulletProof_Apps" ]; then
				rm /system/etc/init.d/S97BulletProof_Apps
			fi
			if [ -f "/data/Fast_Engine_Flush.sh" ]; then
				rm /data/Fast_Engine_Flush.sh
			fi
			if [ "$UnSuperCharged" -ne 1 ]; then
				echo " Removed Kernel/Memory Tweaks..."
				echo ""
				$sleep
				if [ "$UnSuperChargerError" -ne 1 ]; then
					echo " Your ROM's default minfree values are restored!"
					echo ""
					echo $line
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
		if [ "$opt" -le 14 ]; then
			if [ "$opt" -eq 14 ]; then
				echo " Removing Kernel/Virtual Memory Tweaks..."
				echo ""
				$sleep
			fi
			if [ -f "$initrcpath" ]; then
				if [ "$opt" -ne 14 ]; then
					sed -i '/BEGIN OOM_ADJ_Settings/,/.*SuperCharged/d' $initrcpath
					sed -i '/.*_ADJ/d' $initrcpath
				fi
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ]; then
					sed -i '/parameters\/adj/d' $initrcpath
					if [[ -z "$scminfree" ]]; then
						sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' $initrcpath
					fi
				fi
				if [ "$opt" -le 10 ]; then
					sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' $initrcpath
					sed -i '/.*_MEM/d' $initrcpath
					sed -i '/lowmemorykiller/d' $initrcpath
				fi
				sed -i '/vm\/.*oom.*/d' $initrcpath
				sed -i '/kernel\/panic.*/d' $initrcpath
			fi
			if [ -f "$rcpath" ]; then
				if [ "$opt" -ne 14 ]; then
					sed -i '/BEGIN OOM_ADJ_Settings/,/.*SuperCharged/d' $rcpath
					sed -i '/.*_ADJ/d' $rcpath
				fi
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ]; then
					sed -i '/parameters\/adj/d' $rcpath
					if [[ -z "$scminfree" ]]; then
						sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' $rcpath
					fi
				fi
				if [ "$opt" -le 10 ]; then
					sed -i '/.*SuperCharger/,/END OOM_MEM_Settings/d' $rcpath
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
			if [ -f "/system/etc/init.d/S99SuperCharger" ]; then
				sed -i '/.*oom.*/d' /system/etc/init.d/S99SuperCharger
				sed -i '/.*panic.*/d' /system/etc/init.d/S99SuperCharger
			fi
			if [ -f "/data/99SuperCharger.sh" ]; then
				sed -i '/.*oom.*/d' /data/99SuperCharger.sh
				sed -i '/.*panic.*/d' /data/99SuperCharger.sh
			fi
			if [ "$opt" -eq 14 ]; then
				echo "       ...Kernel/Virtual Memory Tweaks Removed!"
				echo ""
				echo $line
				echo ""
				$sleep
			fi
		fi
		if [ "$opt" -le 13 ]; then
			echo "0,4,6,8,14,15" > /data/SuperChargerAdj
			scadj=`cat /data/SuperChargerAdj`
			adj1=`awk -F , '{print $1}' /data/SuperChargerAdj`;adj2=`awk -F , '{print $2}' /data/SuperChargerAdj`;adj3=`awk -F , '{print $3}' /data/SuperChargerAdj`;adj4=`awk -F , '{print $4}' /data/SuperChargerAdj`;adj5=`awk -F , '{print $5}' /data/SuperChargerAdj`;adj6=`awk -F , '{print $6}' /data/SuperChargerAdj`
			if [ "$opt" -le 10 ]; then
				if [ -f "/data/SuperChargerMinfree" ]; then
					cp -fr /data/SuperChargerMinfree /data/SuperChargerMinfreeOld
				fi
				echo "$SL1,$SL2,$SL3,$SL4,$SL5,$SL6" > /data/SuperChargerMinfree
				scminfree=`cat /data/SuperChargerMinfree`
				if [ "$opt" -eq 10 ]; then
					echo $line
					echo ""
					if [ "$restore" -eq 1 ]; then
						echo "     Restoring Prior Cust-OOMizer Settings!"
					else
						if [ -f "/data/SuperChargerCustomMinfree" ]; then
							echo " Removing Prior Cust-OOMizer Settings..."
							echo ""
							$sleep
						fi
						if [ "$quickcharge" -eq 1 ]; then
							echo "      Saving Quick Cust-OOMizer Settings!"
						else
							echo "     Saving Your New Cust-OOMizer Settings!"
						fi
					fi
					cp -fr /data/SuperChargerMinfree /data/SuperChargerCustomMinfree
					echo ""
					$sleep
				fi
			fi
			if [ "$opt" -le 10 ]; then
				echo $line
				echo " SuperCharging Performance: $CONFIG!"
				echo $line
				echo ""
				$sleep
				echo " Out Of Memory (OOM) / lowmemorykiller values:"
				echo ""
				$sleep
				awk -F , '{print "    Old MB = "$1/256",",$2/256",",$3/256",",$4/256",",$5/256",",$6/256 " MB"}' /sys/module/lowmemorykiller/parameters/minfree
				echo "    New MB = $MB1, $MB2, $MB3, $MB4, $MB5, $MB6 MB"
				echo ""
				$sleep
				echo " Old Pages = "$currentminfree
				echo " New Pages = $scminfree"
				echo ""
				$sleep
			fi
			if [ -f "$rcpath" ]; then
				if [[ -z "$scminfree" ]] && [ "$opt" -gt 10 ] || [ "$opt" -le 10 ]; then
					sed -i '/on early/ a\
    # V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox.\
    # DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!\
    # BEGIN OOM_MEM_Settings\
    # END OOM_MEM_Settings' $rcpath
				fi
				if [ "$opt" -le 10 ]; then
					sed -i '/on boot/ a\
    write /sys/module/lowmemorykiller/parameters/minfree '$scminfree $rcpath
					sed -i '/BEGIN OOM_MEM_Settings/ a\
    setprop ro.FOREGROUND_APP_MEM '$SL1'\
    setprop ro.VISIBLE_APP_MEM '$SL2'\
    setprop ro.SECONDARY_SERVER_MEM '$SL3'\
    setprop ro.BACKUP_APP_MEM '$SL4'\
    setprop ro.HOME_APP_MEM '$SP1'\
    setprop ro.HIDDEN_APP_MEM '$SL4'\
    setprop ro.EMPTY_APP_MEM '$SL6 $rcpath
					if [ "$gb" -eq 1 ]; then
						sed -i '/ro.VISIBLE_APP_MEM/ a\
    setprop ro.PERCEPTIBLE_APP_MEM '$SP1'\
    setprop ro.HEAVY_WEIGHT_APP_MEM '$SL3 $rcpath
					else
						sed -i '/ro.HIDDEN_APP_MEM/ a\
    setprop ro.CONTENT_PROVIDER_MEM '$SL5 $rcpath
					fi
				fi
				sed -i '/on boot/ a\
    write /sys/module/lowmemorykiller/parameters/adj '$scadj $rcpath
				sed -i '/END OOM_MEM_Settings/ a\
    # BEGIN OOM_ADJ_Settings\
    setprop ro.FOREGROUND_APP_ADJ '$adj1'\
    setprop ro.VISIBLE_APP_ADJ '$adj2'\
    setprop ro.SECONDARY_SERVER_ADJ '$adj3'\
    setprop ro.BACKUP_APP_ADJ '$(($adj3+1))'\
    setprop ro.HOME_APP_ADJ '$adj2'\
    setprop ro.HIDDEN_APP_MIN_ADJ '$adj4'\
    setprop ro.EMPTY_APP_ADJ '$adj6'\
    # END OOM_ADJ_Settings\
    # End of V6 SuperCharged Entries' $rcpath
				if [ "$gb" -eq 1 ]; then
					sed -i '/ro.VISIBLE_APP_ADJ/ a\
    setprop ro.PERCEPTIBLE_APP_ADJ '$(($adj1+2))'\
    setprop ro.HEAVY_WEIGHT_APP_ADJ '$(($adj2+1)) $rcpath
				else
					sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
    setprop ro.CONTENT_PROVIDER_ADJ '$(($adj4+1)) $rcpath
				fi
				if [ "$opt" -eq 13 ]; then
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$adj1/ $rcpath
				elif [ "$opt" -eq 11 ]; then
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$(($adj1+2))/ $rcpath
				else
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$(($adj1+1))/ $rcpath
				fi
				sed -i '/minfree/ a\
    write /proc/sys/vm/oom_kill_allocating_task 0\
    write /proc/sys/vm/panic_on_oom 0\
    write /proc/sys/kernel/panic_on_oops 1\
    write /proc/sys/kernel/panic 0' $rcpath
				echo $line
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ]; then
					echo " $rcfile has been OOM Fixed!"
				else
					echo " $rcfile has been SuperCharged!"
				fi
				echo $line
				echo ""
				$sleep
				echo " For Super Stickiness..."
				echo ""
				$sleep
				echo "   ...settings will now be applied..."
				echo ""
				$sleep
				echo "       ...to /system/etc/init.d folder as well!"
				echo ""
				$sleep
			elif [ -f "$initrcpath" ]; then
				if [[ -z "$scminfree" ]] && [ "$opt" -gt 10 ] || [ "$opt" -le 10 ]; then
					sed -i '/on boot/ a\
    # V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox.\
    # DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!\
    # BEGIN OOM_MEM_Settings\
    # END OOM_MEM_Settings' $initrcpath
				fi
				if [ "$opt" -le 10 ]; then
					sed -i '/on boot/ a\
    write /sys/module/lowmemorykiller/parameters/minfree '$scminfree $initrcpath
					sed -i '/BEGIN OOM_MEM_Settings/ a\
    setprop ro.FOREGROUND_APP_MEM '$SL1'\
    setprop ro.VISIBLE_APP_MEM '$SL2'\
    setprop ro.SECONDARY_SERVER_MEM '$SL3'\
    setprop ro.BACKUP_APP_MEM '$SL4'\
    setprop ro.HOME_APP_MEM '$SP1'\
    setprop ro.HIDDEN_APP_MEM '$SL4'\
    setprop ro.EMPTY_APP_MEM '$SL6 $initrcpath
					if [ "$gb" -eq 1 ]; then
						sed -i '/ro.VISIBLE_APP_MEM/ a\
    setprop ro.PERCEPTIBLE_APP_MEM '$SP1'\
    setprop ro.HEAVY_WEIGHT_APP_MEM '$SL3 $initrcpath
					else
						sed -i '/ro.HIDDEN_APP_MEM/ a\
    setprop ro.CONTENT_PROVIDER_MEM '$SL5 $initrcpath
					fi
				fi
				sed -i '/END OOM_MEM_Settings/ a\
    # BEGIN OOM_ADJ_Settings\
    setprop ro.FOREGROUND_APP_ADJ '$adj1'\
    setprop ro.VISIBLE_APP_ADJ '$adj2'\
    setprop ro.SECONDARY_SERVER_ADJ '$adj3'\
    setprop ro.BACKUP_APP_ADJ '$(($adj3+1))'\
    setprop ro.HOME_APP_ADJ '$adj2'\
    setprop ro.HIDDEN_APP_MIN_ADJ '$adj4'\
    setprop ro.EMPTY_APP_ADJ '$adj6'\
    write /sys/module/lowmemorykiller/parameters/adj '$scadj'\
    # END OOM_ADJ_Settings\
    # End of V6 SuperCharged Entries' $initrcpath
				if [ "$gb" -eq 1 ]; then
					sed -i '/ro.VISIBLE_APP_ADJ/ a\
    setprop ro.PERCEPTIBLE_APP_ADJ '$(($adj1+2))'\
    setprop ro.HEAVY_WEIGHT_APP_ADJ '$(($adj2+1)) $initrcpath
				else
					sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
    setprop ro.CONTENT_PROVIDER_ADJ '$(($adj4+1)) $initrcpath
				fi
				if [ "$opt" -eq 13 ]; then
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$adj1/ $initrcpath
				elif [ "$opt" -eq 11 ]; then
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$(($adj1+2))/ $initrcpath
				else
					sed -i 's/.* ro.HOME_APP_ADJ .*/    setprop ro.HOME_APP_ADJ '$(($adj1+1))/ $initrcpath
				fi
				sed -i '/END OOM_ADJ_Settings/ a\
    write /proc/sys/vm/oom_kill_allocating_task 0\
    write /proc/sys/vm/panic_on_oom 0\
    write /proc/sys/kernel/panic_on_oops 1\
    write /proc/sys/kernel/panic 0' $initrcpath
				echo $line
				if [ "$initrc" -eq 0 ]; then
					echo -n "        .../data/"
				else
					echo -n "                "
				fi
				if [ "$opt" -ge 11 ] && [ "$opt" -le 13 ]; then
					echo "$initrcfile has been OOM Fixed!"
				else
					echo "$initrcfile has been SuperCharged!"
				fi
				echo $line
				echo ""
				$sleep
				if [ "$initrc" -eq 1 ]; then
					echo " For Super Stickiness..."
					echo ""
					$sleep
				fi
				echo " Settings will now be applied..."
				echo ""
				$sleep
				echo "               ...to /system/etc/init.d folder!"
				echo ""
				$sleep
			fi
			echo $line
			echo ""
			echo " Fixing Out Of Memory (OOM) Groupings..."
			echo ""
			$sleep
			echo "                    ...Fixing OOM Priorities..."
			echo ""
			$sleep
			if [ "$buildprop" -eq 0 ]; then
				if [[ -z "$scminfree" ]] && [ "$opt" -gt 10 ] || [ "$opt" -le 10 ]; then
					echo "# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox." >> /data/local.prop
					sed -i '/SuperCharger/ a\
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!\
# BEGIN OOM_MEM_Settings\
# END OOM_MEM_Settings' /data/local.prop
				fi
				if [ "$opt" -le 10 ]; then
					sed -i '/BEGIN OOM_MEM_Settings/ a\
ro.FOREGROUND_APP_MEM='$SL1'\
ro.VISIBLE_APP_MEM='$SL2'\
ro.SECONDARY_SERVER_MEM='$SL3'\
ro.BACKUP_APP_MEM='$SL4'\
ro.HOME_APP_MEM='$SP1'\
ro.HIDDEN_APP_MEM='$SL4'\
ro.EMPTY_APP_MEM='$SL6 /data/local.prop
					if [ "$gb" -eq 1 ]; then
						sed -i '/ro.VISIBLE_APP_MEM/ a\
ro.PERCEPTIBLE_APP_MEM='$SP1'\
ro.HEAVY_WEIGHT_APP_MEM='$SL3 /data/local.prop
					else
						sed -i '/ro.HIDDEN_APP_MEM/ a\
ro.CONTENT_PROVIDER_MEM='$SL5 /data/local.prop
					fi
				fi
				sed -i '/END OOM_MEM_Settings/ a\
# BEGIN OOM_ADJ_Settings\
ro.FOREGROUND_APP_ADJ='$adj1'\
ro.VISIBLE_APP_ADJ='$adj2'\
ro.SECONDARY_SERVER_ADJ='$adj3'\
ro.BACKUP_APP_ADJ='$(($adj3+1))'\
ro.HOME_APP_ADJ='$adj2'\
ro.HIDDEN_APP_MIN_ADJ='$adj4'\
ro.EMPTY_APP_ADJ='$adj6'\
# END OOM_ADJ_Settings\
#Misc. Tweaks\
persist.sys.purgeable_assets=1\
wifi.supplicant_scan_interval=120\
windowsmgr.max_events_per_sec=75\
pm.sleep_mode=1\
# End of V6 SuperCharged Entries' /data/local.prop
				if [ "$gb" -eq 1 ]; then
					sed -i '/ro.VISIBLE_APP_ADJ/ a\
ro.PERCEPTIBLE_APP_ADJ='$(($adj1+2))'\
ro.HEAVY_WEIGHT_APP_ADJ='$(($adj2+1)) /data/local.prop
				else
					sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
ro.CONTENT_PROVIDER_ADJ='$(($adj4+1)) /data/local.prop
				fi
				echo " ...OOM Groupings and Priorities are now fixed!"
				echo ""
				echo $line
				echo ""
				$sleep
				if [ "$opt" -eq 13 ]; then
					echo " Applying BulletProof Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$adj1/ /data/local.prop
					echo " Launcher is not only SuperCharged..."
					echo ""
					$sleep
					echo "                           ...It's BULLETPROOF!"
					if [ "$homeadj" -ne "$adj1" ]; then
						newlauncher=1
					fi
				elif [ "$opt" -eq 11 ]; then
					echo " Applying Hard To Kill Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$(($adj1+2))/ /data/local.prop
					echo "              ...Hard To Kill Launcher APPLIED!"
					if [ "$homeadj" -ne "$(($adj1+2))" ]; then
						newlauncher=1
					fi
				else
					echo " Applying Die-Hard Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$(($adj1+1))/ /data/local.prop
					echo "                  ...Die-Hard Launcher APPLIED!"
					if [ "$homeadj" -ne "$(($adj1+1))" ]; then
						newlauncher=1
					fi
				fi
			elif [ "$buildprop" -eq 1 ]; then
				if [[ -z "$scminfree" ]] && [ "$opt" -gt 10 ] || [ "$opt" -le 10 ]; then
					echo "# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox." >> /system/build.prop
					sed -i '/SuperCharger/ a\
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!\
# BEGIN OOM_MEM_Settings\
# END OOM_MEM_Settings' /system/build.prop
				fi
				if [ "$opt" -le 10 ]; then
					sed -i '/BEGIN OOM_MEM_Settings/ a\
ro.FOREGROUND_APP_MEM='$SL1'\
ro.VISIBLE_APP_MEM='$SL2'\
ro.SECONDARY_SERVER_MEM='$SL3'\
ro.BACKUP_APP_MEM='$SL4'\
ro.HOME_APP_MEM='$SP1'\
ro.HIDDEN_APP_MEM='$SL4'\
ro.EMPTY_APP_MEM='$SL6 /system/build.prop
					if [ "$gb" -eq 1 ]; then
						sed -i '/ro.VISIBLE_APP_MEM/ a\
ro.PERCEPTIBLE_APP_MEM='$SP1'\
ro.HEAVY_WEIGHT_APP_MEM='$SL3 /system/build.prop
					else
						sed -i '/ro.HIDDEN_APP_MEM/ a\
ro.CONTENT_PROVIDER_MEM='$SL5 /system/build.prop
					fi
				fi
				sed -i '/END OOM_MEM_Settings/ a\
# BEGIN OOM_ADJ_Settings\
ro.FOREGROUND_APP_ADJ='$adj1'\
ro.VISIBLE_APP_ADJ='$adj2'\
ro.SECONDARY_SERVER_ADJ='$adj3'\
ro.BACKUP_APP_ADJ='$(($adj3+1))'\
ro.HOME_APP_ADJ='$adj2'\
ro.HIDDEN_APP_MIN_ADJ='$adj4'\
ro.EMPTY_APP_ADJ='$adj6'\
# END OOM_ADJ_Settings\
#Misc. Tweaks\
persist.sys.purgeable_assets=1\
wifi.supplicant_scan_interval=120\
windowsmgr.max_events_per_sec=75\
pm.sleep_mode=1\
# End of V6 SuperCharged Entries' /system/build.prop
				if [ "$gb" -eq 1 ]; then
					sed -i '/ro.VISIBLE_APP_ADJ/ a\
ro.PERCEPTIBLE_APP_ADJ='$(($adj1+2))'\
ro.HEAVY_WEIGHT_APP_ADJ='$(($adj2+1)) /system/build.prop
				else
					sed -i '/ro.HIDDEN_APP_MIN_ADJ/ a\
ro.CONTENT_PROVIDER_ADJ='$(($adj4+1)) /system/build.prop
				fi
				echo " ...OOM Groupings and Priorities are now fixed!"
				echo ""
				echo $line
				echo ""
				$sleep
				if [ "$opt" -eq 13 ]; then
					echo " Applying BulletProof Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$adj1/ /system/build.prop
					echo " Launcher is not only SuperCharged..."
					echo ""
					$sleep
					echo "                           ...It's BULLETPROOF!"
				elif [ "$opt" -eq 11 ]; then
					echo " Applying Hard To Kill Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$(($adj1+2))/ /system/build.prop
					echo "              ...Hard To Kill Launcher APPLIED!"
				else
					echo " Applying Die-Hard Launcher..."
					echo ""
					$sleep
					sed -i 's/ro.HOME_APP_ADJ=.*/ro.HOME_APP_ADJ='$(($adj1+1))/ /system/build.prop
					echo "                  ...Die-Hard Launcher APPLIED!"
				fi
			fi
			echo ""
			echo $line
			echo ""
			$sleep
			echo " Applying Kernel/Memory Tweaks..."
			echo ""
			$sleep
			echo "         oom_kill_allocating_task = 0"
			echo "                     panic_on_oom = 0"
			echo "                    panic_on_oops = 1"
			echo "                            panic = 0"
			echo ""
			echo $line
			echo ""
			$sleep
			echo "#!/system/bin/sh" > /data/99SuperCharger.sh
			echo "# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox." >> /data/99SuperCharger.sh
			echo "" >> /data/99SuperCharger.sh
			if [ "$initrc" -eq 1 ]; then
cat >> /data/99SuperCharger.sh <<EOF
busybox mount -o remount,rw / 2>/dev/null;
busybox mount -o remount,rw rootfs 2>/dev/null;
if [ ! -f "$rcpath" ] && [ -f "$initrcpath" ]; then
	cp -fr $initrcpath $initrcpath1;
fi;
busybox mount -o remount,ro / 2>/dev/null;
busybox mount -o remount,ro rootfs 2>/dev/null;
EOF
			fi
cat >> /data/99SuperCharger.sh <<EOF
busybox mount -o remount,rw /system 2>/dev/null;
for m in /dev/block/mtdblock*;
do
busybox mount -o remount,rw \$m /system 2>/dev/null;
done;
currentadj=\`cat /sys/module/lowmemorykiller/parameters/adj\`;
currentminfree=\`cat /sys/module/lowmemorykiller/parameters/minfree\`;
scadj=\`cat /data/SuperChargerAdj\`;
scminfree=\`cat /data/SuperChargerMinfree\`;
if [ -d "/system/etc/init.d" ] || [ -f "/system/etc/hw_config.sh" ]; then
	if [[ -n "\`pgrep android\`" ]]; then
echo " Waiting 30 seconds (avoid conflicts)... then...";
		echo "";
		echo " Gonna SuperCharge this sucker... zOOM... zOOM!";
		sleep 30;
	fi;
fi;
if [[ -n "\$scminfree" ]] && [ "\$currentminfree" != "\$scminfree" ] || [ "\$currentadj" != "\$scadj" ]; then
	echo \$scadj > /sys/module/lowmemorykiller/parameters/adj;
	sleep 1;
EOF
			if [[ -n "$scminfree" ]]; then
				echo "	echo "\$scminfree" > /sys/module/lowmemorykiller/parameters/minfree;" >> /data/99SuperCharger.sh
				echo "	sleep 1;" >> /data/99SuperCharger.sh
			fi
			if [ "$buildprop" -eq 0 ]; then
				echo "	sed -i '/.*_ADJ/d' /system/build.prop;" >> /data/99SuperCharger.sh
				echo "	sed -i '/.*_MEM/d' /system/build.prop;" >> /data/99SuperCharger.sh
				if [ -f "/system/bin/build.prop" ]; then
					echo "	sed -i '/.*_ADJ/d' /system/bin/build.prop;" >> /data/99SuperCharger.sh
					echo "	sed -i '/.*_MEM/d' /system/bin/build.prop;" >> /data/99SuperCharger.sh
				fi
				echo "	sleep 1;" >> /data/99SuperCharger.sh
			fi
cat >> /data/99SuperCharger.sh <<EOF
	busybox sysctl -w vm.oom_kill_allocating_task=0;
	busybox sysctl -w vm.panic_on_oom=0;
	busybox sysctl -w kernel.panic_on_oops=1;
	busybox sysctl -w kernel.panic=0;
fi;
echo "\$( date +"%m-%d-%Y %H:%M:%S" ): Applied \$0" >> /data/SuperChargerRan;
busybox mount -o remount,ro /system 2>/dev/null;
for m in /dev/block/mtdblock*;
do
busybox mount -o remount,ro \$m /system 2>/dev/null;
done;
# End of V6 SuperCharged Entries
EOF
			chown 0.0 /data/99SuperCharger.sh
			chmod 777 /data/99SuperCharger.sh
			if [ ! -f "/data/local/userinit.sh" ]; then
				echo "#!/system/bin/sh" > /data/local/userinit.sh
			fi
			echo "sh /data/99SuperCharger.sh;" >> /data/local/userinit.sh
			chown 0.0 /data/local/userinit.sh
			chmod 777 /data/local/userinit.sh
			if [ -f "/system/etc/hw_config.sh" ]; then
				echo " SuperCharging /system/etc/hw_config.sh!"
				echo ""
				echo $line
				echo ""
				$sleep
				echo "# V6 SuperCharger, OOM Grouping & Priority Fixes created by zeppelinrox." >> /system/etc/hw_config.sh
				if [ "$initrc" -eq 1 ]; then
cat >> /system/etc/hw_config.sh <<EOF
busybox mount -o remount,rw / 2>/dev/null;
busybox mount -o remount,rw rootfs 2>/dev/null;
if [ ! -f "$rcpath" ] && [ -f "$initrcpath" ]; then
	cp -fr $initrcpath $initrcpath1;
fi;
busybox mount -o remount,ro / 2>/dev/null;
busybox mount -o remount,ro rootfs 2>/dev/null;
EOF
				fi
cat >> /system/etc/hw_config.sh <<EOF
busybox mount -o remount,rw /system 2>/dev/null;
for m in /dev/block/mtdblock*;
do
busybox mount -o remount,rw \$m /system 2>/dev/null;
done;
currentadj=\`cat /sys/module/lowmemorykiller/parameters/adj\`;
currentminfree=\`cat /sys/module/lowmemorykiller/parameters/minfree\`;
scadj=\`cat /data/SuperChargerAdj\`;
scminfree=\`cat /data/SuperChargerMinfree\`;
if [[ -n "\$scminfree" ]] && [ "\$currentminfree" != "\$scminfree" ] || [ "\$currentadj" != "\$scadj" ]; then
	echo \$scadj > /sys/module/lowmemorykiller/parameters/adj;
	sleep 1;
EOF
				if [[ -n "$scminfree" ]]; then
					echo "	echo "\$scminfree" > /sys/module/lowmemorykiller/parameters/minfree;" >> /system/etc/hw_config.sh
					echo "	sleep 1;" >> /system/etc/hw_config.sh
				fi
				if [ "$buildprop" -eq 0 ]; then
					echo "	sed -i '/.*_ADJ/d' /system/build.prop;" >> /system/etc/hw_config.sh
					echo "	sed -i '/.*_MEM/d' /system/build.prop;" >> /system/etc/hw_config.sh
					if [ -f "/system/bin/build.prop" ]; then
						echo "	sed -i '/.*_ADJ/d' /system/bin/build.prop;" >> /system/etc/hw_config.sh
						echo "	sed -i '/.*_MEM/d' /system/bin/build.prop;" >> /system/etc/hw_config.sh
					fi
					echo "	sleep 1;" >> /system/etc/hw_config.sh
				fi
cat >> /system/etc/hw_config.sh <<EOF
	busybox sysctl -w vm.oom_kill_allocating_task=0;
	busybox sysctl -w vm.panic_on_oom=0;
	busybox sysctl -w kernel.panic_on_oops=1;
	busybox sysctl -w kernel.panic=0;
fi;
echo "\$( date +"%m-%d-%Y %H:%M:%S" ): Applied \$0" >> /data/SuperChargerRan;
busybox mount -o remount,ro /system 2>/dev/null;
for m in /dev/block/mtdblock*;
do
busybox mount -o remount,ro \$m /system 2>/dev/null;
done;
sh /data/99SuperCharger.sh;
# End of V6 SuperCharged Entries
EOF
			fi
			if [ -d "/system/etc/init.d" ]; then
				echo " SuperCharging your init.d folder..."
				echo ""
				$sleep
				for i in /system/etc/init.d/S*; do Sfiles=$i;break;done
				if [ "$Sfiles" = "/system/etc/init.d/S*" ]; then
					cp -fr /data/99SuperCharger.sh /system/etc/init.d/99SuperCharger
					sed -i 's/.*sleep 30.*/#			sleep 30;/' /system/etc/init.d/99SuperCharger
					sed -i '/SuperCharged/ i\
sh /data/99SuperCharger.sh;' /system/etc/init.d/99SuperCharger
					chown 0.0 /system/etc/init.d/99SuperCharger
					chmod 777 /system/etc/init.d/99SuperCharger
					echo "sh /system/etc/init.d/99SuperCharger;" >> /data/local/userinit.sh
					echo "     ...with /system/etc/init.d/99SuperCharger!"
				else
					cp -fr /data/99SuperCharger.sh /system/etc/init.d/S99SuperCharger
					sed -i 's/.*sleep 30.*/#			sleep 30;/' /system/etc/init.d/S99SuperCharger
					sed -i '/SuperCharged/ i\
sh /data/99SuperCharger.sh;' /system/etc/init.d/S99SuperCharger
					chown 0.0 /system/etc/init.d/S99SuperCharger
					chmod 777 /system/etc/init.d/S99SuperCharger
					echo "sh /system/etc/init.d/S99SuperCharger;" >> /data/local/userinit.sh
					echo "    ...with /system/etc/init.d/S99SuperCharger!"
				fi
				echo ""
			else
				echo " Stock ROM? - Additional Configuration Required!"
				echo ""
				$sleep
				if [ "$opt" -le 10 ]; then
					echo " Some Changes are TEMPORARY & WON'T PERSIST!"
					echo ""
					$sleep
					echo " To enable PERSISTENT SuperCharger settings...."
					echo ""
					$sleep
					echo " ...Die-Hard Launcher and OOM Grouping Fixes..."
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
<br>
Another option is to make a Script Manager widget for <b>/data/99SuperCharger.sh</b> on your homescreen and simply launch it after each reboot.<br>
<br>
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
<br>
Another option is to make a Script Manager widget for <b>/data/99SuperCharger.sh</b> on your homescreen and simply launch it after each reboot.<br>
<br>
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
				fi
			fi
			echo $line
			$sleep
			echo "$scadj" > /sys/module/lowmemorykiller/parameters/adj
			if [ "$opt" -le 10 ]; then
				echo ""
				echo " Setting LowMemoryKiller to $MB1,$MB2,$MB3,$MB4,$MB5,$MB6 MB"
				echo ""
				$sleep
				echo "$scminfree" > /sys/module/lowmemorykiller/parameters/minfree
				currentminfree=`cat /sys/module/lowmemorykiller/parameters/minfree`
				echo " OOM minfrees levels are now set to..."
				echo ""
				$sleep
				echo "         ..."$currentminfree
				echo ""
				$sleep
				echo $line
				echo "      SUPERCHARGE IN EFFECT IMMEDIATELY!!"
				echo $line
				echo ""
				$sleep
cat > "/data/$CONFIG-($MB1,$MB2,$MB3,$MB4,$MB5,$MB6).sh" <<EOF
#!/system/bin/sh
# PowerShift Script for use with The V6 SuperCharger by zeppelinrox.

echo ""
echo " PowerShifting to different gear!"
echo ""
sleep 1
echo " Setting LowMemoryKiller to $MB1,$MB2,$MB3,$MB4,$MB5,$MB6 MB"
echo ""
sleep 1
echo $scminfree > /sys/module/lowmemorykiller/parameters/minfree
echo " OOM minfrees levels are now set to..."
echo ""
echo "         ...\`cat /sys/module/lowmemorykiller/parameters/minfree\`"
echo ""
sleep 1
echo "          ==========================="
echo "           ) PowerShift Completed! ("
echo "          ==========================="
echo ""
EOF
				cp -fr "/data/$CONFIG-($MB1,$MB2,$MB3,$MB4,$MB5,$MB6).sh" "/sdcard/V6_SuperCharger/PowerShift_Scripts/$CONFIG-($MB1,$MB2,$MB3,$MB4,$MB5,$MB6).sh"
				echo " A PowerShift Script was saved to /data folder!"
				echo ""
				$sleep
				echo " Find $CONFIG-($MB1,$MB2,$MB3,$MB4,$MB5,$MB6).sh..."
				echo ""
				$sleep
				echo "                     ...make a Widget for it..."
				echo ""
				$sleep
				echo "            ...and PowerShift between settings!"
				echo ""
				$sleep
				echo $line
			fi
			if [ "$newlauncher" -eq 1 ]; then
				echo "           LAUNCHER CHANGE DETECTED!"
				echo $line
				echo ""
				$sleep
				echo " REBOOT NOW TO ENABLE..."
				echo ""
				$sleep
				if [ "$opt" -eq 13 ]; then
					echo "          ...BULLETPROOF LAUNCHER..."
				elif [ "$opt" -eq 11 ]; then
					echo "         ...HARD TO KILL LAUNCHER..."
				else
					echo "             ...DIE-HARD LAUNCHER..."
				fi
				echo ""
				$sleep
				echo "                     ...AND OOM GROUPING FIXES!"
				echo ""
				$sleep
				echo $line
			fi
			if [ "$SuperChargerHelp" -eq 1 ]; then
				echo " RUN /data/99SuperCharger.sh AFTER EACH REBOOT!"
			elif [ "$SuperChargerScriptManagerHelp" -eq 1 ]; then
				echo " DON'T FORGET to have Script Manager load..."
				echo "            .../data/99SuperCharger.sh on boot!"
				echo "     ...or make a Script Manager WIDGET for it!"
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
				echo " If OOM Fixes are't in effect after a reboot..."
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
		ran=1
		if [ -f "/system/bin/build.prop" ]; then
			cp -fr /system/build.prop /system/bin/build.prop
		fi
#		chmod 644 /system/build.prop
#		chmod 644 /system/bin/build.prop
		if [ "$opt" -ne 15 ]; then
			echo " Backing up Re-SuperCharger files to SD Card... "
			echo ""
			$sleep
			cp -fr /system/build.prop /sdcard/V6_SuperCharger/build.prop
			if [ -f "/system/build.prop.unsuper" ]; then
				cp -fr /system/build.prop.unsuper /sdcard/V6_SuperCharger/build.prop.unsuper
			fi
			if [ -f "/data/local.prop.unsuper" ]; then
				cp -fr /data/local.prop.unsuper /sdcard/V6_SuperCharger/local.prop.unsuper
			fi
			if [ -f "/data/local.prop" ]; then
				cp -fr /data/local.prop /sdcard/V6_SuperCharger/local.prop
			fi
			if [ -f "/data/local/userinit.sh" ]; then
				cp -fr /data/local/userinit.sh /sdcard/V6_SuperCharger/userinit.sh
			fi
			if [ -f "$rcpath" ]; then
				cp -fr $rcpath /sdcard/V6_SuperCharger
			fi
			if [ -f "$rcbackup" ]; then
				cp -fr $rcbackup /sdcard/V6_SuperCharger
			fi
			if [ -f "$initrcpath" ]; then
				cp -fr $initrcpath /sdcard/V6_SuperCharger
			fi
			if [ -f "$initrcbackup" ]; then
				cp -fr $initrcbackup /sdcard/V6_SuperCharger
			fi
			if [ -f "/system/etc/hw_config.sh" ]; then
				cp -fr /system/etc/hw_config.sh /sdcard/V6_SuperCharger/hw_config.sh
			fi
			if [ -f "/system/etc/init.d/99SuperCharger" ]; then
				cp -fr /system/etc/init.d/99SuperCharger /sdcard/V6_SuperCharger/99SuperCharger
			fi
			if [ -f "/system/etc/init.d/S99SuperCharger" ]; then
				cp -fr /system/etc/init.d/S99SuperCharger /sdcard/V6_SuperCharger/S99SuperCharger
			fi
			if [ -f "/data/99SuperCharger.sh" ]; then
				cp -fr /data/99SuperCharger.sh /sdcard/V6_SuperCharger/99SuperCharger.sh
			fi
			if [ -f "/data/SuperChargerAdj" ]; then
				cp -fr /data/SuperChargerAdj /sdcard/V6_SuperCharger/SuperChargerAdj
			fi
			if [ -f "/data/SuperChargerMinfree" ]; then
				cp -fr /data/SuperChargerMinfree /sdcard/V6_SuperCharger/SuperChargerMinfree
			fi
			if [ -f "/data/SuperChargerCustomMinfree" ]; then
				cp -fr /data/SuperChargerCustomMinfree /sdcard/V6_SuperCharger/SuperChargerCustomMinfree
			fi
			if [ -f "/data/SuperChargerOptions" ]; then
				cp -fr /data/SuperChargerOptions /sdcard/V6_SuperCharger/SuperChargerOptions
			fi
			echo "            ...Re-SuperCharger backup complete!"
			echo ""
			echo $line
			echo ""
			$sleep
			if [ "$newsupercharger" -eq 1 ]; then
				echo " I think this is your FIRST SuperCharge..."
				echo ""
				$sleep
				echo " Select YES in the next step to..."
				echo ""
				$sleep
				echo $line
				echo "                     ...SuperClean and ReStart!"
				echo $line
				echo ""
				$sleep
				opt=29
				echo -n " Press Return Key..."
				read return
				echo ""
				$sleep
			fi
		fi
	fi
	if [ "$opt" -eq 16 ] || [ "$opt" -eq 17 ]; then
		if [ "$opt" -eq 16 ]; then
			echo "             Does Your OOM Stick?!"
			echo "             ====================="
			echo ""
			$sleep
			echo " Find Out Here... AND Find Your Home Launcher!!"
			echo ""
			$sleep
			echo " There are 2 OOM Sticks to choose from..."
			echo ""
			$sleep
			echo " zOOM Stick (Quick) Mode is faster..."
			echo ""
			$sleep
			echo " ...it shows App Name, Priority (ADJ), and PID!"
			echo ""
			$sleep
			echo " vrOOM Stick (Verbose) mode is slower..."
			echo ""
			$sleep
			echo "         ...but adds Path and/or Apk file info!"
			echo ""
			echo $line
			echo ""
			$sleep
			echo " Do you want vrOOM or zOOM Stick mode?"
			echo ""
			$sleep
			echo -n " Enter V for vrOOM, any key for zOOM: "
			read chooseverifier
			echo ""
			echo $line
			case $chooseverifier in
			  v|V)echo " vrOOM Stick Verifier (Verbose) selected..."
				  vroomverifier=1;;
			   *)echo " zOOM Stick Verifier (Quick) selected..."
				 vroomverifier=0;;
			esac
			echo $line
			echo ""
			$sleep
		fi
		if [ "$opt" -eq 17 ]; then
			echo " This will attempt to lock an app in memory!"
			echo ""
			$sleep
			echo " Do you want to view the current process list?"
			echo ""
			echo -n " Enter N for No, any key for Yes: "
			read bp
			echo ""
			echo $line
			case $bp in
			  n|N)echo " Okay... maybe next time!";;
			  *)echo " Loading zOOM Stick Verifier (Quick)..."
				vroomverifier=0
				echo $line
				echo ""
				$sleep;;
			esac
		fi
		if [[ -n "$vroomverifier" ]]; then
			oomadj1=`awk -F , '{print $1}' /sys/module/lowmemorykiller/parameters/adj`;oomadj2=`awk -F , '{print $2}' /sys/module/lowmemorykiller/parameters/adj`;oomadj3=`awk -F , '{print $3}' /sys/module/lowmemorykiller/parameters/adj`;oomadj4=`awk -F , '{print $4}' /sys/module/lowmemorykiller/parameters/adj`;oomadj5=`awk -F , '{print $5}' /sys/module/lowmemorykiller/parameters/adj`;oomadj6=`awk -F , '{print $6}' /sys/module/lowmemorykiller/parameters/adj`
		fi
		if [[ -n "$vroomverifier" ]] && [ "$vroomverifier" -eq 0 ]; then
			echo "----====zeppelinrox's OOM Stick Verifier====----"
			echo ""
			$sleep
			echo " Using zOOM Stick Mode (Quick)..."
			echo ""
			$sleep
			echo " ADJ	PID	Process"
			echo ""
			echo " FOREGROUND_APP OOM GROUPING"
			echo " ==========================="
			if [ "$HL" -gt -18 ] && [ "$HL" -lt "$oomadj1" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt -18 ] && [ "`cat $i/oom_adj`" -lt "$oomadj1" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				echo -n " `cat $i/oom_adj`	"
				echo -n $pid
				echo "	$appname"
			fi
			done
			if [ "$HL" -eq "$oomadj1" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -eq "$oomadj1" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				echo -n " `cat $i/oom_adj`	"
				echo -n $pid
				echo "	$appname"
			fi
			done
			echo ""
			if [[ -n "$scadj" ]] && [ "$currentadj" = "$scadj" ] && [ "$oomstick" -eq 1 ] && [ "$HL" -ne "$oomadj1" ]; then
				echo " HOME_LAUNCHER OOM GROUPING!"
				echo " ==========================="
				for i in ls /proc/*
				do
				if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj1" ] && [ "`cat $i/oom_adj`" -lt "$oomadj2" ]; then
					if [ "`cat $i/oom_adj`" -eq "$HL" ] && [ "$HL" -ne "$PA" ]; then
						echo ""
						echo " Home Launcher is on the NEXT line! (ADJ=$HL)"
					fi
					cmdline=`cat $i/cmdline`
					appname=${cmdline##*/}
					pid=${i##*/}
					echo -n " `cat $i/oom_adj`	"
					echo -n $pid
					echo "	$appname"
					if [ "`cat $i/oom_adj`" -eq "$HL" ]; then
						echo ""
					fi
				fi
				done
				echo ""
				echo " VISIBLE_APP OOM GROUPING"
				echo " ========================"
				for i in ls /proc/*
				do
				if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -eq "$oomadj2" ]; then
					cmdline=`cat $i/cmdline`
					appname=${cmdline##*/}
					pid=${i##*/}
					echo -n " `cat $i/oom_adj`	"
					echo -n $pid
					echo "	$appname"
				fi
				done
			else
				echo " VISIBLE_APP OOM GROUPING"
				echo " ========================"
				if [ "$HL" -gt "$oomadj1" ] && [ "$HL" -le "$oomadj2" ]; then
					echo ""
					echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
					echo ""
				fi
				for i in ls /proc/*
				do
				if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj1" ] && [ "`cat $i/oom_adj`" -le "$oomadj2" ]; then
					cmdline=`cat $i/cmdline`
					appname=${cmdline##*/}
					pid=${i##*/}
					echo -n " `cat $i/oom_adj`	"
					echo -n $pid
					echo "	$appname"
				fi
				done
			fi
			echo ""
			echo " SECONDARY_SERVER OOM GROUPING"
			echo " ============================="
			if [ "$HL" -gt "$oomadj2" ] && [ "$HL" -le "$oomadj3" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj2" ] && [ "`cat $i/oom_adj`" -le "$oomadj3" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				echo -n " `cat $i/oom_adj`	"
				echo -n $pid
				echo "	$appname"
			fi
			done
			echo ""
			echo " HIDDEN_APP OOM GROUPING"
			echo " ======================="
			if [ "$HL" -gt "$oomadj3" ] && [ "$HL" -le "$oomadj4" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj3" ] && [ "`cat $i/oom_adj`" -le "$oomadj4" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				echo -n " `cat $i/oom_adj`	"
				echo -n $pid
				echo "	$appname"
			fi
			done
			echo ""
			echo " CONTENT_PROVIDER OOM GROUPING"
			echo " ============================="
			if [ "$HL" -gt "$oomadj4" ] && [ "$HL" -le "$oomadj5" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj4" ] && [ "`cat $i/oom_adj`" -le "$oomadj5" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				echo -n " `cat $i/oom_adj`	"
				echo -n $pid
				echo "	$appname"
			fi
			done
			echo ""
			echo " EMPTY_APP OOM GROUPING"
			echo " ======================"
			if [ "$HL" -gt "$oomadj5" ] && [ "$HL" -le "$oomadj6" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj5" ] && [ "`cat $i/oom_adj`" -le "$oomadj6" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				echo -n " `cat $i/oom_adj`	"
				echo -n $pid
				echo "	$appname"
			fi
			done
			echo ""
			echo $line
			if [ "$opt" -eq 16 ]; then
				echo "              zOOM Stick Complete!"
			fi
		elif [[ -n "$vroomverifier" ]] && [ "$vroomverifier" -eq 1 ]; then
			echo "----====zeppelinrox's OOM Stick Verifier====----"
			echo ""
			$sleep
			echo " Using vrOOM Stick Mode (Verbose)..."
			echo ""
			$sleep
			echo " ADJ  PID        Process/Path        (APK)"
			echo ""
			echo " FOREGROUND_APP OOM GROUPING"
			echo " ==========================="
			if [ "$HL" -gt -18 ] && [ "$HL" -lt "$oomadj1" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt -18 ] && [ "`cat $i/oom_adj`" -lt "$oomadj1" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				apkpath=`pm list packages -f $appname`
				apkpath2=${apkpath#*:}
				apkname=${apkpath2%%=*}
				echo -n " `cat $i/oom_adj`  "
				echo -n $pid
				if [[ -n "$apkpath" ]]; then
#					echo -n "  $appname"
					echo -n "  $cmdline"
					echo "  ($apkname)"
				else
#					echo "  $appname"
					echo "  $cmdline"
				fi
			fi
			done
			if [ "$HL" -eq "$oomadj1" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -eq "$oomadj1" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				apkpath=`pm list packages -f $appname`
				apkpath2=${apkpath#*:}
				apkname=${apkpath2%%=*}
				echo -n " `cat $i/oom_adj`  "
				echo -n $pid
				if [[ -n "$apkpath" ]]; then
#					echo -n "  $appname"
					echo -n "  $cmdline"
					echo "  ($apkname)"
				else
#					echo "  $appname"
					echo "  $cmdline"
				fi
			fi
			done
			echo ""
			if [[ -n "$scadj" ]] && [ "$currentadj" = "$scadj" ] && [ "$oomstick" -eq 1 ] && [ "$HL" -ne "$oomadj1" ]; then
				echo " HOME_LAUNCHER OOM GROUPING!"
				echo " ==========================="
				for i in ls /proc/*
				do
				if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj1" ] && [ "`cat $i/oom_adj`" -lt "$oomadj2" ]; then
					if [ "`cat $i/oom_adj`" -eq "$HL" ] && [ "$HL" -ne "$PA" ]; then
						echo ""
						echo " Home Launcher is on the NEXT line! (ADJ=$HL)"
					fi
					cmdline=`cat $i/cmdline`
					appname=${cmdline##*/}
					pid=${i##*/}
					apkpath=`pm list packages -f $appname`
					apkpath2=${apkpath#*:}
					apkname=${apkpath2%%=*}
					echo -n " `cat $i/oom_adj`  "
					echo -n $pid
					if [[ -n "$apkpath" ]]; then
#						echo -n "  $appname"
						echo -n "  $cmdline"
						echo "  ($apkname)"
					else
#						echo "  $appname"
						echo "  $cmdline"
					fi
					if [ "`cat $i/oom_adj`" -eq "$HL" ]; then
						echo ""
					fi
				fi
				done
				echo ""
				echo " VISIBLE_APP OOM GROUPING"
				echo " ========================"
				for i in ls /proc/*
				do
				if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -eq "$oomadj2" ]; then
					cmdline=`cat $i/cmdline`
					appname=${cmdline##*/}
					pid=${i##*/}
					apkpath=`pm list packages -f $appname`
					apkpath2=${apkpath#*:}
					apkname=${apkpath2%%=*}
					echo -n " `cat $i/oom_adj`  "
					echo -n $pid
					if [[ -n "$apkpath" ]]; then
#						echo -n "  $appname"
						echo -n "  $cmdline"
						echo "  ($apkname)"
					else
#						echo "  $appname"
						echo "  $cmdline"
					fi
				fi
				done
			else
				echo " VISIBLE_APP OOM GROUPING"
				echo " ========================"
				if [ "$HL" -gt "$oomadj1" ] && [ "$HL" -le "$oomadj2" ]; then
					echo ""
					echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
					echo ""
				fi
				for i in ls /proc/*
				do
				if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj1" ] && [ "`cat $i/oom_adj`" -le "$oomadj2" ]; then
					cmdline=`cat $i/cmdline`
					appname=${cmdline##*/}
					pid=${i##*/}
					apkpath=`pm list packages -f $appname`
					apkpath2=${apkpath#*:}
					apkname=${apkpath2%%=*}
					echo -n " `cat $i/oom_adj`  "
					echo -n $pid
					if [[ -n "$apkpath" ]]; then
#						echo -n "  $appname"
						echo -n "  $cmdline"
						echo "  ($apkname)"
					else
#						echo "  $appname"
						echo "  $cmdline"
					fi
				fi
				done
			fi
			echo ""
			echo " SECONDARY_SERVER OOM GROUPING"
			echo " ============================="
			if [ "$HL" -gt "$oomadj2" ] && [ "$HL" -le "$oomadj3" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj2" ] && [ "`cat $i/oom_adj`" -le "$oomadj3" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				apkpath=`pm list packages -f $appname`
				apkpath2=${apkpath#*:}
				apkname=${apkpath2%%=*}
				echo -n " `cat $i/oom_adj`  "
				echo -n $pid
				if [[ -n "$apkpath" ]]; then
#					echo -n "  $appname"
					echo -n "  $cmdline"
					echo "  ($apkname)"
				else
#					echo "  $appname"
					echo "  $cmdline"
				fi
			fi
			done
			echo ""
			echo " HIDDEN_APP OOM GROUPING"
			echo " ======================="
			if [ "$HL" -gt "$oomadj3" ] && [ "$HL" -le "$oomadj4" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj3" ] && [ "`cat $i/oom_adj`" -le "$oomadj4" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				apkpath=`pm list packages -f $appname`
				apkpath2=${apkpath#*:}
				apkname=${apkpath2%%=*}
				echo -n " `cat $i/oom_adj`  "
				echo -n $pid
				if [[ -n "$apkpath" ]]; then
#					echo -n "  $appname"
					echo -n "  $cmdline"
					echo "  ($apkname)"
				else
#					echo "  $appname"
					echo "  $cmdline"
				fi
			fi
			done
			echo ""
			echo " CONTENT_PROVIDER OOM GROUPING"
			echo " ============================="
			if [ "$HL" -gt "$oomadj4" ] && [ "$HL" -le "$oomadj5" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj4" ] && [ "`cat $i/oom_adj`" -le "$oomadj5" ]; then
				cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				apkpath=`pm list packages -f $appname`
				apkpath2=${apkpath#*:}
				apkname=${apkpath2%%=*}
				echo -n " `cat $i/oom_adj`  "
				echo -n $pid
				if [[ -n "$apkpath" ]]; then
#					echo -n "  $appname"
					echo -n "  $cmdline"
					echo "  ($apkname)"
				else
#					echo "  $appname"
					echo "  $cmdline"
				fi
			fi
			done
			echo ""
			echo " EMPTY_APP OOM GROUPING"
			echo " ======================"
			if [ "$HL" -gt "$oomadj5" ] && [ "$HL" -le "$oomadj6" ]; then
				echo ""
				echo " HOME LAUNCHER IS IN HERE! (ADJ=$HL)"
				echo ""
			fi
			for i in ls /proc/*
			do
			if [ -f "$i/oom_adj" ] && [[ -n "`cat $i/cmdline`" ]] && [ "`cat $i/oom_adj`" -gt "$oomadj5" ] && [ "`cat $i/oom_adj`" -le "$oomadj6" ]; then						cmdline=`cat $i/cmdline`
				appname=${cmdline##*/}
				pid=${i##*/}
				apkpath=`pm list packages -f $appname`
				apkpath2=${apkpath#*:}
				apkname=${apkpath2%%=*}
				echo -n " `cat $i/oom_adj`  "
				echo -n $pid
				if [[ -n "$apkpath" ]]; then
#					echo -n "  $appname"
					echo -n "  $cmdline"
					echo "  ($apkname)"
				else
#					echo "  $appname"
					echo "  $cmdline"
				fi
			fi
			done
			echo ""
			echo $line
			echo "             vrOOM Stick Complete!"
		fi
		if [[ -n "$vroomverifier" ]] && [ "$opt" -eq 17 ]; then
		  while :
		  do
			bpps=;bppid=;bpcmdline=;bpappname=
			echo ""
			$sleep
			echo " Enter a unique segment of the process name..."
			echo ""
			$sleep
			echo " Example: \"Opera\" for Opera Browser..."
			echo ""
			$sleep
			echo -n " Or press the Return key to exit: "
			read bpps
			echo ""
			echo $line
			if [[ -z "$bpps" ]]; then
				echo " Okay... Sunday drivers... sheesh! ;-)"
				again=
			elif [ "`pgrep $bpps`" ]; then
				bppid=`pgrep $bpps`
				if [[ -f "/proc/$bppid/cmdline" ]]; then
					bpcmdline=`cat /proc/$bppid/cmdline`
					bpappname=${bpcmdline##*/}
				else
					echo " Insufficient fuel for thought..."
				fi
				if [[ -n "$bpappname" ]]; then
					echo " Found $bpappname..."
					echo ""
					$sleep
					echo "-17" > /proc/`pgrep $bpps`/oom_adj
					renice -20 `pgrep $bpps`
					echo " $bpappname has been BulletProofed!"
					echo ""
					$sleep
					echo -n " $bpappname's oom score is "
					cat /proc/`pgrep $bpps`/oom_score
					echo ""
					$sleep
					echo -n " $bpappname's oom priority is "
					cat /proc/`pgrep $bpps`/oom_adj
					echo $line
					echo ""
					$sleep
					echo " Save BulletProof \"One-Shot\" Script to SD Card?"
					echo ""
					$sleep
					echo " If so, with Script Manager..."
					echo ""
					$sleep
					echo " ...make a quick launch widget for it..."
					echo ""
					$sleep
					echo "              ...or put it on a timed schedule!"
					echo ""
					echo $line
					echo -n " Enter N for No, any key for Yes: "
					read bpsps
					echo ""
					echo $line
					case $bpsps in
					  n|N)echo " Okay... maybe next time!";;
					  *)cat > /sdcard/V6_SuperCharger/BulletProof_One_Shots/1Shot-$bpappname.sh <<EOF
#!/system/bin/sh
# BulletProof \"One-Shot\" Script by zeppelinrox.

if [ "\`pgrep $bpappname\`" ]; then
	echo ""
	echo -17 > /proc/\`pgrep $bpappname\`/oom_adj
	renice -20 \`pgrep $bpappname\`
	echo " BulletProofed $bpappname!"
	echo ""
	echo -n " $bpappname's oom score is "
	cat /proc/\`pgrep $bpappname\`/oom_score
	echo ""
	echo -n " $bpappname's oom priority is "
	cat /proc/\`pgrep $bpappname\`/oom_adj
	echo ""
	echo "    ======================================="
	echo "     ) BulletProof \"One-Shot\" Completed! ("
	echo "    ======================================="
	echo ""
else
	echo ""
	echo " Can't find $bpappname running..."
	echo ""
	$sleep
	echo "             ...so it can't be BulletProofed :("
	echo ""
fi
EOF
						echo " Saved 1Shot-$bpappname.sh to..."
						echo ""
						$sleep
						echo " /sdcard/V6_SuperCharger/BulletProof_One_Shots!";;
					esac
					echo $line
					echo ""
					$sleep
					echo " Append to 97BulletProof_Apps Boot Script?"
					echo ""
					$sleep
					echo $line
					echo " Warning: This may stall boot up on some ROMS!"
					echo $line
					echo ""
					$sleep
					echo " As noted above, you can make a widget for it..."
					echo ""
					$sleep
					echo "              ...or put it on a timed schedule!"
					echo ""
					$sleep
					echo -n " Enter Y for Yes, any key for No: "
					read bpabs
					echo ""
					echo $line
					case $bpabs in
					  y|Y)if [ ! -f "/data/97BulletProof_Apps.sh" ]; then
cat > /data/97BulletProof_Apps.sh <<EOF
#!/system/bin/sh
# BulletProof Apps Boot Script by zeppelinrox.

if [ -d "/system/etc/init.d" ] || [ -f "/system/etc/hw_config.sh" ]; then
	if [[ -n "\`pgrep android\`" ]]; then
		sleep 90;
	fi;
fi;
EOF
						  fi
						  sed -i '/Begin '$bpappname'/,/End '$bpappname'/d' /data/97BulletProof_Apps.sh
						  sed -i '/'$bpappname'/d' /data/97BulletProof_Apps.sh
						  cat >> /data/97BulletProof_Apps.sh <<EOF
# Begin $bpappname BulletProofing
if [ "\`pgrep $bpappname\`" ]; then
	echo "";
	echo -17 > /proc/\`pgrep $bpappname\`/oom_adj;
	renice -20 \`pgrep $bpappname\`;
	echo " BulletProofed $bpappname!";
	echo "";
	echo -n " $bpappname's oom score is ";
	cat /proc/\`pgrep $bpappname\`/oom_score;
	echo "";
	echo -n " $bpappname's oom priority is ";
	cat /proc/\`pgrep $bpappname\`/oom_adj;
	echo "";
else
	echo "";
	echo " Can't find $bpappname running...";
	echo "";
	$sleep;
	echo "             ...so it can't be BulletProofed :(";
	echo "";
fi;
# End $bpappname BulletProofing
EOF
						  chown 0.0 /data/97BulletProof_Apps.sh
						  chmod 777 /data/97BulletProof_Apps.sh
						  cp -fr /data/97BulletProof_Apps.sh /sdcard/V6_SuperCharger/97BulletProof_Apps.sh
						  echo " $bpappname was added to..."
						  echo ""
						  $sleep
						  if [ -d "/system/etc/init.d" ]; then
							for i in /system/etc/init.d/S*; do Sfiles=$i;break;done
							if [ "$Sfiles" = "/system/etc/init.d/S*" ]; then
								cp -fr /data/97BulletProof_Apps.sh /system/etc/init.d/97BulletProof_Apps
								echo "sh /data/97BulletProof_Apps.sh;" >> /system/etc/init.d/97BulletProof_Apps
								chown 0.0 /system/etc/init.d/97BulletProof_Apps
								chmod 777 /system/etc/init.d/97BulletProof_Apps
								cp -fr /system/etc/init.d/97BulletProof_Apps /sdcard/V6_SuperCharger/97BulletProof_Apps
								echo "      .../system/etc/init.d/97BulletProof_Apps!"
							else
								cp -fr /data/97BulletProof_Apps.sh /system/etc/init.d/S97BulletProof_Apps
								echo "sh /data/97BulletProof_Apps.sh;" >> /system/etc/init.d/S97BulletProof_Apps
								chown 0.0 /system/etc/init.d/S97BulletProof_Apps
								chmod 777 /system/etc/init.d/S97BulletProof_Apps
								cp -fr /system/etc/init.d/S97BulletProof_Apps /sdcard/V6_SuperCharger/S97BulletProof_Apps
								echo "     .../system/etc/init.d/S97BulletProof_Apps!"
							fi
						  else
							echo "                .../data/97BulletProof_Apps.sh!"
							echo $line
							echo ""
							$sleep
							if [[ -n "$smrun" ]]; then
								echo "THIS app can load 97BulletProof_Apps.sh on boot!"
								echo ""
							fi
						  fi;;
						*)echo " Okay... maybe next time!";;
					esac
				fi
			else
				echo " Can't find $bpps running..."
				echo ""
				$sleep
				echo "             ...so it can't be BulletProofed :("
			fi
			if [[ -n "$bpps" ]]; then
				echo $line
				echo ""
				$sleep
				echo " BulletProof another app?"
				echo ""
				$sleep
				echo -n " Enter Y for Yes, any key for No: "
				read again
				echo ""
			fi
			case $again in
			  y|Y)echo $line;;
			  *)break;;
		    esac
		  done
		fi
		echo $line
		echo ""
		$sleep
	fi
	if [ "$opt" -eq 18 ]; then
		# see http://www.droidforums.net/forum/liberty-rom-d2/122733-tutorial-sysctl-you-guide-better-preformance-battery-life.html
		# credit imoseyon
		echo " Your device may get laggy after a day or two.."
		echo ""
		$sleep
		echo "                    ...if you haven't rebooted."
		echo ""
		$sleep
		echo " It happens when system caches keep growing..."
		echo ""
		$sleep
		echo "            ...and free RAM keeps shrinking..."
		echo ""
		$sleep
		echo "           ...and apps are starved for memory!"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " This Engine Flush will give you a Quick Boost!"
		echo ""
		$sleep
		echo " The system will drop all file system caches..."
		echo ""
		$sleep
		echo "       ...which means more free RAM and no lag!"
		echo ""
		$sleep
		echo "                        ..so no need to reboot!"
		echo ""
		$sleep
		echo $line
		echo " Credit to imoseyon for making this more known!"
		echo $line
		echo ""
		$sleep
		rambytesused=`free | awk '{ print $3 }' | sed -n 2p`
		rambytesfree=`free | awk '{ print $4 }' | sed -n 2p`
		ramused=$(($rambytesused/1024))
		ramfree=$(($rambytesfree/1024))
		echo " Current RAM stats:"
		echo ""
		$sleep
		echo " Total: $ram MB   Used: $ramused MB   Free: $ramfree MB"
		echo ""
		echo $line
		echo ""
		$sleep
		echo " Continue and drop all file system caches?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read flush
		echo ""
		echo $line
		case $flush in
		  y|Y)busybox sync; echo 3 > /proc/sys/vm/drop_caches
			  sleep 2
			  echo 0 > /proc/sys/vm/drop_caches
			  echo " Engine Flush Completed!"
			  echo $line
			  echo ""
			  $sleep
			  rambytesused=`free | awk '{ print $3 }' | sed -n 2p`
			  rambytesfree=`free | awk '{ print $4 }' | sed -n 2p`
			  ramused=$(($rambytesused/1024))
			  ramfree=$(($rambytesfree/1024))
			  echo " Updated RAM stats:"
			  echo ""
			  $sleep
			  echo " Total: $ram MB   Used: $ramused MB   Free: $ramfree MB"
			  echo ""
			  $sleep
			  echo $line
			  echo "                   ...Enjoy Your Quick Boost :)";;
		  *)echo " File system caches were retained...";;
		esac
		echo $line
		echo ""
		$sleep
cat > /data/Fast_Engine_Flush.sh <<EOF
#!/system/bin/sh
# Fast Engine Flush script by zeppelinrox.
# Credit imoseyon for making the drop caches command more well known :)
# Credit dorimanx (Cool XDA dev!) for the neat idea to show before and after stats :D

clear
echo ""
sleep 1
rambytes=\`free | awk '{ print \$2 }' | sed -n 2p\`
rambytesused=\`free | awk '{ print \$3 }' | sed -n 2p\`
rambytesfree=\`free | awk '{ print \$4 }' | sed -n 2p\`
ram=\$((\$rambytes/1024))
ramused=\$((\$rambytesused/1024))
ramfree=\$((\$rambytesfree/1024))
echo " RAM Stats BEFORE Engine Flush..."
echo ""
sleep 1
echo " Total: \$ram MB   Used: \$ramused MB   Free: \$ramfree MB"
echo ""
echo ""
busybox sync; echo 3 > /proc/sys/vm/drop_caches
sleep 3
echo 1 > /proc/sys/vm/drop_caches
rambytes=\`free | awk '{ print \$2 }' | sed -n 2p\`
rambytesused=\`free | awk '{ print \$3 }' | sed -n 2p\`
rambytesfree=\`free | awk '{ print \$4 }' | sed -n 2p\`
ram=\$((\$rambytes/1024))
ramused=\$((\$rambytesused/1024))
ramfree=\$((\$rambytesfree/1024))
echo " RAM Stats AFTER Engine Flush..."
echo ""
sleep 1
echo " Total: \$ram MB   Used: \$ramused MB   Free: \$ramfree MB"
echo ""
sleep 1
echo "       =================================="
echo "        ) Fast Engine Flush Completed! ("
echo "       =================================="
echo ""
EOF
		cp -fr /data/Fast_Engine_Flush.sh /sdcard/V6_SuperCharger/Fast_Engine_Flush.sh
		echo " For fast flushing..."
		echo ""
		$sleep
		echo "     .../data/Fast_Engine_Flush.sh was created!"
		echo ""
		$sleep
		echo " With Script Manager..."
		echo ""
		$sleep
		echo "         ...make a widget for it..."
		echo ""
		$sleep
		echo "              ...or put it on a timed schedule!"
		echo ""
		echo $line
		echo ""
		$sleep
	fi
	if [ "$opt" -eq 19 ]; then
		echo " This is EXPERIMENTAL..."
		echo ""
		$sleep
		echo "              ...it may improve multitasking..."
		echo ""
		$sleep
		echo "    ...it may make your device even snappier..."
		echo ""
		$sleep
		echo "                 ...it may really do nothing..."
		echo ""
		$sleep
		echo "     But some people swear that it's great!"
		echo ""
		$sleep
		echo " Values are added at the bottom of build.prop!"
		echo ""
		echo $line
		echo ""
		$sleep
		while :
		do
		 echo -n " Enter 1 (Install), 2 (Uninstall), 3 (Exit): "
		 read nitro
		 case $nitro in
		   1)break;;
		   2)break;;
		   3)break;;
		   *)echo ""
			 echo "      Invalid entry... Please try again :)"
			 echo ""
			 $sleep;;
		 esac
		done
		if [ "$nitro" -ne 3 ]; then
			echo ""
			echo $line
			if [ "$nitro" -eq 1 ]; then
				if [ -f "/system/build.prop.unsuper" ]; then
					echo " Leaving ORIGINAL build.prop backup intact..."
				else
					echo " Backing up ORIGINAL build.prop..."
					echo ""
					$sleep
					cp -r /system/build.prop /system/build.prop.unsuper
					echo "              ...as /system/build.prop.unsuper!"
				fi
				echo $line
				cp -r /system/build.prop /sdcard/V6_SuperCharger/build.prop.unsuper
			fi
			echo ""
			$sleep
			if [ -f "/system/bin/build.prop" ] && [ ! -f "/system/bin/build.prop.unsuper" ]; then
				cp -r /system/bin/build.prop /system/bin/build.prop.unsuper
			fi
			sed -i '/Nullifier/,/Nullified/d' /system/build.prop
			if [ "$nitro" -eq 1 ]; then
cat >> /system/build.prop <<EOF
# Nitro Lag Nullifier by zeppelinrox.
# DO NOT DELETE COMMENTS. DELETING COMMENTS WILL BREAK UNINSTALL ROUTINE!
ENFORCE_PROCESS_LIMIT=false
MAX_SERVICE_INACTIVITY=
MIN_HIDDEN_APPS=
MAX_HIDDEN_APPS=
CONTENT_APP_IDLE_OFFSET=
EMPTY_APP_IDLE_OFFSET=
MAX_ACTIVITIES=
ACTIVITY_INACTIVE_RESET_TIME=
# End of Nullified Entries
EOF
				echo " Nitro Lag Nullifier installed..."
			else
				echo " Uninstalled Nitro Lag Nullifier..."
			fi
			echo ""
			$sleep
			if [ -f "/system/bin/build.prop" ]; then
				cp -fr /system/build.prop /system/bin/build.prop
			fi
			echo "                            ...Reboot required!"
#			chmod 644 /system/build.prop
#			chmod 644 /system/bin/build.prop
		fi
		echo ""
		echo $line
		echo ""
		$sleep
	fi
	if [ "$opt" -eq 20 ]; then
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
		echo $line
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
	if [ "$opt" -eq 29 ]; then
		if [ "$newsupercharger" -eq 1 ]; then
			echo "              ==================="
			echo "             //// SUPERCLEAN! \\\\\\\\"
			echo $line
			echo ""
			$sleep
		fi
		echo " This tool will wipe BOTH..."
		echo ""
		$sleep
		echo "       ...dalvik cache AND the cache partition!"
		echo ""
		$sleep
		echo $line
		echo "     Bootloops are LESS likely to happen :)"
		echo $line
		echo ""
		$sleep
		echo " Initial boot will take a long time but..."
		echo ""
		$sleep
		echo "    ...your system will be clean and efficient!"
		echo ""
		$sleep
		echo $line
		echo " If the screen freezes during boot..."
		echo ""
		$sleep
		echo "         ...pull the battery and retry..."
		echo ""
		$sleep
		echo "    ...sometimes it takes 3 or more tries..."
		echo ""
		$sleep
		echo "           ...as everything gets re-configured!"
		echo $line
		echo ""
		$sleep
		echo " Do you want to SuperClean and ReStart?"
		echo ""
		$sleep
		echo -n " Enter Y for Yes, any key for No: "
		read superclean
		echo ""
		case $superclean in
		   y|Y) rm -fr /data/dalvik-cache/* 2>/dev/null
				rm -fr /cache/* 2>/dev/null
				echo ""
				echo " All cleaned up and ready to..."
				echo ""
				$sleep
				echo $line
				echo "                    !!POOF!!"
				echo $line
				echo ""
				busybox sync
				echo 1 > /proc/sys/kernel/sysrq
				echo b > /proc/sysrq-trigger
				$sleep
				echo "  If it don't go poofie, just reboot manually!"
				reboot;;
			  *)echo $line
				echo " Okay... maybe next time!"
				echo $line;;
		esac
		echo ""
		$sleep
	fi
	if [ "$opt" -ne 15 ] && [ "$opt" -ne 30 ]; then
		echo -n " Press Return Key..."
		read return
		echo ""
		$sleep
		echo " Returning to Driver's Console..."
		$sleep
	fi
	if [ "$opt" -ge 2 ] && [ "$opt" -le 14 ] || [ "$opt" -eq 20 ] || [ "$opt" -eq 21 ] || [ "$opt" -eq 30 ]; then
		echo ""
		echo $line
		echo ""
		$sleep
		echo " SuperCharging, OOM Grouping & Priority Fixes.."
		echo ""
		$sleep
		echo "    ...BulletProof, Die-Hard & HTK Launchers..."
		echo ""
		$sleep
		echo "     ...by -=zeppelinrox=- @ XDA & Droid Forums"
		sleep 2
	fi
	if [ "$opt" -eq 30 ]; then
		echo ""
		echo "                                     Buh Bye :)"
		echo ""
		echo $line
		echo ""
		$sleep
		exit 0
	fi
fi
if [ "$madesqlitefolder" -eq 1 ]; then
	rm -fr /sqlite_stmt_journals
fi
busybox mount -o remount,ro / 2>/dev/null
busybox mount -o remount,ro rootfs 2>/dev/null
busybox mount -o remount,ro /system 2>/dev/null
for m in /dev/block/mtdblock*
do
busybox mount -o remount,ro $m /system 2>/dev/null
done
done
