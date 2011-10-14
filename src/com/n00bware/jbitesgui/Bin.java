
package com.n00bware.jbitesgui;

import android.content.Context;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.os.Environment;
import android.util.Log;
import android.view.View;
import android.widget.Toast;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.io.IOException;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.OutputStream;
import java.lang.Object;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

public final class Bin {

    private static final String TAG = "JBitesGUI";
    private static final String REMOUNT_CMD = "busybox mount -o %s,remount -t yaffs2 /dev/block/mtdblock1 /system";
    private static final String PROP_EXISTS_CMD = "grep -q %s /system/build.prop";
    private static final String SHOWBUILD_PATH = "/system/tmp/showbuild";
    private static final String ENABLE = "enable";
    private static final String DISABLE = "disable";
    private static final String MODS = "busybox sed -i \"/%s/ c %<s=% /system/etc/init.d/99mods";
    private static final String CP_OC_SCRIPT = "cp /data/mods/99oc%s /system/etc/init.d/99oc";
    private static final String SYSCTL_CMD = "busybox sed -i \"/doSysctl/ c doSystl=%s /system/etc/init.d/99mods";
    private static final String LOGGER_CMD = "busybox sed -i \"/doLogger/ c doLogger=%s /system/etc/init.d/99mods";
    private static final String CRON_CMD = "busybox sed -i \"/doCron/ c doCron=%s /system/etc/init.d/99mods";
    private static final String ZIP_CMD = "busybox sed -i \"/doZip/ c doZip=%s /system/etc/init.d/99mods";
    private static final String RM_SCRIPT = "rm -f /system/etc/init.d/99%s";
    private static final String CRON_BOOT = "echo \"root:x:0:0::data/cron:/system/xbin/bash\" > /system/etc/passwd";
    private static final String KILL_CRON_BOOT = "busybox sed -i \"/%s/D\" /system/etc/passwd";
    private static final String INSTALL_OC = "cp /data/apps/com.n00bware.jbitesgui/assets/system/lib/modules/overclock.ko /system/lib/modules/overclock.ko";
    private static final String INSTALL_GOV = "cp /data/apps/com.n00bware.jbitesgui/assets/system/lib/modules/cpufreq_interactive.ko /system/lib/modules/cpufreq_interactive.ko";
    private static final String KILL_MODULES = "rm -f /system/lib/modules/%s";
    private static final String MODS_PATH = "/sdcard/mods/99%s";
    private static final String MODULE_PATH = "/sdcard/mods/%s";
    private static final String DL_PATH = "https://raw.github.com/n00bware/android_apps_JBitesGUI/master/assets/%s";

    private Bin() {
        // private constructor so nobody can instantiate this class
    }

    public static boolean runRootCommand(String command) {
        Log.d(TAG, "Attempting to runRootCommand: " + command);
        Process process = null;
        DataOutputStream os = null;
        try {
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

    public static boolean modScripts(String mod, String key) {
        Log.d(TAG, String.format("modScripts called: {%s} {%s}", mod, key));
        try {
            Bin.mount("rw");
            Bin.runRootCommand(Constants.DONT_REBOOT);
            Log.d(TAG, String.format("installing %s script", mod));
            if (mod.equals("sysctl")) {
                Bin.runRootCommand(String.format(SYSCTL_CMD, key));
                return Bin.runRootCommand("99mods");
            } else if (mod.equals("cron")) {
                Bin.runRootCommand(String.format(CRON_CMD, key));
                return Bin.runRootCommand("99mods");
            } else if (mod.equals("zip")) {
                Bin.runRootCommand(String.format(ZIP_CMD, key));
                return Bin.runRootCommand("99mods");
            } else if (mod.equals("logger")) {
                Bin.runRootCommand(String.format(LOGGER_CMD, key));
                return Bin.runRootCommand("99mods");
            } else if (mod.equals("oc")) {
                Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                return Bin.runRootCommand("99oc");
            }
            return false;
        } finally {
            Bin.runRootCommand(Constants.REVERT_DONT_REBOOT);
            Bin.mount("ro");
        }
    }

    public static void updateShowBuild() {
        Log.d(TAG, "Setting up /system/tmp/showbuild");
        Bin.runRootCommand("cp /system/build.prop " + SHOWBUILD_PATH);
        Bin.runRootCommand("chmod 777 " + SHOWBUILD_PATH);
    }
}
