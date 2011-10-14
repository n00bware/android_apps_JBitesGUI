
package com.n00bware.jbitesgui;
import com.n00bware.jbitesgui.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.os.Bundle;
import android.os.SystemProperties;
import android.preference.CheckBoxPreference;
import android.preference.EditTextPreference;
import android.preference.ListPreference;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.PreferenceScreen;
import android.preference.Preference.OnPreferenceClickListener;
import android.util.Log;
import android.view.KeyEvent;
import android.view.View;
import android.text.InputFilter;
import android.text.InputFilter.LengthFilter;
import android.widget.Button;
import android.widget.EditText;
import android.widget.LinearLayout;
import android.widget.Toast;

import java.io.File;

public class ModsActivity extends PreferenceActivity implements
        Preference.OnPreferenceChangeListener {

    private static final String APPEND_CMD = "echo \"%s=%s\" >> /system/build.prop";
    private static final String KILL_PROP_CMD = "busybox sed -i \"/%s/D\" /system/build.prop";
    private static final String REPLACE_CMD = "busybox sed -i \"/%s/ c %<s=%s\" /system/build.prop";
    private static final String SHOWBUILD_PATH = "/system/tmp/showbuild";
    private static final String DISABLE = "disable";
    private static final String MOUNT_PREF = "mount_pref";
    private static final String SYSCTL_PREF = "sysctl_pref";
    private static final String CRON_PREF = "cron_pref";
    private static final String OC_PREF = "oc_pref";
    private static final String ZIP_PREF = "zip_pref";
    private static final String LOG_PREF = "log_pref";

    //TAG is used for debugging in logcat
    private static final String TAG = "JBitesGUI";

    //so we don't install on other devices
    private static final String DEVICE = SystemProperties.get("ro.product.model");

    private ListPreference mMountPref;
    private CheckBoxPreference mSysctlPref;
    private CheckBoxPreference mCronPref;
    private ListPreference mOCPref;
    private CheckBoxPreference mZipPref;
    private CheckBoxPreference mLogPref;
    private AlertDialog mAlertDialog;
    private Context mMainContext;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setTitle(R.string.main_title_head);
        addPreferencesFromResource(R.xml.main);

        Log.d(TAG, String.format("Your device is %s", DEVICE));
        if ((!DEVICE.equals("DROID2")) && (!DEVICE.equals("SHADOW"))) {
            finish();
        }

        Log.d(TAG, "Loading prefs");
        PreferenceScreen prefSet = getPreferenceScreen();

        // Declare open
        mAlertDialog = new AlertDialog.Builder(this).create();
        mAlertDialog.setTitle(R.string.explain_wait_title);
        mAlertDialog.setMessage(getResources().getString(R.string.explain_wait_summary));
        mAlertDialog.setButton(DialogInterface.BUTTON_POSITIVE,
                getResources().getString(com.android.internal.R.string.ok),
                new DialogInterface.OnClickListener() {
                    public void onClick(DialogInterface dialog, int which) {
                        return;
                    }
                });
        mAlertDialog.show();

        File modsDir = new File("/sdcard/mods");
        boolean md = modsDir.exists();
        if (!md) {
            Log.d(TAG, "We need to make /sdcard/mods dir");
            Bin.runRootCommand("mkdir /sdcard/mods");
        }

        mMountPref = (ListPreference) prefSet.findPreference(MOUNT_PREF);
        mMountPref.setOnPreferenceChangeListener(this);

        mSysctlPref = (CheckBoxPreference) prefSet.findPreference(SYSCTL_PREF);
        //look for the file if it exists the box is checked
        File sysfile = new File("/system/etc/init.d/99sysctl");
        boolean sys_exists = sysfile.exists();
        mSysctlPref.setChecked(sys_exists);

        mCronPref = (CheckBoxPreference) prefSet.findPreference(CRON_PREF);
        File cronfile = new File("/system/etc/init.d/99cron");
        boolean cron_exists = cronfile.exists();
        mCronPref.setChecked(cron_exists);

        mOCPref = (ListPreference) prefSet.findPreference(OC_PREF);
        mOCPref.setOnPreferenceChangeListener(this);

        mZipPref = (CheckBoxPreference) prefSet.findPreference(ZIP_PREF);
        File zipfile = new File("/system/etc/init.d/99zip");
        boolean zip_exists = zipfile.exists();
        mZipPref.setChecked(zip_exists);

        mLogPref = (CheckBoxPreference) prefSet.findPreference(LOG_PREF);
        File logfile = new File("/system/etc/init.d/99log");
        boolean log_exists = logfile.exists();
        mLogPref.setChecked(log_exists);

        /*
         * Mount /system RW and determine if /system/tmp exists; if it doesn't
         * we make it
         */
        File tmpDir = new File("/system/tmp");
        boolean exists = tmpDir.exists();
        if (!exists) {
            try {
                Log.d(TAG, "We need to make /system/tmp dir");
                Bin.mount("rw");
                Bin.runRootCommand("mkdir /system/tmp");
            } finally {
                Bin.mount("ro");
            }
        }
    }


    public boolean onPreferenceChange(Preference pref, Object newValue) {
        if (newValue != null) {
            try {
                Log.d(TAG, "New preference selected: " + newValue);
                Bin.mount("rw");
                if (pref == mMountPref) {
                    return Bin.mount(newValue.toString());
                } else if (pref == mOCPref) {
                    return Bin.modScripts("oc", newValue.toString());
                }
            } finally {
                Bin.mount("ro");
            }
        }
        return false;
    }

    @Override
    public boolean onPreferenceTreeClick(PreferenceScreen ps, Preference pref) {
        boolean value;
        Log.d(TAG, "you chose " + pref);
        try {
            if (pref == mCronPref) {
                value = mCronPref.isChecked();
                return Bin.modScripts("cron", String.valueOf(value ? "1" : "0"));
            } else if (pref == mZipPref) {
                value = mZipPref.isChecked();
                return Bin.modScripts("zip", String.valueOf(value ? "1" : "0"));
            }
        } finally {}
    return false;
    }
}
