# 🌟 Scraping Project Gutenberg Australia for Training Southern Cross AI's Baby Joey Model 🌟

I want to say thank you to the Gutenberg Australia volunteers for helping put these collections together, and a special thanks to the primary person behind the establishment of Project Gutenberg Australia, **Colin Choat**. He initiated the project in 1997, aiming to provide free access to a variety of literary works that are in the public domain in Australia. Without his hard work and years of commitment, this would not have been possible. 🙏😊

This repo is for training a large language model (LLM) with Southern Cross AI, and one of our first models is Baby Joey. 🐨

**Warning: ⚠️ Do not run this script without proper permissions from Project Gutenberg Australia. There is no need to do so, as this repo holds all the same data. The approximate sizes of the data are as follows:**

- **Text files**: 881 MB
- **HTML files**: 1.8 GB
- **DOC files**: 26 MB
- **EPUB files**: 449 MB
- **PDF files**: 118 MB
- **MOBI files**: 511 MB
- **Total**: 3.8 GB

### 📂 Repository Structure and Scraped Data Location:

- 📂 The downloaded files will be stored in: `gutenberg_scraper/downloaded_files`
- 🕸️ The spider script can be found at: `gutenberg_scraper/gutenberg_scraper/spiders/gutenberg_spider.py`

Once you have cloned this repository, you will have all the same data that was scraped from Project Gutenberg Australia. There is no need to scrape the website again. We want to respect the users of the website and not slow it down by constantly scraping it. 🙌

---

Let's go through the steps to create a Scrapy spider for downloading text files from the Project Gutenberg Australia website from scratch.

### 🕸️ Step-by-Step Guide to Create a Scrapy Spider 🕸️

#### 1. Install Scrapy

First, install Scrapy if you haven't already:

```sh
pip install scrapy
```

#### 2. Create a New Scrapy Project

Open a terminal and create a new Scrapy project:

```sh
scrapy startproject gutenberg_scraper
cd gutenberg_scraper
```

#### 3. Create a New Spider

Inside your project directory, create a new spider script. We'll call it `gutenberg_spider.py`:

```sh
cd gutenberg_scraper/spiders
touch gutenberg_spider.py
```

#### 4. Define the Spider

Open `gutenberg_spider.py` in a text editor and define the spider with the following code:

```python
import scrapy
import os
from urllib.parse import urljoin

class GutenbergSpider(scrapy.Spider):
    name = "gutenberg"
    allowed_domains = ['gutenberg.net.au']
    start_urls = ['http://gutenberg.net.au/']

    def parse(self, response):
        # Check if the response is a text file or an HTML file
        if response.headers.get('Content-Type', b'').decode('utf-8').startswith('text'):
            for link in response.css('a::attr(href)').getall():
                url = urljoin(response.url, link)
                if any(url.endswith(ext) for ext in ['.txt', '.html', '.epub', '.mobi', '.pdf', '.doc']):
                    yield scrapy.Request(url, callback=self.save_file)
                elif self.allowed_domains[0] in url:
                    yield scrapy.Request(url, callback=self.parse)
        else:
            # If not a text file, handle as binary file directly
            self.save_file(response)

    def save_file(self, response):
        file_name = response.url.split('/')[-1]
        file_extension = file_name.split('.')[-1]

        # Determine the folder based on file extension
        folder_map = {
            'txt': 'downloaded_files/txt_files',
            'html': 'downloaded_files/html_files',
            'epub': 'downloaded_files/epub_files',
            'mobi': 'downloaded_files/mobi_files',
            'pdf': 'downloaded_files/pdf_files',
            'doc': 'downloaded_files/doc_files'
        }

        folder = folder_map.get(file_extension, 'downloaded_files/others')
        save_path = os.path.join(folder, file_name)
        os.makedirs(os.path.dirname(save_path), exist_ok=True)

        with open(save_path, 'wb') as f:
            f.write(response.body)

        self.logger.info(f'Saved file {file_name}')
```

### 📝 Explanation:

1. **Imports**: Import the necessary modules.
2. **Spider Class**: Define a class `GutenbergSpider` that inherits from `scrapy.Spider`.
3. **Name and Domains**: Set the name and allowed domains for the spider.
4. **Start URLs**: Define the starting point of the spider.
5. **Parse Method**: The main method for processing responses and following links.
   - **Check Content-Type**: Determine if the response is a text file or an HTML file.
   - **Follow Links**: Check if the link ends with specific file extensions and download it; otherwise, follow the link if it’s within the allowed domain.
   - **Handle Binary Files**: Save binary files directly.
6. **Save File Method**: Save the downloaded file to a local directory based on its extension.

#### 5. Run the Spider

Navigate back to the project root directory (where `scrapy.cfg` is located) and run the spider:

```sh
scrapy crawl gutenberg
```

This command starts the spider, which will crawl the Project Gutenberg Australia website, follow links, and download all text files it finds into the appropriate folders within the `downloaded_files` directory.

By following these steps, you should be able to understand how we used a Scrapy spider that efficiently downloaded text files from the Project Gutenberg Australia website. If you encounter any issues or need further customization, feel free to ask! 😊
