# 🧹 Data Collection, Cleaning, and Organization

This repository contains scripts and templates for collecting, cleaning, and organizing data. 

GitHub Git Large File Storage (Git LFS) is enabled in Southern Cross AI, allowing large files to be pushed and pulled from this repository after the initial scraping of any website. This helps to prevent putting too much pressure on any one website.

---

> **📝 Note:**
> 
> Each dataset is managed on its own branch.
> 
> - **To check existing datasets:** Browse the branches to see what datasets are already available.
> - **To add a new dataset:** 
>   1. Create a new branch.
>   2. Develop a spider in that branch.
>   3. Collect and commit the datasets to that branch.
> - **Project naming:** The project name should refer to the data source being scraped, and proper credit should be given to the original data source in your project documentation.
> 
> This format provides clear instructions and emphasizes the steps for adding new datasets. This approach also ensures that when you clone the repository, only the files you need for a specific dataset are downloaded. Switch to the relevant branch to access and pull the dataset you need.

---

## 🌟 Setting Up a Dataset

There are two ways to set up a dataset in this repository:

1. **Automated Setup using the provided script**
2. **Manual Setup**

## 🚀 Automated Setup Using the Provided Script

This script automates the setup of a Scrapy project and creates a basic spider template with instructions for customization.

### Prerequisites

- 🐍 Python 3.x
- 📦 pip (Python package installer)
- 🐙 Git

### Usage

#### Clone the Repository

Clone this repository to your local machine:

```bash
git clone https://github.com/southern-cross-ai/DataCleaning.git
cd DataCleaning
```

#### Make the Script Executable

Open a terminal and navigate to the directory where the script is located. Make the script executable by running:

```bash
chmod +x setup_project.sh
```

#### Run the Script

Run the script and follow the prompts to enter the project name and website URL:

```bash
./setup_project.sh
```

#### Navigate to the Project Directory

After the script completes, navigate to your project directory:

```bash
cd <project_name>
```

#### Customize Your Spider

Open the `<project_name>/spiders/<project_name>_spider.py` file and add your scraping logic. The file contains instructions and example code to help you get started.

#### Run the Spider

Run the spider to start scraping data:

```bash
scrapy crawl <project_name>
```

### Example

Here’s an example of how to set up and run a Scrapy project named `example_project` targeting `http://example.com`:

#### Run the Setup Script

```bash
./setup_project.sh
```

- Enter the project name: `example_project`
- Enter the website URL: `http://example.com`

#### Navigate to the Project Directory

```bash
cd example_project
```

#### Customize the Spider

Open the spider file and add your scraping logic:

```python
import scrapy
from urllib.parse import urljoin

class ExampleProjectSpider(scrapy.Spider):
    name = "example_project"
    allowed_domains = ['example.com', 'www.example.com']
    start_urls = ['http://example.com']

    def parse(self, response):
        # Add your parsing logic here
        pass

    def save_text_file(self, response):
        # Add your file saving logic here
        pass
```

#### Run the Spider

```bash
scrapy crawl example_project
```

## 🔧 Manual Setup

If you prefer to set up the Scrapy project manually, follow these steps:

### Create a New Branch

Create a new branch for your dataset:

```bash
git checkout -b <branch_name>
```

### Install Scrapy

Ensure you have Scrapy installed. If not, you can install it using pip:

```bash
pip install scrapy
```

### Create a Scrapy Project

Create a new Scrapy project:

```bash
scrapy startproject <project_name>
cd <project_name>
```

### Create a Spider

Navigate to the `spiders` directory and create a new spider file:

```bash
cd <project_name>/spiders
touch <project_name>_spider.py
```

### Add Spider Logic

Open the `<project_name>_spider.py` file and add your scraping logic. Below is a template to get you started:

```python
import scrapy
from urllib.parse import urljoin

class ExampleProjectSpider(scrapy.Spider):
    name = "<project_name>"
    allowed_domains = ['example.com', 'www.example.com']
    start_urls = ['http://example.com']

    def parse(self, response):
        # Add your parsing logic here
        pass

    def save_text_file(self, response):
        # Add your file saving logic here
        pass
```

### Create Directory for Downloaded Texts

Navigate back to the root directory of the project and create a directory for downloaded texts:

```bash
cd ../..
mkdir downloaded_texts
```

### Run the Spider

Run the spider to start scraping data:

```bash
scrapy crawl <project_name>
```

## 🛠 Troubleshooting

### Git is not installed

If you see an error message indicating that Git is not installed, please install Git by following the instructions at [https://git-scm.com/book/en/v2/Getting-Started-Installing-Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

### Scrapy installation failed

If the script fails to install Scrapy, ensure that you have pip installed and your Python environment is set up correctly. You can try installing Scrapy manually by running:

```bash
pip install scrapy
```

## 🤝 Contributing

If you have suggestions for improving this script, please feel free to open an issue or submit a pull request.
