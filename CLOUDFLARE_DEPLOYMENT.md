# Cloudflare Pages Deployment Guide

This project is configured for automated deployment to Cloudflare Pages using GitHub Actions.

## 🚀 Automated Deployment Setup

### 1. Repository Secrets Configuration

Add the following secrets to your GitHub repository (`Settings > Secrets and variables > Actions`):

#### Required Secrets:
```
CLOUDFLARE_API_TOKEN          # Your Cloudflare API token with Pages:Edit permissions
CLOUDFLARE_ACCOUNT_ID         # Your Cloudflare Account ID
CONTENTFUL_SPACE_ID           # Your Contentful Space ID
CONTENTFUL_ACCESS_TOKEN       # Your Contentful Content Delivery API token
CONTENTFUL_PREVIEW_ACCESS_TOKEN   # Your Contentful Preview API token
CONTENTFUL_PREVIEW_SECRET     # Secret for preview mode authentication
```

#### Repository Variables:
```
NEXT_PUBLIC_BASE_URL          # Your production domain (e.g., https://yourdomain.pages.dev)
```

### 2. Getting Cloudflare Credentials

#### Cloudflare API Token:
1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/profile/api-tokens)
2. Click "Create Token"
3. Use "Custom token" template
4. Set permissions:
   - `Account` - `Cloudflare Pages:Edit`
   - `Zone` - `Zone:Read` (if using custom domain)
5. Set Account Resources: `Include - [Your Account]`
6. Copy the generated token

#### Cloudflare Account ID:
1. Go to [Cloudflare Dashboard](https://dash.cloudflare.com/)
2. Select your account
3. Find "Account ID" in the right sidebar
4. Copy the Account ID

### 3. Contentful Setup

#### Getting Contentful Credentials:
1. Go to your [Contentful Space](https://app.contentful.com/)
2. Navigate to `Settings > API keys`
3. Create or use existing API key
4. Copy:
   - Space ID
   - Content Delivery API access token
   - Content Preview API access token
5. Create a unique preview secret (random string)

## 📦 Manual Deployment

### Local Build and Deploy:
```bash
# Install Wrangler CLI (if not installed)
npm install -g wrangler

# Login to Cloudflare
wrangler login

# Create Cloudflare Pages project (first time only)
wrangler pages project create template-blog-webapp-nextjs

# Build the project
yarn build:cloudflare

# Deploy to Cloudflare Pages
wrangler pages deploy .vercel/output/static --project-name=template-blog-webapp-nextjs
```

### Environment Variables Setup:
```bash
# Set production environment variables
wrangler pages secret put CONTENTFUL_SPACE_ID --project-name=template-blog-webapp-nextjs
wrangler pages secret put CONTENTFUL_ACCESS_TOKEN --project-name=template-blog-webapp-nextjs
wrangler pages secret put CONTENTFUL_PREVIEW_ACCESS_TOKEN --project-name=template-blog-webapp-nextjs
wrangler pages secret put CONTENTFUL_PREVIEW_SECRET --project-name=template-blog-webapp-nextjs
```

## 🔄 Deployment Workflow

### Automatic Deployment Triggers:
- **Production**: Push to `main` or `master` branch
- **Preview**: Pull requests to `main` or `master` branch

### Build Process:
1. Checkout code
2. Setup Node.js 18
3. Install dependencies with Yarn
4. Build Next.js application with Cloudflare optimizations
5. Deploy to Cloudflare Pages

### Build Output:
- Location: `.vercel/output/static/`
- Contains: Static assets and Cloudflare Workers functions

## 🛠 Troubleshooting

### Common Issues:

#### 1. Build Timeouts
- The project skips TypeScript type checking and ESLint during builds for speed
- If builds still timeout, check Contentful API connectivity

#### 2. Environment Variables
- Ensure all required secrets are set in GitHub repository
- Verify Contentful credentials are valid
- Check that NEXT_PUBLIC_BASE_URL matches your domain

#### 3. Deployment Failures
- Verify Cloudflare API token has correct permissions
- Check that the Cloudflare project name matches in wrangler.toml
- Ensure Account ID is correct

### Debug Commands:
```bash
# Test local build
yarn build:cloudflare

# Check wrangler configuration
wrangler pages project list

# View deployment logs
wrangler pages deployment list --project-name=template-blog-webapp-nextjs
```

## 📋 Project Structure

```
.vercel/output/static/          # Cloudflare Pages build output
├── _worker.js/                 # Cloudflare Workers functions
├── _next/                      # Next.js static assets
└── ...                         # Other static files
```

## 🔗 Useful Links

- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
- [Next.js on Cloudflare Pages](https://developers.cloudflare.com/pages/framework-guides/deploy-a-nextjs-site/)
- [Wrangler CLI Documentation](https://developers.cloudflare.com/workers/wrangler/)
- [GitHub Actions for Cloudflare Pages](https://github.com/cloudflare/pages-action)