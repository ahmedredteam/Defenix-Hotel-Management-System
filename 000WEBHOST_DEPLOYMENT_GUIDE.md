# QloApps Deployment Guide: 000webhost (Free PHP Hosting)

## ⚡ Quick Overview
- **Platform:** 000webhost (free tier)
- **Time to Deploy:** ~10-15 minutes
- **Cost:** $0/month
- **Best For:** Testing, demo, small projects

---

## Step 1: Create 000webhost Account

1. Go to: https://www.000webhost.com
2. Click **"Sign Up Free"**
3. Fill in:
   - Email: `ahmed.redteam@gmail.com`
   - Password: Create strong password
   - Verify email
4. Complete registration

---

## Step 2: Create Website

After login:
1. Click **"Create Website"** or **"Add New Website"**
2. Choose **"Build from scratch"**
3. **Website Name:** `qloapps` (or your preferred name)
   - You'll get: `qloapps.000webhostapp.com`
4. Choose **Location:** Pick closest to your audience
5. Click **"Create"**

---

## Step 3: Access Your Site

You'll get:
- **Website URL:** `https://qloapps.000webhostapp.com`
- **FTP Host:** `ftp.000webhostapp.com`
- **FTP Username:** See in your 000webhost dashboard
- **FTP Password:** See in your 000webhost dashboard
- **Database:** MySQL (auto-created)

---

## Step 4: Download QloApps Files (Prepare for Upload)

On your PC:
1. The QloApps files are already in: `C:\Users\BlackCat\Downloads\HMS\QloApps`
2. Create a **ZIP file** of just the QloApps app files (NOT install folder)

**Remove these before uploading:**
- `/install` folder
- `Dockerfile`
- `docker-compose.yml`
- `.dockerignore`
- `render.yaml`
- `.git` folder
- `RENDER_DEPLOYMENT_GUIDE.md`

**Keep these:**
- Everything else (all app files)

---

## Step 5: Upload Files via FTP

### **Option A: Using FileZilla (Recommended)**

1. **Download FileZilla:** https://filezilla-project.org/
2. **Open FileZilla** → Go to **File → Site Manager**
3. **Create new site:**
   - Host: `ftp.000webhostapp.com`
   - Protocol: FTP
   - Username: (from 000webhost dashboard)
   - Password: (from 000webhost dashboard)
   - Click **"Connect"**

4. **Upload files:**
   - Right panel shows remote server
   - Navigate to `/public_html/` folder
   - Drag & drop QloApps files from left panel (your PC) to right panel
   - Wait for upload to complete

### **Option B: Using 000webhost File Manager**

1. Go to your 000webhost dashboard
2. Click **"File Manager"**
3. Navigate to `/public_html/`
4. Click **"Upload Files"** or **"Upload Folder"**
5. Select your QloApps folder
6. Wait for upload

---

## Step 6: Configure Database

### **In 000webhost Dashboard:**

1. Go to **"Databases"** section
2. You should see a MySQL database (auto-created)
3. Get these credentials:
   - **Host:** `localhost` (or provided hostname)
   - **Database Name:** Usually `<your-account>_<sitename>`
   - **Username:** Usually `<your-account>_user`
   - **Password:** Check dashboard or reset it

**Save these details** - you'll need them in Step 7

---

## Step 7: Run QloApps Installation

1. **Open your site:** `https://qloapps.000webhostapp.com/install/index.php`
2. **Follow Installation Assistant:**

### Step 1: Choose Language
- Select **English** (or your preference)
- Click **Next**

### Step 2: License Agreements
- Read and accept licenses
- Click **Next**

### Step 3: System Compatibility
- System checks will run
- Should show ✅ all green
- Click **Next**

### Step 4: Website Information
- **Website name:** Enter your hotel name
- **Website URL:** `https://qloapps.000webhostapp.com`
- Other details: Fill as needed
- Click **Next**

### Step 5: System Configuration ⚠️ (IMPORTANT)
Fill in database credentials:
- **Database server address:** `localhost`
- **Database name:** (from Step 6)
- **Database login:** (from Step 6)
- **Database password:** (from Step 6)
- **Tables prefix:** `qlo_`
- Click **"Test your database connection now"**

