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
            if any(url.endswith(ext) for ext in ['.txt', '.html', '.epub', '.mobi', '.pdf']):
                yield scrapy.Request(url, callback=self.save_file)
            elif self.allowed_domains[0] in url:
                yield scrapy.Request(url, callback=self.parse)

    def save_file(self, response):
        file_name = response.url.split('/')[-1]
        file_extension = file_name.split('.')[-1]
        
        # Determine the folder based on file extension
        folder_map = {
            'txt': 'downloaded_files/txt_files',
            'html': 'downloaded_files/html_files',
            'epub': 'downloaded_files/epub_files',
            'mobi': 'downloaded_files/mobi_files',
            'pdf': 'downloaded_files/pdf_files'
        }

        folder = folder_map.get(file_extension, 'downloaded_files/others')
        save_path = os.path.join(folder, file_name)
        os.makedirs(os.path.dirname(save_path), exist_ok=True)
        
        with open(save_path, 'wb') as f:
            f.write(response.body)
        
        self.log(f'Saved file {file_name}', level=scrapy.log.INFO)
