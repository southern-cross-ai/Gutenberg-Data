#!/bin/bash

# Prompt the user for the project name and website URL
read -p "Enter the project name: " PROJECT_NAME
read -p "Enter the website URL: " WEBSITE_URL

# Convert project name to lowercase for the spider name and branch name
SPIDER_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]')
BRANCH_NAME=$(echo "$PROJECT_NAME" | tr '[:upper:]' '[:lower:]' | tr ' ' '-')

# Check if Git is installed
if ! command -v git &> /dev/null; then
    echo "Git is not installed. Please install Git and try again."
    exit 1
fi

# Check if the branch already exists
if git show-ref --verify --quiet refs/heads/"$BRANCH_NAME"; then
    echo "Branch '$BRANCH_NAME' already exists. Please use that Spider or remove the Git branch and start again."
    exit 1
fi

# Create a new branch with the project name
git checkout -b "$BRANCH_NAME"
echo "A new Git branch '$BRANCH_NAME' has been created."

echo "Installing Scrapy... Please wait..."

# Install Scrapy
if ! pip install scrapy > /dev/null 2>&1; then
    echo "Failed to install Scrapy. Please check your Python and pip installation and try again."
    exit 1
fi

echo "Scrapy has been installed."

# Create project and suppress output
if scrapy startproject "$PROJECT_NAME" > /dev/null 2>&1; then
    echo "Project '$PROJECT_NAME' has been created in the '$PROJECT_NAME' directory."
    echo 'worked'
else
    echo "Failed to create the Scrapy project. Please check for errors."
    exit 1
fi

# Navigate to the spiders directory
cd "$PROJECT_NAME/$PROJECT_NAME/spiders" || exit

# Create the spider file with instructions
cat <<EOL > "${SPIDER_NAME}_spider.py"
import scrapy
from urllib.parse import urljoin

class ${PROJECT_NAME^}Spider(scrapy.Spider):
    name = "$SPIDER_NAME"
    allowed_domains = ['${WEBSITE_URL#http://}', 'www.${WEBSITE_URL#http://}']
    start_urls = ['$WEBSITE_URL']

    def parse(self, response):
        # Instructions:
        # 1. Use response.css() or response.xpath() to select elements from the response.
        # 2. Use urljoin(response.url, link) to join relative URLs.
        # 3. Use yield scrapy.Request(url, callback=self.parse) to follow links and parse them.
        # 4. Use yield {'field_name': value} to store scraped data.

        # Example:
        # for link in response.css('a::attr(href)').getall():
        #     url = urljoin(response.url, link)
        #     if url.endswith('.txt'):
        #         yield scrapy.Request(url, callback=self.save_text_file)
        #     elif any(domain in url for domain in self.allowed_domains):
        #         yield scrapy.Request(url, callback=self.parse)
        pass

    def save_text_file(self, response):
        # Instructions:
        # 1. Use response.url.split('/')[-1] to get the filename.
        # 2. Use os.path.join('downloaded_texts', file_name) to set the save path.
        # 3. Use os.makedirs(os.path.dirname(save_path), exist_ok=True) to create the directory if it doesn't exist.
        # 4. Use with open(save_path, 'wb') as f: to open a file for writing.
        # 5. Use f.write(response.body) to write the response body to the file.
        pass
EOL

# Navigate to the root directory of the project
cd ../..

# Create the directory for downloaded texts
mkdir -p downloaded_texts

echo "Project '$PROJECT_NAME' has been set up successfully with the spider targeting '$WEBSITE_URL'."
