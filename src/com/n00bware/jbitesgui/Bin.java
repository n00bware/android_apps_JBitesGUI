
package com.n00bware.jbitesgui;

import android.util.Log;

import java.io.BufferedOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.File;
import java.io.FileWriter;

public final class Bin {

    private static final String TAG = "JBitesGUI";
    private static final String REMOUNT_CMD = "busybox mount -o %s,remount -t yaffs2 /dev/block/mtdblock1 /system";
    private static final String PROP_EXISTS_CMD = "grep -q %s /system/build.prop";
    private static final String SHOWBUILD_PATH = "/system/tmp/showbuild";
    private static final String ENABLE = "enable";
    private static final String DISABLE = "disable";
    private static final String CP_SCRIPT = "cp /data/apps/com.n00bware.jbitesgui/assets/system/etc/%s /system/etc/%<s";
    private static final String CP_OC_SCRIPT = "cp /data/apps/com.n00bware.jbitesgui/assets/data/oc/%s/99oc /system/etc/init.d/99oc";
    private static final String RM_SCRIPT = "rm -f /system/etc/init.d/99%s";
    private static final String CRON_BOOT = "echo \"root:x:0:0::data/cron:/system/xbin/bash\" > /system/etc/passwd";
    private static final String KILL_CRON_BOOT = "busybox sed -i \"/%s/D\" /system/etc/passwd";
    private static final String INSTALL_OC = "cp /data/apps/com.n00bware.jbitesgui/assets/system/lib/modules/overclock.ko /system/lib/modules/overclock.ko";
    private static final String INSTALL_GOV = "cp /data/apps/com.n00bware.jbitesgui/assets/system/lib/modules/cpufreq_interactive.ko /system/lib/modules/cpufreq_interactive.ko";
    private static final String KILL_MODULES = "rm -f /system/lib/modules/%s";

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
            Log.d(TAG, String.format("Success { %s }", command));
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
        Log.d(TAG, String.format("modScripts called: {%s} {%s}", script, key));
        try {
            Bin.mount("rw");
            if (key.equals(ENABLE)) {
                Log.d(TAG, String.format("installing %s script", script));
                if (script.equals("sysctl")) {
                    return Bin.runRootCommand(String.format(CP_SCRIPT, script));
                } else if (script.equals("cron")) {
                    Bin.runRootCommand(CRON_BOOT);
                    return Bin.runRootCommand(String.format(CP_SCRIPT, key));
                } else if (script.equals("init")) {
                    return Bin.runRootCommand(String.format(CP_SCRIPT, key));
                }
            } else if (key.equals(DISABLE)) {
                Log.d(TAG, String.format("removing %s script", script));
                if (script.equals("sysctl")) {
                    return Bin.runRootCommand(String.format(RM_SCRIPT, script));
                } else if (script.equals("cron")) {
                    Bin.runRootCommand(String.format(KILL_CRON_BOOT, script));
                    return Bin.runRootCommand(String.format(RM_SCRIPT, script));
                } else if (script.equals("init")) {
                    return Bin.runRootCommand(String.format(RM_SCRIPT, script));
                }
            } else if (script.equals("oc")) {
                if (key.equals("1000mhz")) {
                    Bin.keepModule("true");
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1100mhz")) {
                    Bin.keepModule("true");
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1200mhz")) {
                    Bin.keepModule("true");
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1250mhz")) {
                    Bin.keepModule("true");
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1300mhz")) {
                    Bin.keepModule("true");
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("disableOC")) {
                    Bin.keepModule("false");
                    return Bin.runRootCommand(String.format(RM_SCRIPT, "99oc"));
                }
            }
            return false;
        } finally {
            Bin.mount("ro");
        }
    }

    public static void updateShowBuild() {
        Log.d(TAG, "Setting up /system/tmp/showbuild");
        Bin.runRootCommand("cp /system/build.prop " + SHOWBUILD_PATH);
        Bin.runRootCommand("chmod 777 " + SHOWBUILD_PATH);
    }

    public static void keepModule(String keep) {
        Log.d(TAG, String.format("Keep overclocking modules=%s"));
        File oc = new File("/system/lib/modules/overclock.ko");
        File gov = new File("/system/lib/modules/cpufreq_interactive.ko");
        boolean oc_exist = oc.exists();
        boolean gov_exist = gov.exists();

        if (keep.equals(true)) {
            if (!oc_exist) {
                try {
                    Bin.runRootCommand(INSTALL_OC);
                } finally {
                    Log.d(TAG, "installed overclocking module");
                }
            }
            if (!gov_exist) {
                try {
                    Bin.runRootCommand(INSTALL_GOV);
                } finally {
                    Log.e(TAG, "installed overclocking module");
                }
            }
        } else if (keep.equals(false)) {
            try {
                Bin.runRootCommand(String.format(KILL_MODULES, "overclock.ko"));
                Bin.runRootCommand(String.format(KILL_MODULES, "cpufreq_interactive.ko"));
            } finally {
                Log.d(TAG, "removed overclock.ko && cpufreq_interactive.ko");
            }
        }
    }

//TODO add installation of scripts
    public static boolean installScripts() {
        Log.d(TAG, "Installing scripts");
        //Bin.runRootCommand(String.format("cp %s/ %s", cpFrom, cpTo));
        return false;
    } 
}
