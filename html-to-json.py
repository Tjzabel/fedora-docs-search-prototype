from lxml import html
import requests
import re

def get_sitemaps(url):
    page = requests.get(url)
    tree = html.fromstring(page.content)
    return tree.xpath('//sitemapindex/sitemap/loc/text()')

def get_pages(url):
    page = requests.get(url)
    tree = html.fromstring(page.content)
    return tree.xpath('//urlset/url/loc/text()')

def get_data(url):
    page = requests.get(url)
    tree = html.fromstring(page.content)
    data = {}
    data["title"] = re.sub(r'\W+', ' ', tree.xpath('//h1/text()')[0])
    data["body"] = re.sub(r'\W+', ' ', tree.xpath('/html/body/div/main/article')[0].text_content())
    data["component"] = {}
    data["component"]["name"] = tree.xpath('/html/body/div/div/aside/div/div[1]/nav/h3/a/text()')[0]
    data["url"] = url
    return data

