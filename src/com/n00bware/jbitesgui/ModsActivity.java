
package com.n00bware.jbitesgui;
import com.n00bware.jbitesgui.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
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
import android.view.Menu;
import android.view.MenuItem;
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

    private static final String DEBOUNCE_CMD = "cp -f /data/debounce/%s/debounce.ko /system/lib/modules/debounce.ko";
    private static final String FIND_CMD = "grep -q \"%s\" /system/etc/init.d/99mods";
    private static final String DISABLE = "disable";
    private static final String MOUNT_PREF = "mount_pref";
    private static final String SYSCTL_PREF = "sysctl_pref";
    private static final String CRON_PREF = "cron_pref";
    private static final String OC_PREF = "oc_pref";
    private static final String ZIP_PREF = "zip_pref";
    private static final String LOG_PREF = "log_pref";
    private static final String DEBOUNCE_PREF = "debounce_pref";
    private static final String ON_OFF_DEBOUNCE = "onOff_debounce";

    private static final String GITHUB = "https://github.com/n00bware/android_apps_JBitesGUI";
    private static final String DONATE_jbirdvegas = "http://bit.ly/oCWMo0";
    private static final String DONATE_jakebites = "http://bit.ly/oFbswu";

    private final int MENU_DONATE_jbirdvegas = 1;
    private final int MENU_DONATE_jakebites = 2;
    private final int REBOOT = 3;
    private final int MENU_CODE = 4;

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
    private CheckBoxPreference mOnOffDebouncePref;
    private ListPreference mDebouncePref;
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
        boolean sys_exists = Bin.runRootCommand(String.format(FIND_CMD, "doSysctl=1"));
        mSysctlPref.setChecked(sys_exists);

        mCronPref = (CheckBoxPreference) prefSet.findPreference(CRON_PREF);
        boolean cron_exists = Bin.runRootCommand(String.format(FIND_CMD, "doCron=1"));
        mCronPref.setChecked(cron_exists);

        mOCPref = (ListPreference) prefSet.findPreference(OC_PREF);
        mOCPref.setOnPreferenceChangeListener(this);

        mZipPref = (CheckBoxPreference) prefSet.findPreference(ZIP_PREF);
        boolean zip_exists = Bin.runRootCommand(String.format(FIND_CMD, "doZip=1"));
        mZipPref.setChecked(zip_exists);

        mLogPref = (CheckBoxPreference) prefSet.findPreference(LOG_PREF);
        boolean log_exists = Bin.runRootCommand(String.format(FIND_CMD, "doLogger=1"));
        mLogPref.setChecked(log_exists);

        mDebouncePref = (ListPreference) prefSet.findPreference(DEBOUNCE_PREF);
        mDebouncePref.setOnPreferenceChangeListener(this);

        mOnOffDebouncePref = (CheckBoxPreference) prefSet.findPreference(ON_OFF_DEBOUNCE);
        boolean debounce_exists = Bin.runRootCommand(String.format(FIND_CMD, "doDebounce=1"));
        mOnOffDebouncePref.setChecked(debounce_exists);
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
                } else if (pref == mDebouncePref) {
                    return Bin.runRootCommand(String.format(DEBOUNCE_CMD, newValue.toString()));
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
        if (pref == mCronPref) {
            value = mCronPref.isChecked();
            return Bin.modScripts("cron", String.valueOf(value ? "1" : "0"));
        } else if (pref == mZipPref) {
            value = mZipPref.isChecked();
            return Bin.modScripts("zip", String.valueOf(value ? "1" : "0"));
        } else if (pref == mSysctlPref) {
            value = mSysctlPref.isChecked();
            return Bin.modScripts("sysctl", String.valueOf(value ? "1" : "0"));
        } else if (pref == mLogPref) {
            value = mLogPref.isChecked();
            return Bin.modScripts("logger", String.valueOf(value ? "1" : "0"));
        } else if (pref == mOnOffDebouncePref) {
            value = mOnOffDebouncePref.isChecked();
            return Bin.modScripts("debounce", String.valueOf(value ? "1" : "0"));
        }
    return false;
    }

    private boolean website(String web) {
        Intent browserIntent = new Intent(Intent.ACTION_VIEW, Uri.parse(web));
        startActivity(browserIntent);
        return true;
    }

    public boolean onCreateOptionsMenu(Menu menu){
        boolean result = super.onCreateOptionsMenu(menu);
        menu.add(0, MENU_DONATE_jbirdvegas, 0, "Donate to JBirdVegas").setIcon(R.drawable.jbird_small);
        menu.add(0, MENU_DONATE_jakebites, 0, "Donate to Jakebites").setIcon(R.drawable.paypal);
        menu.add(0, MENU_CODE, 0, "Show me the code").setIcon(R.drawable.github);
        menu.add(0, REBOOT, 0, "Reboot").setIcon(R.drawable.reboot);
        return result;
    }
 
    /* Handle the menu selection */
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
        case MENU_DONATE_jbirdvegas:
            return website(DONATE_jbirdvegas);
        case MENU_DONATE_jakebites:
            return website(DONATE_jakebites);
        case MENU_CODE:
            return website(GITHUB);
        case REBOOT:
            return Bin.runRootCommand("reboot");
        }
        return false;
    }
}
