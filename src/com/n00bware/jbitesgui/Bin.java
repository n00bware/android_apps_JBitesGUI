
package com.n00bware.jbitesgui;

import android.util.Log;

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.FileWriter;

public final class Bin {

    private static final String TAG = "JBitesGUI";
    private static final String REMOUNT_CMD = "busybox mount -o %s,remount -t yaffs2 /dev/block/mtdblock1 /system";
    private static final String PROP_EXISTS_CMD = "grep -q %s /system/build.prop";
    private static final String SHOWBUILD_PATH = "/system/tmp/showbuild";
    private static final String ENABLE = "enable";
    private static final String DISABLE = "disable";
    private static final String CP_SCRIPTS = "cp /data/apps/com.n00bware/jbitesgui/assets/system/etc/init.d/%s /system/etc/init.d/%<s";
    private static final String RM_SCRIPTS = "rm -f /system/etc/init.d/%s";

    private Bin() {
        // private constructor so nobody can instantiate this class
    }

    public static boolean runRootCommand(String command) {
        Log.d(TAG, "runRootCommand started");
        Log.d(TAG, "Attempting to run: " + command);
        Process process = null;
        DataOutputStream os = null;
        try {
            Log.d(TAG, "attempt to get root");
            process = Runtime.getRuntime().exec("su");
            os = new DataOutputStream(new BufferedOutputStream(process.getOutputStream()));
            os.writeBytes(command + "\n");
            os.writeBytes("exit\n");
            os.flush();
            return process.waitFor() == 0;
        } catch (IOException e) {
            Log.e(TAG, "IOException while flushing stream:", e);
            return false;
        } catch (InterruptedException e) {
            Log.e(TAG, "InterruptedException while executing process:", e);
            return false;
        } finally {
            if (os != null) {
                try {
                    os.close();
                } catch (IOException e) {
                    Log.e(TAG, "IOException while closing stream:", e);
                }
            }
            if (process != null) {
                process.destroy();
            }
        }
    }

    public static boolean backupBuildProp() {
        Log.d(TAG, "Backing up build.prop to /system/tmp/pm_build.prop");
        return Bin.runRootCommand("cp /system/build.prop /system/tmp/pm_build.prop");
    }
    
    public static boolean restoreBuildProp() {
        Log.d(TAG, "Restoring build.prop from /system/tmp/pm_build.prop");
        return Bin.runRootCommand("cp /system/tmp/pm_build.prop /system/build.prop");
    }

    public static boolean mount(String key) {
        Log.d(TAG, String.format("We want to mount the /system as %s", key));
        if (key.equals("rw")) {
            return Bin.runRootCommand(String.format(REMOUNT_CMD, "rw"));
        } else if (key.equals("ro")) {
            return Bin.runRootCommand(String.format(REMOUNT_CMD, "ro"));
        }
        return false;
    }

    public static boolean modScripts(String script, String key) {
        Log.d(TAG, String.format("modCron called: {%s} {%s}", script, key));
        if (key.equals(ENABLE)) {
            Log.d(TAG, String.format("installing %s script"));
            Bin.runRootCommand(String.format(CP_SCRIPTS, script));
        } else if (key.equals(DISABLE)) {
            Log.d(TAG, String.format("removing %s script", script));
            Bin.runRootCommand(String.format(RM_SCRIPTS, script));
        }
        return false;
    }

    public static void updateShowBuild() {
        Log.d(TAG, "Setting up /system/tmp/showbuild");
        Bin.runRootCommand("cp /system/build.prop " + SHOWBUILD_PATH);
        Bin.runRootCommand("chmod 777 " + SHOWBUILD_PATH);
    }

//TODO add installation of scripts
    public static boolean installScripts() {
        Log.d(TAG, "Installing scripts");
        //Bin.runRootCommand(String.format("cp %s/ %s", cpFrom, cpTo));
        return false;
    } 

    public static boolean modOC(String ocValues) {
        if (ocValues.equals("1ghz")) {
            //do stuff
        } else if (ocValues.equals("11ghz")) {
            //do stuff
        } else if (ocValues.equals("12ghz")) {
            //do stuff
        } else if (ocValues.equals("125ghz")) {
            //do stuff
        } else if (ocValues.equals("13ghz")) {
            //do stuff
        } else if (ocValues.equals("disableOC")) {
            //do stuff
        }
        return false;
    }

}