If error appears:
- Verify credentials are exactly correct
- Try `127.0.0.1` instead of `localhost`
- Go back to 000webhost dashboard and verify

### Step 6: QloApps Installation
- Installation will proceed
- Creates tables, sets up database
- Wait for completion
- You'll get login credentials

---

## Step 8: Delete Install Folder (SECURITY!)

**CRITICAL:** After installation completes:

### Via 000webhost File Manager:
1. Go to **File Manager**
2. Navigate to `/public_html/install`
3. Right-click → **Delete**
4. Confirm

### Via FTP (FileZilla):
1. Right-click `/install` folder
2. Click **Delete**

**This prevents security vulnerabilities!**

---

## Step 9: Access Your Application

### **Admin Panel:**
`https://qloapps.000webhostapp.com/admin/`

### **Customer Site:**
`https://qloapps.000webhostapp.com/`

Use credentials from installation to log in.

---

## Step 10: Connect Custom Subdomain (OPTIONAL)

If you have your own domain (e.g., `hotel.yourdomain.com`):

### **In your domain registrar (GoDaddy, Namecheap, etc.):**
1. Go to DNS settings
2. Create/Edit CNAME record:
   ```
   Host/Name: hotel (or subdomain name)
   Type: CNAME
   Value: qloapps.000webhostapp.com
   TTL: 3600
   ```
3. Save

### **In 000webhost:**
1. Dashboard → **Domains**
2. Click **"Add Domain"**
3. Enter: `hotel.yourdomain.com`
4. Wait for verification (5-30 minutes)

---

## Troubleshooting

### Database Connection Failed
**Problem:** "Database Server is not found"
- **Solution 1:** Try `127.0.0.1` instead of `localhost`
- **Solution 2:** Check credentials in 000webhost dashboard match exactly
- **Solution 3:** Contact 000webhost support - database may not be enabled

### File Upload Failed
**Problem:** Can't upload files via FTP
- **Solution 1:** Check FTP credentials again
- **Solution 2:** Make sure you're uploading to `/public_html/` folder
- **Solution 3:** Try 000webhost File Manager instead of FileZilla

### Site Loading Slowly
**Problem:** Pages take forever to load
- **Solution 1:** Free tier is limited (0.5-1 CPU)
- **Solution 2:** Upgrade to paid plan ($2-5/month)
- **Solution 3:** Wait 5-10 minutes for initial load

### Installation Stuck
**Problem:** Wizard not progressing
- **Solution 1:** Hard refresh browser (Ctrl+F5)
- **Solution 2:** Clear cookies and try again
- **Solution 3:** Try different browser

---

## After Installation: Next Steps

1. **Change Admin Password:**
   - Log in to admin panel
   - Go to Settings → Change password

2. **Add Your Hotel Info:**
   - Create rooms
   - Set pricing
   - Add amenities
   - Upload photos

3. **Configure Email:**
   - Set SMTP settings (usually provided by 000webhost)
   - Enable booking confirmations

4. **Set Up Payment:**
   - Integrate payment gateway (Stripe, PayPal)
   - Configure booking policies

5. **Backup Database:**
   - 000webhost provides backups
   - Download monthly backups

---

## Useful Links

- **000webhost Dashboard:** https://www.000webhost.com
- **QloApps Documentation:** https://docs.qloapps.com
- **FileZilla:** https://filezilla-project.org/
- **Support:** https://qloapps.com/contact/

---

## Tips & Best Practices

✅ **Do's:**
- Regularly backup your database
- Keep QloApps and plugins updated
- Use strong passwords
- Delete `/install` folder after setup
- Monitor disk space usage

❌ **Don'ts:**
- Leave `/install` folder on production
- Share admin credentials
- Upload unnecessary files
- Use weak passwords
- Ignore security updates

---

## Performance Notes

**Free tier limits:**
- CPU: ~0.5-1 vCPU
- RAM: ~128-256MB
- Bandwidth: ~50-100GB/month
- Best for: <100 daily visitors

**If you outgrow free tier:**
- Upgrade to paid (000webhost paid plans)
- Migrate to Render.com, Railway.app
- Migrate to dedicated VPS (DigitalOcean, Linode)

---

**Need help?** Let me know and I can guide you through each step! 🚀
