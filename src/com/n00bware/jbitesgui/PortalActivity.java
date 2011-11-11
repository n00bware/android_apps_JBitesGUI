package com.n00bware.jbitesgui;

import com.n00bware.jbitesgui.R;

import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Enumeration;
import java.util.Vector;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.AlertDialog.Builder;
import android.content.Intent;
import android.content.DialogInterface;
import android.net.Uri;
import android.os.Bundle;
import android.util.Log;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;

public class PortalActivity extends Activity {

    private static final String TAG = "jbitesgui";

    private final int MENU_DONATE_jbirdvegas = 1;
    private final int MENU_DONATE_jakebites = 2;
    private final int PREF = 3;
    private final int MENU_CODE = 4;
    private final int N00BWARE = 5;

    private static final String GITHUB = "https://github.com/n00bware/android_apps_JBitesGUI";
    private static final String DONATE_jbirdvegas = "http://bit.ly/oCWMo0";
    private static final String DONATE_jakebites = "http://bit.ly/oFbswu";
    private static final String MARKET_n00bware = "market://search?q=n00bware";


    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.install);

        Button install = (Button)findViewById(R.id.install);
        install.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {

                unzipAssets();

                String filesDir = getFilesDir().getAbsolutePath();
                String data = filesDir + "/data";
                String system = filesDir + "/system";

                StringBuilder toBash = new StringBuilder();
                toBash.append("cp -rf " + data + " / ; ");
                toBash.append("cp -rf " + system + " / ; ");

                AlertDialog.Builder builder = new Builder(PortalActivity.this);
                builder.setPositiveButton(android.R.string.ok, null);
                builder.setTitle("JBitesGUI");

                try {
                    Bin.mount("rw");
                    Bin.runRootCommand(toBash.toString());
                    Bin.runRootCommand(Constants.SYMLINK_QUERTY);
                    Bin.runRootCommand(Constants.SYMLINK_TOOLBOX);
                    builder.setMessage(R.string.success_notify);
                    Bin.mount("ro");
                }

                catch (Exception e) {
                    builder.setTitle("Failure");
                    builder.setMessage(e.getMessage());
                    e.printStackTrace();
                }
                builder.create().show();
            }
        });

        Button reboot = (Button)findViewById(R.id.reboot);
        reboot.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
                Bin.runRootCommand("reboot");
            }
        });

        Button mods = (Button)findViewById(R.id.mods);
        mods.setOnClickListener(new OnClickListener() {
            @Override
            public void onClick(View v) {
            Intent intent = new Intent(PortalActivity.this,ModsActivity.class);
            startActivity(intent);
            }
        });

    }

    final static String ZIP_FILTER = "assets";
    
    void unzipAssets() {
        String apkPath = getPackageCodePath();
        String mAppRoot = getFilesDir().toString();
        Log.d(TAG, String.format("apkPath { %s } && mAppRoot { %s }", apkPath, mAppRoot));
        try {
            File zipFile = new File(apkPath);
            long zipLastModified = zipFile.lastModified();
            ZipFile zip = new ZipFile(apkPath);
            Vector<ZipEntry> files = getAssets(zip);
            int zipFilterLength = ZIP_FILTER.length();
            
            Enumeration<?> entries = files.elements();
            while (entries.hasMoreElements()) {
                ZipEntry entry = (ZipEntry) entries.nextElement();
                String path = entry.getName().substring(zipFilterLength);
                File outputFile = new File(mAppRoot, path);
                outputFile.getParentFile().mkdirs();

                if (outputFile.exists() && entry.getSize() == outputFile.length() && zipLastModified < outputFile.lastModified())
                    continue;
                FileOutputStream fos = new FileOutputStream(outputFile);
                copyStreams(zip.getInputStream(entry), fos);
                Runtime.getRuntime().exec("chmod 755 " + outputFile.getAbsolutePath());
            }
        } catch (IOException ioe) {
            Log.e(TAG, "Error: " + ioe.getMessage());
        } catch (NullPointerException ne) {
            Log.e(TAG, "NullPointerException: " + ne.getMessage());
        }
    }

    static final int BUFSIZE = 5192;

    void copyStreams(InputStream is, FileOutputStream fos) {
        BufferedOutputStream os = null;
        try {
            byte data[] = new byte[BUFSIZE];
            int count;
            os = new BufferedOutputStream(fos, BUFSIZE);
            while ((count = is.read(data, 0, BUFSIZE)) != -1) {
                os.write(data, 0, count);
            }
            os.flush();
        } catch (IOException e) {
            Log.e(TAG, "Exception while copying: " + e);
        } finally {
            try {
                if (os != null) {
                    os.close();
                }
            } catch (IOException e2) {
                Log.e(TAG, "Exception while closing the stream: " + e2);
            }
        }
    }

    public Vector<ZipEntry> getAssets(ZipFile zip) {
        Vector<ZipEntry> list = new Vector<ZipEntry>();
        Enumeration<?> entries = zip.entries();
        while (entries.hasMoreElements()) {
            ZipEntry entry = (ZipEntry) entries.nextElement();
            if (entry.getName().startsWith(ZIP_FILTER)) {
                list.add(entry);
            }
        }
        return list;
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
        menu.add(0, PREF, 0, "Mods").setIcon(R.drawable.mods);
        menu.add(0, N00BWARE, 0, "n00bware on the Market").setIcon(R.drawable.market);
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
        case PREF:
            Intent intent = new Intent(PortalActivity.this,ModsActivity.class);
            startActivity(intent);
            return true;
        case N00BWARE:
            return website(MARKET_n00bware);
        }
        return false;
    }
}
