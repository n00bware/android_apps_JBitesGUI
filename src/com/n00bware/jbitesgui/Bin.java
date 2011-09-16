
package com.n00bware.jbitesgui;

import android.content.Context;
import android.content.res.AssetManager;
import android.content.res.Resources;
import android.os.Environment;
import android.util.Log;
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
    private static final String CP_SCRIPT = "cp /data/apps/com.n00bware.jbitesgui/assets/system/etc/99%s /system/etc/99%<s";
    private static final String CP_OC_SCRIPT = "cp /data/mods/99oc%s /system/etc/init.d/99oc";
    private static final String RM_SCRIPT = "rm -f /system/etc/init.d/99%s";
    private static final String CRON_BOOT = "echo \"root:x:0:0::data/cron:/system/xbin/bash\" > /system/etc/passwd";
    private static final String KILL_CRON_BOOT = "busybox sed -i \"/%s/D\" /system/etc/passwd";
    private static final String INSTALL_OC = "cp /data/apps/com.n00bware.jbitesgui/assets/system/lib/modules/overclock.ko /system/lib/modules/overclock.ko";
    private static final String INSTALL_GOV = "cp /data/apps/com.n00bware.jbitesgui/assets/system/lib/modules/cpufreq_interactive.ko /system/lib/modules/cpufreq_interactive.ko";
    private static final String KILL_MODULES = "rm -f /system/lib/modules/%s";
    private static final String MODS_PATH = "/sdcard/mods/99%s";
    private static final String MODULE_PATH = "/sdcard/mods/%s";
    private static final String DL_PATH = "https://raw.github.com/n00bware/android_apps_JBitesGUI/master/assets/%s";
    private static final String WGET = "busybox wget -q -O /sdcard/mods/%s https://raw.github.com/n00bware/android_apps_JBitesGUI/master/assets/%<s";

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
                    return Bin.runRootCommand(String.format(CP_SCRIPT, script));
                } else if (script.equals("init")) {
                    return Bin.runRootCommand(String.format(CP_SCRIPT, script));
                } else if (script.equals("zip")) {
                    return Bin.runRootCommand(String.format(CP_SCRIPT, script));
                } else if (script.equals("logger")) {
                    return Bin.runRootCommand(String.format(CP_SCRIPT, script));
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
                if (key.equals("1000")) {
                    Bin.keepModule("true");
                    Bin.runRootCommand(String.format(CP_SCRIPT, "gov"));
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1100")) {
                    Bin.keepModule("true");
                    Bin.runRootCommand(String.format(CP_SCRIPT, "gov"));
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1200")) {
                    Bin.keepModule("true");
                    Bin.runRootCommand(String.format(CP_SCRIPT, "gov"));
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1250")) {
                    Bin.keepModule("true");
                    Bin.runRootCommand(String.format(CP_SCRIPT, "gov"));
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("1300")) {
                    Bin.keepModule("true");
                    Bin.runRootCommand(String.format(CP_SCRIPT, "gov"));
                    return Bin.runRootCommand(String.format(CP_OC_SCRIPT, key));
                } else if (key.equals("disableOC")) {
                    Bin.keepModule("false");
                    Bin.runRootCommand(String.format(RM_SCRIPT, "gov"));
                    return Bin.runRootCommand(String.format(RM_SCRIPT, "oc"));
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
        Log.d(TAG, String.format("Keep overclocking modules=%s", keep));
        File oc = new File("/system/lib/modules/overclock.ko");
        File gov = new File("/system/lib/modules/cpufreq_interactive.ko");
        boolean oc_exist = oc.exists();
        boolean gov_exist = gov.exists();

        if (keep.equals("true")) {
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
        } else if (keep.equals("false")) {
            try {
                Bin.runRootCommand(String.format(KILL_MODULES, "overclock.ko"));
                Bin.runRootCommand(String.format(KILL_MODULES, "cpufreq_interactive.ko"));
            } finally {
                Log.d(TAG, "removed overclock.ko && cpufreq_interactive.ko");
            }
        }
    }

    public static boolean allMods(String mod_all) {
        if (mod_all.equals("true")) {
            Log.d(TAG, "Installing all scripts");
            Bin.runRootCommand(String.format(CP_SCRIPT, "sysctl"));
            Bin.runRootCommand(String.format(CP_SCRIPT, "cron"));
            Bin.runRootCommand(String.format(CP_SCRIPT, "init"));
            Bin.runRootCommand(String.format(CP_SCRIPT, "oc"));
            Bin.runRootCommand(String.format(CP_SCRIPT, "zip"));
            Bin.runRootCommand(String.format(CP_SCRIPT, "logger"));
            Bin.runRootCommand(String.format(CP_SCRIPT, "gov"));
            Bin.keepModule("true");
            return true;
        } else if (mod_all.equals("false")) {
            Log.d(TAG, "Removing all scripts");
            Bin.runRootCommand(String.format(RM_SCRIPT, "sysctl"));
            Bin.runRootCommand(String.format(RM_SCRIPT, "cron"));
            Bin.runRootCommand(String.format(RM_SCRIPT, "init"));
            Bin.runRootCommand(String.format(RM_SCRIPT, "oc"));
            Bin.runRootCommand(String.format(RM_SCRIPT, "zip"));
            Bin.runRootCommand(String.format(RM_SCRIPT, "logger"));
            Bin.runRootCommand(String.format(RM_SCRIPT, "gov"));
            Bin.keepModule("false");
            return true;
        }
    return false;
    }

    public static boolean findScripts() {
        //We need to find some files if they exist we don't need to download them
        File oc_module = new File(String.format(MODULE_PATH, "overclock.ko"));
        File gov_module = new File(String.format(MODULE_PATH, "cpufreq_interactive.ko"));
        File sysctl = new File(String.format(MODS_PATH, "sysctl"));
        File cron = new File(String.format(MODS_PATH, "cron"));
        File init = new File(String.format(MODS_PATH, "init"));
        File oc = new File(String.format(MODS_PATH, "oc"));
        File oc1100 = new File(String.format(MODS_PATH, "oc1100"));
        File oc1200 = new File(String.format(MODS_PATH, "oc1200"));
        File oc1250 = new File(String.format(MODS_PATH, "oc1250"));
        File oc1300 = new File(String.format(MODS_PATH, "oc1300"));
        File zip = new File(String.format(MODS_PATH, "zip"));
        File logger = new File(String.format(MODS_PATH, "logger"));
        boolean oc_module_exist = oc_module.exists();
        boolean gov_module_exist = gov_module.exists();
        boolean sysctl_exist = sysctl.exists();
        boolean cron_exist = cron.exists();
        boolean init_exist = init.exists();
        boolean oc_exist = oc.exists();
        boolean oc1100_exist = oc1100.exists();
        boolean oc1200_exist = oc1200.exists();
        boolean oc1250_exist = oc1250.exists();
        boolean oc1300_exist = oc1300.exists();
        boolean zip_exist = zip.exists();
        boolean logger_exist = logger.exists();
        
        //booleans will tell us if those files exist now lets handle them not existing: !exist
        if (!oc_module_exist) {
            return Bin.dlScript("overclock.ko");
        } else if (!gov_module_exist) {
            return Bin.dlScript("cpu_freq_interactive.ko");
        } else if (!sysctl_exist) {
            return Bin.dlScript("99sysctl");
        } else if (!cron_exist) {
            return Bin.dlScript("99cron");
        } else if (!init_exist) {
            return Bin.dlScript("99init");
        } else if (!oc_exist) {
            return Bin.dlScript("99oc");
        } else if (!oc1100_exist) {
            return Bin.dlScript("99oc1100");
        } else if (!oc1200_exist) {
            return Bin.dlScript("99oc1200");
        } else if (!oc1300_exist) {
            return Bin.dlScript("99oc1300");
        } else if (!zip_exist) {
            return Bin.dlScript("99zip");
        } else if (!logger_exist) {
            return Bin.dlScript("99logger");
        }
        return true;
    }

    public static boolean dlScript(String key) {
        //we can use this to ensure the users have the latest scripts
        Log.d(TAG, String.format("wget being called to get %s", key));
        return Bin.runRootCommand(String.format(WGET, key));
    }
}
