# 🚀 Automated Cloudflare Pages Deployment

This project is now fully configured for automated deployment to Cloudflare Pages!

## ✅ What's Been Set Up

### 1. **GitHub Actions Workflow** (`.github/workflows/cloudflare-pages.yml`)
- Automatic deployment on push to `main`/`master` branches
- Preview deployments for pull requests
- Optimized build process with caching
- Environment variable management

### 2. **Cloudflare Configuration**
- **`wrangler.toml`**: Production and preview environment setup
- **`_headers`**: Security headers and caching rules
- **`_redirects`**: SPA routing and internationalization redirects

### 3. **Build Optimization**
- **`next.config.js`**: Cloudflare Workers compatible configuration
- **`package.json`**: Updated build scripts and deployment commands
- TypeScript and ESLint checks disabled during builds for speed

### 4. **Setup Automation**
- **`scripts/setup-cloudflare.sh`**: One-click deployment setup script
- **`CLOUDFLARE_DEPLOYMENT.md`**: Comprehensive deployment guide

## 🎯 Quick Start

### Option 1: Automated Setup (Recommended)
```bash
# Run the setup script
./scripts/setup-cloudflare.sh
```

### Option 2: Manual Setup
1. **Install Wrangler CLI**
   ```bash
   npm install -g wrangler
   wrangler login
   ```

2. **Create Cloudflare Pages Project**
   ```bash
   wrangler pages project create your-project-name
   ```

3. **Build and Deploy**
   ```bash
   yarn build:cloudflare
   yarn deploy:cloudflare
   ```

### Option 3: GitHub Actions (Fully Automated)
1. **Set up repository secrets** (see below)
2. **Push to main branch** - deployment happens automatically!

## 🔐 Required GitHub Secrets

Add these in your GitHub repository (`Settings > Secrets and variables > Actions`):

```
CLOUDFLARE_API_TOKEN              # Cloudflare API token with Pages:Edit permissions
CLOUDFLARE_ACCOUNT_ID             # Your Cloudflare Account ID
CONTENTFUL_SPACE_ID               # Contentful Space ID
CONTENTFUL_ACCESS_TOKEN           # Contentful Content Delivery API token
CONTENTFUL_PREVIEW_ACCESS_TOKEN   # Contentful Preview API token
CONTENTFUL_PREVIEW_SECRET         # Secret for preview authentication
```

**Repository Variables:**
```
NEXT_PUBLIC_BASE_URL              # Your production domain
```

## 📋 Available Commands

```bash
# Development
yarn dev                    # Start development server

# Building
yarn build                  # Standard Next.js build
yarn build:cloudflare      # Build for Cloudflare Pages

# Deployment
yarn deploy:cloudflare     # Deploy to Cloudflare Pages
yarn preview:cloudflare    # Build and deploy in one command

# Utilities
yarn lint                  # Run ESLint
yarn type-check           # Run TypeScript checks
```

## 🔄 Deployment Flow

### Automatic (GitHub Actions):
1. **Push to main** → Production deployment
2. **Open PR** → Preview deployment
3. **Merge PR** → Production deployment updated

### Manual:
1. `yarn build:cloudflare` → Build optimized for Cloudflare
2. `yarn deploy:cloudflare` → Deploy to Cloudflare Pages

## 🛠 Key Features

- **Zero-config deployment** with GitHub Actions
- **Preview deployments** for pull requests
- **Optimized builds** (no TypeScript/ESLint checks during deployment)
- **Security headers** automatically applied
- **Caching rules** for optimal performance
- **Internationalization** support with redirects
- **Environment variable** management

## 📚 Documentation

- **`CLOUDFLARE_DEPLOYMENT.md`**: Detailed deployment guide
- **`scripts/setup-cloudflare.sh`**: Automated setup script
- **`.github/workflows/cloudflare-pages.yml`**: CI/CD workflow

## 🆘 Need Help?

1. **Check the logs** in GitHub Actions
2. **Review** `CLOUDFLARE_DEPLOYMENT.md` for troubleshooting
3. **Verify** all secrets are correctly set
4. **Test locally** with `yarn build:cloudflare`

---

**🎉 Your project is ready for Cloudflare Pages deployment!**

The next push to your main branch will automatically trigger a deployment. 🚀