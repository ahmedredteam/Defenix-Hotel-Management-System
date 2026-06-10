# QloApps Deployment Guide for Render.com

## Prerequisites
✅ GitHub account (free)
✅ Render.com account (free)
✅ This QloApps repository

---

## Step 1: Push Code to GitHub

### 1a. Create a GitHub Repository
1. Go to https://github.com/new
2. Create a new repository: `qloapps-deployment`
3. Copy the repository URL (HTTPS or SSH)

### 1b. Push Your Code
```powershell
cd C:\Users\BlackCat\Downloads\HMS\QloApps

# Initialize git (if not already done)
git init

# Add remote
git remote add origin https://github.com/YOUR_USERNAME/qloapps-deployment.git

# Stage and commit
git add .
git commit -m "Initial QloApps deployment configuration"

# Push to GitHub
git branch -M main
git push -u origin main
```

---

## Step 2: Connect Render.com to Your Repository

### 2a. On Render Dashboard (https://dashboard.render.com/web/new)

1. **Select deployment method:**
   - Choose: **GitHub** (or GitLab)
   - Click "Connect your GitHub account" if not connected
   - Select your `qloapps-deployment` repository

2. **Configure service:**
   - **Name:** `qloapps`
   - **Environment:** `Docker`
   - **Build Command:** Leave blank (Dockerfile handles it)
   - **Start Command:** Leave blank
   - **Instance Type:** Select **Free** (or Starter if you want better performance)
   - **Region:** Choose closest to you (e.g., Oregon for US)

3. **Environment Variables:**
   - Render will auto-generate secure passwords
   - DB_HOST: `qloapps-mysql.render.internal` (internal Render DNS)
   - DB_NAME: `qloapps`
   - DB_USER: `qloapps`
   - DB_PASSWORD: Auto-generated
   - APP_ENV: `production`

---

## Step 3: Add MySQL Database Service

### 3a. Create MySQL Database on Render

1. Go to https://dashboard.render.com/pserv/new
2. Select **MySQL** from the list
3. Configure:
   - **Name:** `qloapps-mysql`
   - **Database:** `qloapps`
   - **User:** `qloapps`
   - **Password:** Let Render generate
   - **Region:** Same as web service
   - **Plan:** Free tier

4. **Copy the Internal Database URL** (looks like: `mysql://user:pass@qloapps-mysql.render.internal:3306/qloapps`)

---

## Step 4: Link Services & Deploy

### 4a. Update Web Service with Database Connection

1. Return to your **qloapps** web service
2. Go to **Environment** tab
3. Add/Update variables:
   ```
   DB_HOST = qloapps-mysql.render.internal
   DB_PORT = 3306
   DB_NAME = qloapps
   DB_USER = qloapps
   DB_PASSWORD = (from MySQL service setup)
   ```

4. Save and trigger deploy (automatic if you set auto-deploy)

### 4b. Monitor Deployment
- Watch the logs in Render dashboard
- Wait for "Deploy successful" message (~5-10 minutes for first build)

---

## Step 5: Access Your App & Configure Subdomain

### 5a. Get Your Render URL
- After deployment, you'll get a URL like: `https://qloapps.onrender.com`
- Test it: Open in browser

### 5b. Connect Your Custom Subdomain (OPTIONAL)

**Option 1: Use Render's Free Subdomain**
- Just use `https://qloapps.onrender.com`
- No additional setup needed

**Option 2: Add Your Custom Domain**
1. Go to Service Settings → Custom Domain
2. Enter your subdomain: `hotel.yourdomain.com`
3. Render provides DNS instructions:
   - Add CNAME record pointing to `qloapps.onrender.com`
   - Update your domain registrar DNS settings

**Option 3: Connect to Your Domain Registrar**
1. Log in to your domain registrar (GoDaddy, Namecheap, etc.)
2. Add CNAME record:
   ```
   Host: hotel (or whatever subdomain)
   Type: CNAME
   Value: qloapps.onrender.com
   TTL: 3600
   ```
3. Save and wait for DNS propagation (5-30 minutes)

---

## Step 6: Complete QloApps Installation

### 6a. Access Installation Wizard
1. Open your deployed app URL: `https://qloapps.onrender.com/install`
2. Follow the Installation Assistant

### 6b. Database Configuration Step
When prompted for database details:
- **Database server:** `qloapps-mysql.render.internal`
- **Database name:** `qloapps`
- **Database login:** `qloapps`
- **Database password:** (the one you generated in Render)
- **Tables prefix:** `qlo_`

3. Complete remaining installation steps

### 6c. Delete Install Folder (SECURITY!)
```bash
# In Render shell terminal
rm -rf /var/www/html/install
```

---

## Step 7: Access Your Application

### Admin Panel:
`https://yourdomain.com/admin` or `https://qloapps.onrender.com/admin`

### Customer Frontend:
`https://yourdomain.com` or `https://qloapps.onrender.com`

---

## Troubleshooting

### Database Connection Failed
- Check if MySQL service is running in Render dashboard
- Verify DB_HOST is exactly: `qloapps-mysql.render.internal`
- Ensure DB credentials match what you set

### Deployment Failed
- Check logs in Render dashboard
- Verify Dockerfile and render.yaml are correct
- Ensure all required files are committed to GitHub

### Slow Performance
- Free tier is limited (~0.5 CPU, 512MB RAM)
- Upgrade to Starter ($7/month) for better performance
- Enable caching in QloApps admin

### SSL Certificate Issues
- Render provides free SSL automatically
- Force HTTPS in QloApps settings if needed

---

## Next Steps After Deployment

1. **Secure your admin:**
   - Change default password
   - Set strong admin username

2. **Configure email:**
   - Set up SMTP for booking confirmations
   - Test email notifications

3. **Add your hotel information:**
   - Rooms, pricing, amenities
   - Payment gateway integration

4. **Set up backups:**
   - Enable database backups in Render
   - Set backup schedule

5. **Monitor performance:**
   - Check Render dashboard for usage
   - Set up alerts for errors

---

## Useful Links
- Render Docs: https://render.com/docs
- QloApps Docs: https://docs.qloapps.com
- Support: https://qloapps.com/contact/

---

**Questions?** Let me know and I can help troubleshoot!
