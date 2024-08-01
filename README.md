Sure, let's go through the steps to create a Scrapy spider for downloading text files from the Project Gutenberg Australia website from scratch..

### Step-by-Step Guide to Create a Scrapy Spider

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

Inside your project directory, create a new spider. We'll call it `gutenberg_spider.py`.

```sh
cd gutenberg_scraper/spiders
touch gutenberg_spider.py
```

#### 4. Define the Spider

Open `gutenberg_spider.py` in a text editor and define the spider:

```python
import scrapy
import os
from urllib.parse import urljoin

class GutenbergSpider(scrapy.Spider):
    name = "gutenberg"
    allowed_domains = ['gutenberg.net.au']
    start_urls = ['http://gutenberg.net.au/']

    def parse(self, response):
        for link in response.css('a::attr(href)').getall():
            url = urljoin(response.url, link)
            if url.endswith('.txt'):
                yield scrapy.Request(url, callback=self.save_text_file)
            elif self.allowed_domains[0] in url:
                yield scrapy.Request(url, callback=self.parse)

    def save_text_file(self, response):
        file_name = response.url.split('/')[-1]
        save_path = os.path.join('downloaded_texts', file_name)
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        with open(save_path, 'wb') as f:
            f.write(response.body)
        self.log(f'Saved file {file_name}', level=scrapy.log.INFO)
```

### Explanation:

1. **Imports**: Import the necessary modules.
2. **Spider Class**: Define a class `GutenbergSpider` that inherits from `scrapy.Spider`.
3. **Name and Domains**: Set the name and allowed domains for the spider.
4. **Start URLs**: Define the starting point of the spider.
5. **Parse Method**: The main method for processing responses and following links.
   - **Follow Links**: Check if the link ends with `.txt` and download it, otherwise follow the link if it’s within the allowed domain.
6. **Save Text File Method**: Save the downloaded text file to a local directory.

#### 5. Create the Output Directory

Ensure the directory for saving the downloaded files exists:

```sh
mkdir -p downloaded_texts
```

#### 6. Run the Spider

Navigate back to the project root directory (where `scrapy.cfg` is located) and run the spider:

```sh
scrapy crawl gutenberg
```

This command starts the spider, which will crawl the Project Gutenberg Australia website, follow links, and download all text files it finds into the `downloaded_texts` directory.

By following these steps, you should be able to create a Scrapy spider that efficiently downloads text files from the Project Gutenberg Australia website. If you encounter any issues or need further customization, feel free to ask!
