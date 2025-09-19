#!/bin/bash

# Cloudflare Pages Setup Script
set -e

echo "🚀 Setting up Cloudflare Pages deployment..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if wrangler is installed
if ! command -v wrangler &> /dev/null; then
    echo -e "${YELLOW}Installing Wrangler CLI...${NC}"
    npm install -g wrangler
fi

# Login to Cloudflare
echo -e "${BLUE}Please login to Cloudflare...${NC}"
wrangler login

# Get project name from user or use default
read -p "Enter your Cloudflare Pages project name (default: template-blog-webapp-nextjs): " PROJECT_NAME
PROJECT_NAME=${PROJECT_NAME:-template-blog-webapp-nextjs}

# Create Cloudflare Pages project
echo -e "${BLUE}Creating Cloudflare Pages project: ${PROJECT_NAME}${NC}"
wrangler pages project create "$PROJECT_NAME" || echo -e "${YELLOW}Project may already exist, continuing...${NC}"

# Update wrangler.toml with the project name
echo -e "${BLUE}Updating wrangler.toml with project name...${NC}"
sed -i.bak "s/name = \"template-blog-webapp-nextjs\"/name = \"$PROJECT_NAME\"/" wrangler.toml

# Prompt for environment variables
echo -e "${YELLOW}Setting up environment variables...${NC}"
echo "You'll need to provide the following Contentful credentials:"

read -p "Contentful Space ID: " CONTENTFUL_SPACE_ID
read -p "Contentful Access Token: " CONTENTFUL_ACCESS_TOKEN
read -p "Contentful Preview Access Token: " CONTENTFUL_PREVIEW_ACCESS_TOKEN
read -s -p "Contentful Preview Secret: " CONTENTFUL_PREVIEW_SECRET
echo

# Set environment variables
echo -e "${BLUE}Setting environment variables for production...${NC}"
echo "$CONTENTFUL_SPACE_ID" | wrangler pages secret put CONTENTFUL_SPACE_ID --project-name="$PROJECT_NAME"
echo "$CONTENTFUL_ACCESS_TOKEN" | wrangler pages secret put CONTENTFUL_ACCESS_TOKEN --project-name="$PROJECT_NAME"
echo "$CONTENTFUL_PREVIEW_ACCESS_TOKEN" | wrangler pages secret put CONTENTFUL_PREVIEW_ACCESS_TOKEN --project-name="$PROJECT_NAME"
echo "$CONTENTFUL_PREVIEW_SECRET" | wrangler pages secret put CONTENTFUL_PREVIEW_SECRET --project-name="$PROJECT_NAME"

# Update package.json deploy script
echo -e "${BLUE}Updating package.json deploy script...${NC}"
sed -i.bak "s/template-blog-webapp-nextjs/$PROJECT_NAME/g" package.json

# Test build
echo -e "${BLUE}Testing build process...${NC}"
yarn build:cloudflare

# Deploy
echo -e "${BLUE}Deploying to Cloudflare Pages...${NC}"
wrangler pages deploy .vercel/output/static --project-name="$PROJECT_NAME"

# Get deployment URL
DEPLOYMENT_URL=$(wrangler pages project list | grep "$PROJECT_NAME" | awk '{print $3}' | head -1)

echo -e "${GREEN}✅ Deployment complete!${NC}"
echo -e "${GREEN}📍 Your site is available at: https://$DEPLOYMENT_URL${NC}"
echo -e "${YELLOW}📝 Don't forget to set up GitHub Actions secrets for automated deployment!${NC}"
echo -e "${BLUE}📖 See CLOUDFLARE_DEPLOYMENT.md for detailed instructions.${NC}"

# Display next steps
echo -e "\n${BLUE}🔧 Next Steps:${NC}"
echo "1. Set up GitHub repository secrets (see CLOUDFLARE_DEPLOYMENT.md)"
echo "2. Push your code to trigger automated deployment"
echo "3. Configure custom domain if needed in Cloudflare dashboard"
echo "4. Set up environment variables for different environments"

echo -e "\n${GREEN}🎉 Cloudflare Pages setup complete!${NC}"